#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import <AVFoundation/AVFoundation.h>
#import <MLKitBarcodeScanning/MLKitBarcodeScanning.h>
@interface BarcodeScanneriOS : CDVPlugin<UINavigationControllerDelegate> {
    
    
}

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) MLKBarcodeScanner *barcodeScanner;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;

@end