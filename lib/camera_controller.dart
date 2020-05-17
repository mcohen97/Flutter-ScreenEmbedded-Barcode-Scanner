import 'package:qr_code_scanner/qr_code_scanner.dart';


class CameraController{

  QRViewController wrappedController;
  bool _flashOn;
  bool _frontCamera;
  Function _onValueScanned;

  CameraController(QRViewController controller, Function onValueScanned){
    wrappedController = controller;
    _flashOn = false;
    _frontCamera = false;
    _onValueScanned = onValueScanned;
    wrappedController.scannedDataStream.listen((scanData) {
      _onValueScanned(scanData);
    });
  }


  void toggleFlash(){
    if (wrappedController != null) {
      wrappedController.toggleFlash();
      _flashOn = !_flashOn;
    }
  }

  bool isFlashOn(){
    return _flashOn;
  }

  bool isCameraFront(){
    return _frontCamera;
  }

  void flipCamera(){
    if (wrappedController != null) {
      wrappedController.flipCamera();
      _frontCamera = !_frontCamera;
    }
  }

  void pauseCamera(){
    wrappedController.pauseCamera();
  }

  void resumeCamera(){
    wrappedController.resumeCamera();
  }
}