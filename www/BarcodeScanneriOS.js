module.exports = {
    scanner: () => {
        return new Promise((resolve,reject) => {
            cordova.exec(resolve, reject, 'BarcodeScanneriOS', 'scanner', [])
        })
    }
}