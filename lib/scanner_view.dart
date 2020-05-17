import 'package:flutter/material.dart';
import 'package:flutterapp/camera_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



class ScannerView extends StatefulWidget{


  Function _onValueScanned;
  Function _onControllerCreated;

  GlobalKey _qrKey;


  ScannerView({Function onValueScanned, Function onControllerCreated, Key key}){
    _onValueScanned = onValueScanned;
    _onControllerCreated = onControllerCreated;
    _qrKey = key;
  }

  @override
  State<StatefulWidget> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return QRView(
        key: widget._qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    CameraController wrapper = CameraController(controller, widget._onValueScanned);
    widget._onControllerCreated(wrapper);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}