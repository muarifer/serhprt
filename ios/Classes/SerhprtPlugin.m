#import "SerhprtPlugin.h"
#import <serhprt/serhprt-Swift.h>

@implementation SerhprtPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSerhprtPlugin registerWithRegistrar:registrar];
}
@end
