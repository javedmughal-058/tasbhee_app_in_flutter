import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasbhee_app_in_flutter/tasbhee_record.dart';

import 'Tasbheee.dart';
import 'controller.dart';
class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  final Controller _controller = Get.find();
  final _formKey = GlobalKey<FormState>();
   var index = Get.arguments;
    late Timer timer;
    var clearName ='no tasbhee';
    int clearCount = 0;
  void addTasbhee(String name, String count){
    Tasbhe tsb = Tasbhe(name, int.parse(count));
    _controller.data.add(tsb);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.data.value = [];

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Tasbhee App')),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const TasbheeRecord()));

              }, child: const Text('Saved Tashbee')),
              OutlinedButton(onPressed: (){
                showDialog(
                    barrierDismissible: false,
                    context: context, builder: (context){
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    title: const Text('Add Your Tasbhee'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration:  const InputDecoration(
                                label: Text('Tasbhee Name'),
                              ),
                              style: const TextStyle(color: Colors.black),
                              controller: nameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter counter';
                                }
                                if (value.length > 10000) {
                                  return 'must be < 10000';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text('Tasbhee count'),
                              ),
                              style: const TextStyle(color: Colors.black),
                              controller: countController,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              OutlinedButton(
                                // style: ElevatedButton.styleFrom(
                                //   primary: Color(0xff00875f), // background
                                //   // onPrimary: Colors.yellow, // foreground
                                // ),
                                onPressed: () {
                                  nameController.clear();
                                  countController.clear();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Back'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff00875f), // background
                                  // onPrimary: Colors.yellow, // foreground
                                ),
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                    addTasbhee(nameController.text, countController.text);
                                    nameController.clear();
                                    countController.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Added Your Tasbhee')),

                                    );
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text('Saved'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });

              }, child: const Text('Custom Tasbhee')),
              const Spacer(),
              Text(index==null ?clearName: _controller.data[index].name,  style: Theme.of(context).textTheme.titleLarge,),
              Text(index==null ?clearCount.toString(): _controller.data[index].count.toString(), style: Theme.of(context).textTheme.headline4,),
              const Spacer(),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(onPressed: (){
                  increment();
                  }, icon: const Icon(Icons.add), label: const Text('Count')),
                ElevatedButton.icon(onPressed: (){
                    reset();
                  }, icon: const Icon(Icons.restore), label: const Text('Reset=0')),

              ],
            ),
            ElevatedButton.icon(onPressed: (){
              clear();
            }, icon: const Icon(Icons.clear_sharp), label: const Text('Clear Screen')),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    nameController.dispose();
    countController.dispose();
  }

  void increment(){
    setState(() {
      _controller.data[index].count++;

    });
  }
  void reset(){
    setState(() {
      _controller.data[index].count=0;
    });
  }
  void clear(){
    setState(() {
      index=null;
    });
  }
}
