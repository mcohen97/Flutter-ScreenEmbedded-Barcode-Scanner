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
            child: ScannerView(
                onValueScanned: _setScannedValue,
                onControllerCreated: _onControllerCreated,
                key: qrKey),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'This is the result of scan: $qrText',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                    children: scannedCodes
                        .map((code) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(code, textAlign: TextAlign.center,),
                              ),
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onControllerCreated(CameraController controller) {
    this.controller = controller;
  }

  void _setScannedValue(String value) {
    setState(() {
      qrText = value;
      if (!scannedCodes.contains(value)) {
        scannedCodes.add(value);
        _playBeep();
      }
    });
  }

  Future<void> _playBeep() async {
    var asset = await rootBundle.load("assets/beep.mp3");
    var _alarmSound = await _soundpool.load(asset);
    var _alarmSoundStreamId = await _soundpool.play(_alarmSound);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
