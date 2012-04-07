CocoaOpenNI
===========
http://github.com/johnboiles/CocoaOpenNI

Sample project for using OpenNI in a Cocoa OSX app.

![Screenshot](https://johnboiles.s3.amazonaws.com/Screenshots/CocoaOpenNI.png)

To Run This Project
-------------------
1.   Install forked binaries for PrimeSense/Sensor (This may be different if you have Kinect for Windows hardware)
     https://github.com/avin2/SensorKinect/tree/unstable/Bin

2.   Get the PrimeSense NITE binaries here (necessary for skeletal tracking):
     http://www.openni.org/component/search/?searchword=nite&ordering=&searchphrase=all

3.   Run the install script included with the NITE binaries
     <pre>sudo ./install.sh</pre>

4.   Use License code
     <pre>0KOIk2JeIBYClPWVnMoRKn5cdY4=</pre>

5.   Plug in your Kinect, and run CocoaOpenNI.xcodeproj in Xcode.

TODO / Future Vision
--------------------
Ideally in the future we could make proper Objective-C bindings directly on top of the OpenNI C bindings, but for now it's easier to just use Objective-C++ and add Objective-C convenience methods for common functions.

License
-------
CocoaOpenNI includes a New/Modified BSD license. This means you can use it modified or unmodified for your commerical products. However, you must include a credit mentioning John Boiles as the original author. Where you put it is up to you, but preferrably somewhere in the software itself. Perhaps something like:

Includes “CocoaOpenNI” code by John Boiles.

You're under no obligation to share any modified / improved code, but I would appreciate it if you shared improvements via a pull request!

Note that this includes an unmodified binary distribution of OpenNI which is licensed as GPLv3.