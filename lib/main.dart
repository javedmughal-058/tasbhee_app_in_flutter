
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasbhee_app_in_flutter/controller.dart';
import 'package:tasbhee_app_in_flutter/tasbhee_record.dart';

import 'Tasbheee.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
  final _controller = Get.put(Controller());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const splash(),
      routes: {
        "/tasbhee_record": (context) => const TasbheeRecord(),
        "/home": (context) => const HomePage(),
      },
    );
  }
}
class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
        const Duration(seconds: 3)).then((value) {
          Get.toNamed('/home');
    });

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Get.width,
          color: Colors.teal.withOpacity(0.7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              Image.asset('assets/images/tasbhee.png'),
              const SizedBox(height: 10,),
              const Spacer(),
              const Text('Starting Tasbhee App.....', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),),
              const SizedBox(height: 10,),
              const CircularProgressIndicator( color: Colors.white),
              const Spacer(),

            ],

          ),
        ),
      ),
    );
  }
}

