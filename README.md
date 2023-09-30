# Android_Sensors_Simulink_UDP
Send Android Sensor Data over UDP in real-time
![alt text](https://github.com/4mbilal/Android_Sensors_Simulink_UDP/gapp_scren.png)

Uses Simulink Support Package for Android to send the following sensor's data over UDP in real-time (100 Hz)
-Accelerometer
-Gyroscope
-Magnetometer
-GPS
-Orientation
-Ambient Light
-Ambient Temperature
-Pressure

UDP Broadcast (255.255.255.255)

Implementation Notes:
1- Simulink Model: "Android_Sensors_UDP.slx"

2- Matlab (R2023a) does not work with the embedded JDK installed with Android Studio (Arctic Fox) in the folder "C:\Program Files\Android\Android Studio\jre". Manually replaced all the files in this folder with files from "corretto-15.0.2". For this, install JDK 15 from within an Android Studio project i.e. File->Project Structure->SDK Location->Gradle Settings->Gradle JDK->Add JDK. This will install new JDK somewhere in c:\user\abc\.jdk. Then copy these files manually to replace the embedded JDK. There could be a more elegant way of doing this!

3- Simulink-generated code prefers network-provided location which is very imprecise. To remedy this, open the generated project in Android Studio (import) and make the following changes 
In GPSHandler.java file, make the following edits for frequent updates.
	MIN_DISTANCE_CHANGE_FOR_UPDATES = 0;
	MIN_TIME_BW_UPDATES = 10 * 1;
	
	Comment out the following cellular network-based location update.
	if (mIsNetworkEnabled) {
	...
	}
	
Add the information related to armeabi in "build.gradle" as follows. Otherwise, a runtime error "lib.so not found" will occurr. App crashes. 
defaultConfig {
        minSdkVersion 17
        targetSdkVersion 28
        ndk {
            abiFilters "armeabi-v7a", "x86", "armeabi", "mips"
        }
    }
    
In Android Studio, generate apk for offline install if needed. The modified Android Studio project is in the zip file. 

To-Do:
Implement sensor fusion e.g. Kalman/Particle/weighted average complementary filtering

Contact 4mbilal at gmail

