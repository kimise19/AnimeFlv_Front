import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaizen_anime/src/pagues/home_page_content.dart';
import 'package:kaizen_anime/src/widgets/drawer_conten.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: AppDrawer(), body: const HomePageContent());
  }
}
