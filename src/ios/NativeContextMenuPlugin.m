#import "NativeContextMenuPlugin.h"

@interface NativeContextMenuPlugin (Private)

// nothing is private at this time

@end

@implementation NativeContextMenuPlugin

- (void) doMenu:(CDVInvokedUrlCommand*)command
{
    //NSLog(@"Called NativeContextMenuPlugin.doMenu");

    CDVPluginResult* pluginResult = nil;

    NSArray* arguments                = [command arguments];
    NSMutableDictionary* options      = [arguments objectAtIndex:0];

    // process options
    NSString* title  = [options objectForKey:@"title"];
    NSString* cancel  = [options objectForKey:@"cancel"];
    if ([cancel length] == 0){ cancel = @"Cancel"; }

    NSArray* buttons = [options objectForKey:@"buttons"];
    int buttonsCount = [buttons count];
    if(buttonsCount == 0){
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"buttons was null or empty"];

      // send "failed" back to cordova
      [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
      return;
    }
    NSString* destructive  = [options objectForKey:@"destructive"];
    if ([destructive length] != 0){ buttonsCount++; }

    UIActionSheet *actionSheet = [[UIActionSheet alloc]
        initWithTitle:title
        delegate:self
        cancelButtonTitle:nil
        destructiveButtonTitle:destructive
        otherButtonTitles:nil
    ];

    // http://stackoverflow.com/questions/2384044/create-uiactionsheet-otherbuttons-by-passing-in-array-not-varlist
    // =========================================================================
    // ObjC Fast Enumeration
    for (NSString *title in buttons) {
        [actionSheet addButtonWithTitle:title];
    }

    [actionSheet addButtonWithTitle:cancel];
    actionSheet.cancelButtonIndex = buttonsCount;
    // =========================================================================

    [actionSheet showInView:self.webView];

    // send "all good" back to cordova
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    return;
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {

    //NSLog(@"Called NativeContextMenuPlugin.actionSheet with buttonIndex of (%i)", buttonIndex);

    NSString *jsString =
        @"cordova.fireDocumentEvent('onNativeContextMenuClose', { "
            @"'buttonIndex': %i, "
            @"'destructiveButtonIndex': %i, "
            @"'cancelButtonIndex': %i"
        @" });";

    [self writeJavascript:[NSString
        stringWithFormat:jsString,
        buttonIndex,
        popup.destructiveButtonIndex,
        popup.cancelButtonIndex
    ]];
}
@end
