
#ifndef BRO_PLUGIN_NCSA_DUMBNO
#define BRO_PLUGIN_NCSA_DUMBNO

#include <plugin/Plugin.h>

namespace zeek {
namespace plugin {
namespace NCSA_Dumbno {

class Plugin : public zeek::plugin::Plugin
{
protected:
	// Overridden from plugin::Plugin.
	zeek::plugin::Configuration Configure() override;
};

extern Plugin plugin;

}
}
}

#endif
