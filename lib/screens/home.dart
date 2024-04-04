import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/util/constant.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    startScanning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text(Constants.appName));
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) => _buildListItem(devices[index]),
    );
  }

  Widget _buildListItem(BluetoothDevice device) {
    return Card(
      child: ListTile(
        title: Text(device.remoteId.str),
      ),
    );
  }

  void startScanning() async {
    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;
    FlutterBluePlus.scanResults.listen(
      (results) {
        for (ScanResult result in results) {
          if (!devices.contains(result.device)) {
            setState(() => devices.add(result.device));
          }
        }
      },
    );
    await FlutterBluePlus.startScan();
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }
}
