
#include "Plugin.h"

namespace zeek { namespace plugin { namespace NCSA_Dumbno { Plugin plugin; } } }

using namespace zeek::plugin::NCSA_Dumbno;

zeek::plugin::Configuration Plugin::Configure()
	{
	plugin::Configuration config;
	config.name = "NCSA::Dumbno";
	config.description = "A native Zeek plugin for https://github.com/ncsa/dumbno";
	config.version.major = 0;
	config.version.minor = 1;
	return config;
	}
