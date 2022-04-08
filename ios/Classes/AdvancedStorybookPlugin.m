#import "AdvancedStorybookPlugin.h"
#if __has_include(<advanced_storybook/advanced_storybook-Swift.h>)
#import <advanced_storybook/advanced_storybook-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "advanced_storybook-Swift.h"
#endif

@implementation AdvancedStorybookPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAdvancedStorybookPlugin registerWithRegistrar:registrar];
}
@end
