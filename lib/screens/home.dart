import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/screens/characteristics.dart';
import 'package:flutter_ble_sample/screens/services.dart';
import 'package:flutter_ble_sample/util/common.dart';
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
    _startScanning();
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
    if (devices.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text("No devices found yet ..."),
        ),
      );
    }
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) => _buildListItem(devices[index]),
    );
  }

  Widget _buildListItem(BluetoothDevice device) {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            device.remoteId.str,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Row(
          children: [
            TextButton(
              onPressed: () => _connectDevice(device),
              child: Text(device.isConnected ? "Disconnect" : "Connect"),
            ),
            TextButton(
              onPressed: () => CommonUtils.navigate(
                context,
                ServicesScreen(device: device),
              ),
              child: const Text("Services"),
            ),
            TextButton(
              onPressed: () => CommonUtils.navigate(
                context,
                CharacteristicScreen(device: device),
              ),
              child: const Text("Characteristics"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _connectDevice(BluetoothDevice device) async {
    if (device.isConnected) {
      await device.disconnect();
      if (mounted) {
        setState(() {});
      }
    } else {
      await device.connect(license: License.free);
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _startScanning() async {
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
