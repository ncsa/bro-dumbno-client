
#ifndef BRO_PLUGIN_NCSA_DUMBNO
#define BRO_PLUGIN_NCSA_DUMBNO

#include <plugin/Plugin.h>

namespace plugin {
namespace NCSA_Dumbno {

class Plugin : public ::plugin::Plugin
{
protected:
	// Overridden from plugin::Plugin.
	plugin::Configuration Configure() override;
};

extern Plugin plugin;

}
}

#endif
