//
//  DepthView.m
//  CocoaOpenNI
//
//  Created by John Boiles on 1/13/12.
//  Copyright (c) 2012 John Boiles. All rights reserved.
//

#import "DepthView.h"
#import <OpenGL/gl.h>
#import "CocoaOpenNI.h"
#include <XnCppWrapper.h>

#define kKinectWidth (640.0)
#define kKinectHeight (480.0)

@implementation DepthView

- (void)drawRect:(NSRect)bounds {
  if ([[CocoaOpenNI sharedOpenNI] isStarted]) {
    glEnableClientState(GL_VERTEX_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    
    glPushMatrix();
    glLoadIdentity();
    
    glMatrixMode(GL_PROJECTION);
    glOrtho(0, 640, 480, 0, -4.0f, 4.0f);

    xn::SceneMetaData sceneMD;
    xn::DepthMetaData depthMD;

    // Process the data
    [[CocoaOpenNI sharedOpenNI] depthGenerator].GetMetaData(depthMD);
    [[CocoaOpenNI sharedOpenNI] userGenerator].GetUserPixels(0, sceneMD);
    DrawDepthMap(depthMD, sceneMD);
    DrawUserInfo();
    glPopMatrix();

    glFlush();
  }
}

@end
