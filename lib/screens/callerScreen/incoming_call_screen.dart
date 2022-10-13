import 'package:call_demo/controllers/current_state.dart';
import 'package:call_demo/screens/callerScreen/caller_screen.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

class IncomingCallScreen extends StatefulWidget {
  const IncomingCallScreen({Key? key}) : super(key: key);

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  final CurrentState _instance = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 200,),
            TextButton(onPressed: () {

              _instance.incomingCallAction("Answered");
              //Get.to(CallerScreen(details: _instance.callerDetails,callInit: false,));
            }, child: Text("Accept")),
            const SizedBox(height: 100,),
            TextButton(onPressed: () {

              _instance.incomingCallAction("Decline");
              Get.back();
            }, child: Text("Decline")),
          ],
        ),
      ),
    );
  }
}
