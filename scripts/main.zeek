@load base/frameworks/cluster

module Dumbno;

# Same as defined in React, so will have same values.
export {
    type Action: enum {
        SHUNT_CONN,
        SHUNT_ORIG,
        SHUNT_RESP,
    };
    type FilterRequest: record {
        src: addr;
        dst: addr;
        sport: count;
        dport: count;
        proto: string;
    };
    global dumbno_server_ip: string = "" &redef;
    global filter: function(c: connection, action: Action): bool;
}

function filter(c: connection, action: Action): bool
{
    local id = c$id;
    local server_ip: string;
    if (dumbno_server_ip != "") {
        server_ip = dumbno_server_ip;
    } else if("manager" in Cluster::nodes) {
        server_ip = fmt("%s", Cluster::nodes["manager"]$ip);
    } else {
        server_ip = "127.0.0.1";
    }
    local msg: string;
    local ok: bool;

    ok = T;

    if(action == SHUNT_ORIG || action == SHUNT_CONN) {
        local oreq = FilterRequest(
            $src=id$orig_h,
            $dst=id$resp_h,
            $sport=port_to_count(id$orig_p),
            $dport=port_to_count(id$resp_p),
            $proto=fmt("%s", get_port_transport_proto(id$resp_p))
        );
        msg = to_json(oreq);
        ok = ok && send_json_udp(server_ip, 9000, msg);
    }
    if(action == SHUNT_RESP || action == SHUNT_CONN) {
        local rreq = FilterRequest(
            $src=id$resp_h,
            $dst=id$orig_h,
            $sport=port_to_count(id$resp_p),
            $dport=port_to_count(id$orig_p),
            $proto=fmt("%s", get_port_transport_proto(id$resp_p))
        );
        msg = to_json(rreq);
        ok = ok && send_json_udp(server_ip, 9000, msg);
    }
    return ok;
}
