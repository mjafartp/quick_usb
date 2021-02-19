import 'package:flutter/material.dart';
import 'package:quick_usb/quick_usb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: _buildColumn(),
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      children: [
        _init_exit(),
        _getDeviceList(),
        _has_request(),
        _open_close(),
      ],
    );
  }

  Widget _init_exit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          child: Text('init'),
          onPressed: () async {
            var init = await QuickUsb.init();
            print('init $init');
          },
        ),
        RaisedButton(
          child: Text('exit'),
          onPressed: () async {
            await QuickUsb.exit();
            print('exit');
          },
        ),
      ],
    );
  }

  List<UsbDevice> _deviceList;

  Widget _getDeviceList() {
    return RaisedButton(
      child: Text('getDeviceList'),
      onPressed: () async {
        _deviceList = await QuickUsb.getDeviceList();
        print('deviceList $_deviceList');
      },
    );
  }

  Widget _has_request() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          child: Text('hasPermission'),
          onPressed: () async {
            var hasPermission = await QuickUsb.hasPermission(_deviceList.first);
            print('hasPermission $hasPermission');
          },
        ),
        RaisedButton(
          child: Text('requestPermission'),
          onPressed: () async {
            await QuickUsb.requestPermission(_deviceList.first);
            print('requestPermission');
          },
        ),
      ],
    );
  }

  Widget _open_close() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          child: Text('openDevice'),
          onPressed: () async {
            var openDevice = await QuickUsb.openDevice(_deviceList.first);
            print('openDevice $openDevice');
          },
        ),
        RaisedButton(
          child: Text('closeDevice'),
          onPressed: () async {
            await QuickUsb.closeDevice(_deviceList.first);
            print('closeDevice');
          },
        ),
      ],
    );
  }
}
