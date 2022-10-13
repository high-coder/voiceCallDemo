import 'package:call_demo/controllers/current_state.dart';
import 'package:call_demo/controllers/voice_call_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../callerScreen/caller_screen.dart';



class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {


  final CurrentState _instance = Get.find();


  final VoiceCallCont _instanceVoice = Get.put(VoiceCallCont());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _instance.goAndFetchMeUsers();
    //_instanceVoice.setupVoiceSDKEngine();

    _instance.streamDataOfUser().listen((event) {
      print("Inside here somethign has happened ======================== ");
      print(event);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: const Text("Welcome to the home page user"),
            ),

            Obx(() => ListView.builder(
              shrinkWrap: true,
              itemCount: _instance.allUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    Get.to(() => CallerScreen(details: _instance.allUsers[index],));
                  },
                  title: Text(_instance.allUsers[index].name ?? ""),

                );
              },
            ))

          ],
        ),
      ),
    );
  }
}
