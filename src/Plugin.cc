
#include "Plugin.h"

namespace plugin { namespace NCSA_Dumbno { Plugin plugin; } }

using namespace plugin::NCSA_Dumbno;

plugin::Configuration Plugin::Configure()
	{
	plugin::Configuration config;
	config.name = "NCSA::Dumbno";
	config.description = "A native Bro plugin for https://github.com/ncsa/dumbno";
	config.version.major = 0;
	config.version.minor = 1;
	return config;
	}
