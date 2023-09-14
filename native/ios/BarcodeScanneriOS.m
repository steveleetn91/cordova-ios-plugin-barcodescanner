#import <Cordova/CDV.h>
#import "BarcodeScanneriOS.h"
@import MLImage;
@import MLKit;
@import AVFoundation;
@implementation BarcodeScanneriOS
- (void)scanner:(CDVInvokedUrlCommand *)command {
    
    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;
    
    UIImagePickerController *myPicker = [[UIImagePickerController alloc] init];

    myPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    myPicker.showsCameraControls = true;
    myPicker.delegate = self;
    //myPicker.delegate = self.commandDelegate;

    [self.viewController presentViewController: myPicker animated:YES completion:^(void){
        NSLog(@"Start Scanner");
    }];
    [myPicker takePicture];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
            return;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {

      UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        MLKVisionImage *visionImage = [[MLKVisionImage alloc] initWithImage:image];
        visionImage.orientation = image.imageOrientation;
        
        MLKBarcodeScannerOptions *options =
          [[MLKBarcodeScannerOptions alloc]
           initWithFormats: MLKBarcodeFormatAll];
        
        MLKBarcodeScanner *barcodeScanner = [MLKBarcodeScanner barcodeScanner];
        
        [barcodeScanner processImage:visionImage
                          completion:^(NSArray<MLKBarcode *> *_Nullable barcodes,
                                       NSError *_Nullable error) {
          if (error != nil) {
            // Error handling
            [self fireEvent:@"" event:@"BarcodeScanner.FAIL" withData:nil];
            return;
          }
          if (barcodes.count > 0) {
            // Recognized barcodes
              
              for (MLKBarcode *barcode in barcodes) {
                 NSArray *corners = barcode.cornerPoints;

                 NSString *displayValue = barcode.displayValue;
                 NSString *code = barcode.rawValue;
                NSString *ssid = @"";
                  NSString *password = @"";
                  long encryptionType;
                  NSString *url = @"";
                  NSString *title = @"";
                  NSString *responseFormat = @"";
                  MLKBarcodeValueType valueType = barcode.valueType;
                 switch (valueType) {
                   case MLKBarcodeValueTypeWiFi:
                         ssid = barcode.wifi.ssid;
                         password = barcode.wifi.password;
                         encryptionType = barcode.wifi.type;
                         responseFormat = [NSString stringWithFormat:@"{ 'ssid': '%@','password':'%@','encryption':'%ld','code':'%@'}",url,title,encryptionType,code];
                         [self fireEvent:@"" event:@"BarcodeScanner.DONE" withData:responseFormat];
                         break;
                   case MLKBarcodeValueTypeURL:
                     url = barcode.URL.url;
                     title = barcode.URL.title;
                         responseFormat = [NSString stringWithFormat:@"{ 'url': '%@','title':'%@','code':'%@'}",url,title,code];
                         [self fireEvent:@"" event:@"BarcodeScanner.DONE" withData:responseFormat];
                         break;
                   // ...
                   default:
                         
                         responseFormat = [NSString stringWithFormat:@"{ 'code': '%@' }",code];
                         
                         [self fireEvent:@"" event:@"BarcodeScanner.DONE" withData:responseFormat];
                         
                     break;
                 }
               }
          }
        }];
        
      UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

      // Đóng UIImagePickerController
      [picker dismissViewControllerAnimated:YES completion:NULL];

        NSLog(@"Done scanner");
    }
}

- (void) fireEvent:(NSString *)obj event:(NSString *)eventName withData:(NSString *)jsonStr {
    NSString* js;
    if(obj && [obj isEqualToString:@"window"]) {
        js = [NSString stringWithFormat:@"var evt=document.createEvent(\"UIEvents\");evt.initUIEvent(\"%@\",true,false,window,0);window.dispatchEvent(evt);", eventName];
    } else if(jsonStr && [jsonStr length]>0) {
        js = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('%@',%@);", eventName, jsonStr];
    } else {
        js = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('%@');", eventName];
    }
    [self.commandDelegate evalJs:js];
}
@end



