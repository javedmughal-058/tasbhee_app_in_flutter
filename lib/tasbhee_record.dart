
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'home_page.dart';
import 'main.dart';
class TasbheeRecord extends StatelessWidget {
  const TasbheeRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.find();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: const Text('Saved Tasbhees')),
          body: _controller.data.isNotEmpty ?
          Column(
            children: [
              const Text('Name', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),),
              Expanded(
                child:
                ListView.builder(
                  padding: const EdgeInsets.only(left: 30,),
                    itemCount: _controller.data.length,
                    itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed('/home', arguments: index);
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("${index+1}.",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800),),
                            const SizedBox(width: 4,),
                            Text(_controller.data[index].name),
                            const Spacer(),
                            Text(_controller.data[index].count.toString()),
                            const SizedBox(width: 10,),
                          ],
                        ),
                        Divider(color: Colors.grey.shade400,indent: 0, endIndent: 12,)
                      ],
                    ),
                  );
                })
              ),],) :
          const Center(
              child: Text('No Tasbhee Found')),
      ),
    );
  }
}

