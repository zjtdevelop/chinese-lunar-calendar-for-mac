//
//  CLCPopController.m
//  chinese lunar calendar
//
//  Created by Zhengfa DANG on 9/25/14.
//  Copyright (c) 2014 Zhengfa. All rights reserved.
//

#import "CLCPopController.h"
#import "UpdateWindowController.h"
#import <WebKit/WebKit.h>

@interface CLCPopController ()
    @property (strong) UpdateWindowController *updateWindow;
@end


@implementation CLCPopController

@synthesize webView;

- (void)viewDidLoad {
//    [super viewDidLoad];
    // Do view setup here.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // remove blue shadow of NSButton
        [[self view] setFocusRingType:NSFocusRingTypeNone];
//        [self.showAboutMenu setRefusesFirstResponder:TRUE];
    }

    return self;
}


- (IBAction)showMenu:(id)sender {
    NSRect frame = [(NSButton *)sender frame];
    NSPoint menuOrigin = [[(NSButton *)sender superview] convertPoint:NSMakePoint(frame.origin.x, frame.origin.y) toView:nil];

    NSEvent *event =  [NSEvent mouseEventWithType:NSLeftMouseDown
                                         location:menuOrigin
                                    modifierFlags:0
                                        timestamp:0
                                     windowNumber:[[(NSButton *)sender window] windowNumber]
                                          context:[[(NSButton *)sender window] graphicsContext]
                                      eventNumber:0
                                       clickCount:1
                                         pressure:1];

    // show about pop menu now
    [NSMenu popUpContextMenu:self.aboutMenu withEvent:event forView:(NSButton *)sender];
}

- (IBAction)showHelp:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://calendar.zfdang.com"]];
}

- (IBAction)showVersion:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/zfdang/chinese-lunar-calendar-for-mac/blob/master/BUILD.md"]];
}

- (IBAction)contactAuthoer:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"mailto:me@zfdang.com?subject=About%20Chinese%20Lunar%20Calendar%20for%20MAC"]];
}

- (IBAction)updateHolidays:(id)sender {
    self.updateWindow = [[UpdateWindowController alloc] initWithWindowNibName:@"UpdateWindowController"];
//    [[self.updateWindow window] setLevel:kCGDesktopWindowLevelKey];
    [NSApp activateIgnoringOtherApps:YES];
    [self.updateWindow showWindow:self];
}


- (void)keyDown:(NSEvent *)theEvent {
//    NSLog(@"%d", [theEvent keyCode]);
    switch ([theEvent keyCode]) {
        case 123:  // left arrow, previous year
            [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(\"BUTTON\")[0].click(); "];
            break;
        case 124:  // right arrow, next year
            [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(\"BUTTON\")[3].click(); "];
            break;
        case 125:  // down arrow, next month
            [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(\"BUTTON\")[2].click(); "];
            break;
        case 126:  // up arrow, previous month
            [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(\"BUTTON\")[1].click(); "];
            break;
        case 36:  // return, back to today
            [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(\"BUTTON\")[4].click(); "];
            break;

        default:
            break;
    }
}

@end
