import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class CharacteristicScreen extends StatelessWidget {
  const CharacteristicScreen({required this.device, super.key});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text("Characteristic - ${device.remoteId.str}"));
  }

  Widget _buildBody() {
    return FutureBuilder<List<BluetoothService>>(
      future: device.discoverServices(),
      builder: (BuildContext context,
          AsyncSnapshot<List<BluetoothService>> snapshot) {
        return _buildListView(snapshot.data ?? []);
      },
    );
  }

  Widget _buildListView(List<BluetoothService> services) {
    final List<BluetoothCharacteristic> characteristics = services
        .map((e) => e.characteristics)
        .expand((element) => element)
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) => _buildListItem(characteristics[index]),
      itemCount: characteristics.length,
    );
  }

  Widget _buildListItem(BluetoothCharacteristic characteristic) {
    return Card(
      child: ListTile(
        title: Text(characteristic.characteristicUuid.str),
      ),
    );
  }
}
