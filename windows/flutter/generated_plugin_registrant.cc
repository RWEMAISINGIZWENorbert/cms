//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <build_info_windows/build_info_windows_plugin_c_api.h>
#include <connectivity_plus/connectivity_plus_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  BuildInfoWindowsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("BuildInfoWindowsPluginCApi"));
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
}
