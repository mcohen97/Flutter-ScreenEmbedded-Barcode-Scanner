import 'package:flutter/material.dart';
import 'package:flutterapp/camera_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class ScannerView extends StatefulWidget{


  Function onValueScanned;
  Function onControllerCreated;

  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  ScannerView({this.onValueScanned, this.onControllerCreated});

  @override
  State<StatefulWidget> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: QRView(
        key: widget._qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    CameraController wrapper = CameraController(controller, widget.onValueScanned);
    widget.onControllerCreated(wrapper);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}