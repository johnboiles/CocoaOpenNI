//
//  Skeleton.m
//  CocoaOpenNI
//
//  Created by John Boiles on 2/9/12.
//  Copyright (c) 2012 John Boiles. All rights reserved.
//

#import "Skeleton.h"
#import "XnVector3DUtils.h"

@implementation Skeleton

@synthesize head, neck, torso, leftShoulder, leftElbow, leftHand, rightShoulder, rightElbow, rightHand;

+ (Skeleton *)skeletonFromUserGenerator:(xn::UserGenerator)userGenerator user:(XnUserID)user {
  Skeleton *skeleton = [[Skeleton alloc] init];
  skeleton.head = GetJointPosition(userGenerator, user, XN_SKEL_HEAD);
  skeleton.neck = GetJointPosition(userGenerator, user, XN_SKEL_NECK);
  skeleton.torso = GetJointPosition(userGenerator, user, XN_SKEL_TORSO);

  skeleton.leftShoulder = GetJointPosition(userGenerator, user, XN_SKEL_LEFT_SHOULDER);
  skeleton.leftElbow = GetJointPosition(userGenerator, user, XN_SKEL_LEFT_ELBOW);
  skeleton.leftHand = GetJointPosition(userGenerator, user, XN_SKEL_LEFT_HAND);

  skeleton.rightShoulder = GetJointPosition(userGenerator, user, XN_SKEL_RIGHT_SHOULDER);
  skeleton.rightElbow = GetJointPosition(userGenerator, user, XN_SKEL_RIGHT_ELBOW);
  skeleton.rightHand = GetJointPosition(userGenerator, user, XN_SKEL_RIGHT_HAND);

  return [skeleton autorelease];
}

// Find the difference in the angle of the upper arm and the forearm. Will be 0 if the arm is totally straight
- (double)straightRightArmAngle {
  return AngleBetweenXnVector3D(XnVector3DDifference(self.rightElbow.position, self.rightShoulder.position), XnVector3DDifference(self.rightHand.position, self.rightElbow.position));
}

- (double)straightLeftArmAngle {
  return AngleBetweenXnVector3D(XnVector3DDifference(self.leftElbow.position, self.leftShoulder.position), XnVector3DDifference(self.leftHand.position, self.leftElbow.position));
}

- (double)rightHandAngleAboveHorizon {
  XnVector3D rightShoulderToHand = XnVector3DDifference(self.rightHand.position, self.rightShoulder.position);
  return AngleAboveHorizon(rightShoulderToHand);
}

// The angle above horizon (pitch) of the vector made from the left shoulder to the left hand
- (double)leftHandAngleAboveHorizon {
  XnVector3D leftShoulderToHand = XnVector3DDifference(self.leftHand.position, self.leftShoulder.position);
  return AngleAboveHorizon(leftShoulderToHand);
}

// The angle difference on the XZ (ground) plane from the vector created by the shoulders
// 0 is straight out from the shoulders
- (double)rightHandAngleFromShoulders {
  XnVector3D rightShoulderToHand = XnVector3DDifference(self.rightHand.position, self.rightShoulder.position);
  XnVector3D flatRightShoulderToHand = FlattenToXZPlane(rightShoulderToHand);
  XnVector3D shoulderVector = XnVector3DDifference(self.rightShoulder.position, self.leftShoulder.position);
  XnVector3D flatShoulderVector = FlattenToXZPlane(shoulderVector);
  return AngleBetweenXnVector3D(flatRightShoulderToHand, flatShoulderVector);
}

- (double)leftHandAngleFromShoulders {
  XnVector3D leftShoulderToHand = XnVector3DDifference(self.leftHand.position, self.leftShoulder.position);
  XnVector3D flatLeftShoulderToHand = FlattenToXZPlane(leftShoulderToHand);
  XnVector3D shoulderVector = XnVector3DDifference(self.leftShoulder.position, self.rightShoulder.position);
  XnVector3D flatShoulderVector = FlattenToXZPlane(shoulderVector);
  return AngleBetweenXnVector3D(flatLeftShoulderToHand, flatShoulderVector);
}

// Detect if the user is in some sort of flying position. That is, arms out to the side and not totally bent
- (BOOL)armsAreStraightOutToTheSide {
  // Stop recognizing gesture if arms aren't straight or angles are too extreme or arm angles are too different
  BOOL armsNotStraight = [self straightRightArmAngle] > 50 || [self straightLeftArmAngle] > 50;
  BOOL anglesTooExtreme = abs([self rightHandAngleAboveHorizon]) > 60 || abs([self leftHandAngleAboveHorizon]) > 60;
  BOOL armsNotOutToTheSide = abs([self rightHandAngleFromShoulders]) > 45 || abs([self leftHandAngleFromShoulders]) > 45;
  if (armsNotStraight || anglesTooExtreme || armsNotOutToTheSide) {
    return NO;
  }
  return YES;
}

@end

inline XnSkeletonJointPosition GetJointPosition(xn::UserGenerator userGenerator, XnUserID user, XnSkeletonJoint joint) {
  XnSkeletonJointPosition jointPosition;
  xnGetSkeletonJointPosition(userGenerator.GetHandle(), user, joint, &jointPosition);
  return jointPosition;
}
