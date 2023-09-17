# Cordova iOS Plugin BarcodeScanner 
Cordova iOS support BarcodeScanner

## Prepare 

if you using `cordova-firebase` it will appear errors. But we can fix it. This is bug of Google. it's not me.
And add this info your `config.xml` file.

    <config-file parent="NSCameraUsageDescription" target="*-Info.plist" >
            <string>Scan  Barcode</string>
        </config-file>
        <config-file parent="NSPhotoLibraryUsageDescription" target="*-Info.plist" >
            <string>to save photos and videos</string>
        </config-file>
    <preference name="deployment-target" value="11.0" />

## How to implement? 

    window.BarcodeScanneriOS.scanner().then(() => {}).catch(() => {})

    document.addEventListener("BarcodeScanner.DONE",(e)=>{
        console.log('BarcodeScanner e.code',e.code);
    })

    document.addEventListener("BarcodeScanner.FAIL",()=>{
        console.log('BarcodeScanner fail');
    })

If you need check information about this code you can use API at Backend to get information. It's the same with `Google Sign-In`, `Apple Sign-In`.

## If you using Firebase 

If you use firebase maybe it will appear errors, but you don't worry let's do list steps:

    - cd ./platforms/ios 
    - pod repo update 
    - pod update GTMSessionFetcher/Core
    - cd ../../
    - cordova prepare ios 
    - cordova build ios

## Issue 

If you need anything please create new issue `https://github.com/steveleetn91/cordova-ios-plugin-barcodescanner/issues`

## Freelancer Service (Cordova/Ionic)

If you need a freelancer for cordova project, so let's me know. I can work 16 hours / 1 day and rate is 10$/1 hour. I can speak english and IELTS scope is `6.0~7.0`.

 - Write plugin 
 - Coding App 
 - Maintain cordova/ionic app 

Contact email : hoang.le.tn91@gmail.com

Facebook: https://www.facebook.com/profile.php?id=100015561036994