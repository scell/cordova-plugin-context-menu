#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface NativeContextMenuPlugin : CDVPlugin {

}

- (void) doMenu:(CDVInvokedUrlCommand*)command;

@end
