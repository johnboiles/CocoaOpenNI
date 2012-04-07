//
//  XnVector3DUtils.c
//  CocoaOpenNI
//
//  Created by John Boiles on 2/9/12.
//  Copyright (c) 2012 John Boiles. All rights reserved.
//

#import "XnVector3DUtils.h"
#import "math.h"

XnVector3D XnVector3DSum(int count, ...) {
  va_list arguments;
  va_start(arguments, count);
  XnVector3D sumVector;
  sumVector.X = 0;
  sumVector.Y = 0;
  sumVector.Z = 0;
  for (int i = 0; i < count; i++) {
    XnVector3D vector = va_arg(arguments, XnVector3D);
    sumVector.X += vector.X;
    sumVector.Y += vector.Y;
    sumVector.Z += vector.Z;
  }
  va_end(arguments);
  return sumVector;
}

XnVector3D XnVector3DAverage(int count, ...) {
  va_list arguments;
  va_start(arguments, count);
  XnVector3D sumVector;
  sumVector.X = 0;
  sumVector.Y = 0;
  sumVector.Z = 0;
  for (int i = 0; i < count; i++) {
    XnVector3D vector = va_arg(arguments, XnVector3D);
    sumVector.X += vector.X;
    sumVector.Y += vector.Y;
    sumVector.Z += vector.Z;
  }
  va_end(arguments);
  sumVector.X = sumVector.X / count;
  sumVector.Y = sumVector.Y / count;
  sumVector.Z = sumVector.Z / count;
  return sumVector;
}

XnVector3D XnVector3DDifference(XnVector3D v1, XnVector3D v2) {
  XnVector3D difference;
  difference.X = v1.X - v2.X;
  difference.Y = v1.Y - v2.Y;
  difference.Z = v1.Z - v2.Z;
  return difference;
}

XnVector3D XnVector3DMultiply(XnVector3D vector, double multiplier) {
  XnVector3D difference;
  difference.X = vector.X * multiplier;
  difference.Y = vector.Y * multiplier;
  difference.Z = vector.Z * multiplier;
  return difference;
}

double XnVector3DMagnitude(XnVector3D vector) {
  return sqrt(pow(vector.X, 2) + pow(vector.Y, 2) + pow(vector.Z, 2));
}

double XnVector3DDotProduct(XnVector3D v1, XnVector3D v2) {
  return v1.X * v2.X + v1.Y * v2.Y + v1.Z * v2.Z;
}

double AngleBetweenXnVector3D(XnVector3D v1, XnVector3D v2) {
  // cos^-1(a.b/|a||b|)*(180/pi) gives the angle in degrees.
  // See http://www.wikihow.com/Find-the-Angle-Between-Two-Vectors
  return acos(XnVector3DDotProduct(v1, v2) / (XnVector3DMagnitude(v1) * XnVector3DMagnitude(v2))) * (180 / M_PI);
}

double AngleAboveHorizon(XnVector3D vector) {
  // Just pythagorean theorum and trig
  return atan(vector.Y / sqrt(pow(vector.X, 2) + pow(vector.Z, 2))) * 180 / M_PI;
}

double AngleFromYZPlane(XnVector3D vector) {
  // Just pythagorean theorum and trig
  return atan(vector.X / sqrt(pow(vector.Y, 2) + pow(vector.Z, 2))) * 180 / M_PI;
}

double AngleFromZAxisOnXZPlane(XnVector3D vector) {
  // Just pythagorean theorum and trig
  return atan(vector.X / vector.Z) * 180 / M_PI;
}

XnVector3D FlattenToXZPlane(XnVector3D vector) {
  XnVector3D flatVector;
  flatVector.X = vector.X;
  flatVector.Y = 0;
  flatVector.Z = vector.Z;
  return flatVector;
}
