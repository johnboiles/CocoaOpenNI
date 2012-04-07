//
//  Skeleton.h
//  CocoaOpenNI
//
//  Created by John Boiles on 2/9/12.
//  Copyright (c) 2012 John Boiles. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <XnCppWrapper.h>

@interface Skeleton : NSObject {
  XnSkeletonJointPosition head;
  XnSkeletonJointPosition neck;
  XnSkeletonJointPosition torso;
  
  XnSkeletonJointPosition leftShoulder;
  XnSkeletonJointPosition leftElbow;
  XnSkeletonJointPosition leftHand;
  
  XnSkeletonJointPosition rightShoulder;
  XnSkeletonJointPosition rightElbow;
  XnSkeletonJointPosition rightHand;
}

@property (assign, nonatomic) XnSkeletonJointPosition head;
@property (assign, nonatomic) XnSkeletonJointPosition neck;
@property (assign, nonatomic) XnSkeletonJointPosition torso;

@property (assign, nonatomic) XnSkeletonJointPosition leftShoulder;
@property (assign, nonatomic) XnSkeletonJointPosition leftElbow;
@property (assign, nonatomic) XnSkeletonJointPosition leftHand;

@property (assign, nonatomic) XnSkeletonJointPosition rightShoulder;
@property (assign, nonatomic) XnSkeletonJointPosition rightElbow;
@property (assign, nonatomic) XnSkeletonJointPosition rightHand;

+ (Skeleton *)skeletonFromUserGenerator:(xn::UserGenerator)userGenerator user:(XnUserID)user;

- (BOOL)armsAreStraightOutToTheSide;

@end

XnSkeletonJointPosition GetJointPosition(xn::UserGenerator userGenerator, XnUserID user, XnSkeletonJoint joint);