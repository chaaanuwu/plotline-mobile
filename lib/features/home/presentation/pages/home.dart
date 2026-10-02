import 'package:flutter/material.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_local_data_source.dart';
import 'package:plotline_mobile/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    testAuth();
  }

  Future<void> testAuth() async {
    final auth = await sl<AuthLocalDataSource>().getAuth();

    print('SAVED TOKEN: ${auth?.token}');
    print('SAVED USER: ${auth?.user.firstName}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("PlotLine")));
  }
}
