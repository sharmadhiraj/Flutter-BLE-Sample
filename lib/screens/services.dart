import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({required this.device, super.key});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text("Services - ${device.remoteId.str}"));
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
    return ListView.builder(
      itemBuilder: (context, index) => _buildListItem(services[index]),
      itemCount: services.length,
    );
  }

  Widget _buildListItem(BluetoothService service) {
    return Card(
      child: ListTile(
        title: Text(service.serviceUuid.str),
      ),
    );
  }
}
