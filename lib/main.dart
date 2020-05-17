import 'package:flutter/material.dart';
import 'package:flutterapp/camera_controller.dart';
import 'scanner_view.dart';

const String _flashOnTxt = "FLASH ON";
const String _flashOffTxt = "FLASH OFF";
const String _cameraFrontTxt = "FRONT CAMERA";
const String _cameraBackTxt = "BACK CAMERA";

void main() => runApp(MaterialApp(home: QRViewExample()));


class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {

  String barcodeText;
  String cameraState =  _cameraFrontTxt;
  String flashState = _flashOffTxt;
  CameraController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ScannerView(onValueScanned: setScannedValue, onControllerCreated: setCameraController),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('This is the result of scan: $barcodeText'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: RaisedButton(
                          onPressed: () {
                              controller.toggleFlash();
                              setState(() {
                                flashState = controller.isFlashOn() ? _flashOnTxt : _flashOffTxt ;
                              });
                          },
                          child:
                          Text(flashState, style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: RaisedButton(
                          onPressed: () {
                            controller?.toggleFlash();
                            setState(() {
                              cameraState = controller.isCameraFront() ? _cameraFrontTxt : _cameraBackTxt;
                            });
                          },
                          child:
                          Text(cameraState, style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: RaisedButton(
                          onPressed: () {
                            controller?.pauseCamera();
                          },
                          child: Text('pause', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: RaisedButton(
                          onPressed: () {
                            controller?.resumeCamera();
                          },
                          child: Text('resume', style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void setScannedValue(String value){
    setState(() {
      barcodeText = value;
    });
  }

  void setCameraController(CameraController created){
      controller = created;
  }

}

