//
//  AppDelegate.m
//  CocoaOpenNI
//
//  Created by John Boiles on 1/13/12.
//  Copyright (c) 2012 John Boiles. All rights reserved.
//

#import "AppDelegate.h"
#import "CocoaOpenNI.h"
#import "DepthView.h"

@implementation AppDelegate

@synthesize window=_window;

- (void)display {
  // Read next available data
  // If we skip this, the view will appear paused
  if ([CocoaOpenNI sharedOpenNI].started) {
    // Sometimes we get a crash in here
    [[CocoaOpenNI sharedOpenNI] context].WaitAndUpdateAll();
    [_depthView setNeedsDisplay:YES];
  }
}

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [_window setAspectRatio:NSMakeSize(640, 480)];
  [[CocoaOpenNI sharedOpenNI] startWithConfigPath:[[NSBundle mainBundle] pathForResource:@"KinectConfig" ofType:@"xml"]];
  [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(display) userInfo:nil repeats:YES];
}

@end

