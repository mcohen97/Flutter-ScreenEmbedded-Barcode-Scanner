import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/scanner_view.dart';
import 'camera_controller.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

Soundpool _soundpool = Soundpool();


void main() => runApp(MaterialApp(home: QRViewExample()));

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  String qrText = '';
  List<String> scannedCodes = [];
  String flashState = flashOn;
  String cameraState = frontCamera;
  CameraController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ScannerView(onValueScanned: _setScannedValue, onControllerCreated: _onControllerCreated, key: qrKey),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 500,
                    height: 50,
                    child: Text('This is the result of scan: $qrText'),
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: RaisedButton(
                          onPressed: () {
                            if (controller != null) {
                              controller.toggleFlash();
                              setState(() {
                                flashState =  controller.isFlashOn() ? flashOff : flashOn;
                              });
                            }
                          },
                          child:
                          Text(flashState, style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: RaisedButton(
                          onPressed: () {
                            if (controller != null) {
                              controller.flipCamera();
                              setState(() {
                                cameraState = !controller.isCameraFront()
                                    ? frontCamera
                                    : backCamera;
                              });
                            }
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
                  ),*/
                  Container(
                    height: 100,
                    width: 500,
                    child: ListView(
                      children: scannedCodes.map((code) => Card(child: Text(code),
                        color: Colors.grey,
                      )).toList(),
                    ),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onControllerCreated(CameraController controller) {
    this.controller = controller;
  }

  void _setScannedValue(String value){
    setState(() {
      qrText = value;
      if(!scannedCodes.contains(value)) {
        scannedCodes.add(value);
        _playBeep();
      }
    });
  }

  Future<void> _playBeep() async {
    var asset = await rootBundle.load("assets/beep.mp3");
    var _alarmSound =  await _soundpool.load(asset);
    var _alarmSoundStreamId = await _soundpool.play(_alarmSound);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

