//
//  AppDelegate.h
//  CocoaOpenNI
//
//  Created by John Boiles on 1/13/12.
//  Copyright (c) 2012 John Boiles. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DepthView;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
  NSWindow *_window;

  IBOutlet DepthView *_depthView;
}

@property (assign) IBOutlet NSWindow *window;

@end
