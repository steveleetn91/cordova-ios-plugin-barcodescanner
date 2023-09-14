# cordova-ios-plugin-barcodescanner

## How to implement? 

    window.BarcodeScanneriOS.scanner().then(() => {}).catch(() => {})

    document.addEventListener("BarcodeScanner.DONE",(e)=>{
        console.log('BarcodeScanner e.code',e.code);
    })

    document.addEventListener("BarcodeScanner.FAIL",()=>{
        console.log('BarcodeScanner fail');
    })