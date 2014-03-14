#import "NativeContextMenuPlugin.h"

@interface NativeContextMenuPlugin (Private)

// nothing is private at this time

@end

@implementation NativeContextMenuPlugin

- (void) doMenu:(CDVInvokedUrlCommand*)command
{
    NSArray* arguments                = [command arguments];
    NSMutableDictionary* options      = [arguments objectAtIndex:0];

    // process options
    NSString* title  = [options objectForKey:@"title"];
    NSMutableDictionary* items = [options objectForKey:@"items"];

    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter", nil];
    [actionSheet showInView:self.view];

    //UIMenuItem *someAction = [[UIMenuItem alloc]initWithTitle:@"Something" action:@selector(doSomething:)];

    //UIMenuController *menu = [UIMenuController sharedMenuController];
    //menu.menuItems = [NSArray arrayWithObject:someAction];
    //[menu update];
}

- (void) fireEvent:(NSString*)event id:(NSString*)id json:(NSString*)json
{
    NSString *jsString =
        @"cordova.fireDocumentEvent('onContextMenuSelect',"
        @"{ 'msg': '%@' });";
    NSString *msg = "Hello";

    [self writeJavascript:[NSString stringWithFormat:jsString, msg]];
}

@end
