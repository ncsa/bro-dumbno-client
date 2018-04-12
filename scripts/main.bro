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
}

hook dumbno_filter(c: connection, action: Action)
{
    local id = c$id;
    local cmd = fmt("%s/filter-arista-dumbno.py", @DIR);
    local manager_ip = fmt("%s", Cluster::nodes["manager"]$ip);
    local stdin = "";

    if(action == SHUNT_ORIG || action == SHUNT_CONN) {
        local req = FilterRequest(
            $src=id$orig_h,
            $dst=id$resp_h,
            $sport=port_to_count(id$orig_p),
            $dport=port_to_count(id$resp_p),
            $proto=fmt("%s", get_port_transport_proto(id$resp_p))
        );
        local msg = to_json(req);
        print msg;
        send_json_udp(manager_ip, 9000, msg);
        }
    }
    if(action == SHUNT_RESP || action == SHUNT_CONN) {
        local req = FilterRequest(
            $src=id$resp_h,
            $dst=id$orig_h,
            $sport=port_to_count(id$resp_p),
            $dport=port_to_count(id$orig_p),
            $proto=fmt("%s", get_port_transport_proto(id$resp_p))
        );
        local msg = to_json(req);
        print msg;
        send_json_udp(manager_ip, 9000, msg);
        }
        }
    }
}
