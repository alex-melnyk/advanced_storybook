//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <advanced_storybook/advanced_storybook_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) advanced_storybook_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AdvancedStorybookPlugin");
  advanced_storybook_plugin_register_with_registrar(advanced_storybook_registrar);
}
