
import 'package:call_demo/controllers/voice_call_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  VoiceCallCont voiceCallCont = Get.put(VoiceCallCont());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  print("This is being pressed");
                  voiceCallCont.createAChannel(channelName: "highcoder2", uid: 123);
                },
                child: Text("CREATE AND JOIN A CHANNEL"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
