#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface NativeContextMenuPlugin : CDVPlugin <UIActionSheetDelegate> {
  
}

- (void) doMenu:(CDVInvokedUrlCommand*)command;

@end
