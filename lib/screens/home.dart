import 'package:flutter/material.dart';
import 'package:flutter_ble_sample/util/constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    return Container();
  }
}
