import 'package:call_demo/controllers/current_state.dart';
import 'package:call_demo/controllers/voice_call_controller.dart';
import 'package:call_demo/models/our_user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/callerButton.dart';


class CallerScreen extends StatefulWidget {
  OurUser details;
  bool callInit;
  CallerScreen({Key? key,required this.details,this.callInit=true}) : super(key: key);

  @override
  _CallerScreenState createState() => _CallerScreenState();
}

class _CallerScreenState extends State<CallerScreen> {


  /// ok so these are the steps that I will follow to make a call
  /// Step1. Initialise agora with a channel token
  /// Step2. update the database about the call inside the user document whom we are calling
  /// Step3. Just managing the state on both sides.....
  final VoiceCallCont _instanceVoice = Get.find();

  final CurrentState _instanceState = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.callInit==true) {
      _instanceState.makeACallDoAllSteps(widget.details.uid ?? "","Started");
    } else {
      //do nothing
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GetBuilder<VoiceCallCont>(
        builder:(context) {
          return Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff0c0c0c),
                  Color(0xff4834d4),
                  Color(0xff00264D),
                ],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.details.name ?? "",
                        style: textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: size.height * 0.014),
                      Text(

                        // _instanceVoice.callData.isJoined
                        //     ? "timer"
                        //     :
                        "Calling",
                        style: textTheme.subtitle2!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.dialer_sip_sharp,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Keypad",
                                style: textTheme.subtitle2!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      CallerButtonBuilder(
                        firstOnPressed: () {},
                        firstTitle: "Record",
                        firstIcon: const Icon(
                          Icons.voicemail,
                          color: Colors.white,
                        ),
                        secondOnPressed: () {},
                        secondTitle: "On hold",
                        secondIcon: const Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                        ),
                        thirdOnPressed: () {
                          //context.read<VoiceCallerCubit>().switchMicrophone();
                          _instanceVoice.switchMicrophone();
                        },
                        thirdTitle: "Mute",
                        thirdIcon: Icon(
                          // !_instanceVoice.callData.isMuted
                          //     ? Icons.mic
                          //     :
                          Icons.mic_off,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      CallerButtonBuilder(
                        firstOnPressed: () {},
                        firstTitle: "Add call",
                        firstIcon: const Icon(
                          Icons.add_box,
                          color: Colors.white,
                        ),
                        secondOnPressed: () {},
                        secondTitle: "Contact",
                        secondIcon: const Icon(
                          Icons.perm_contact_cal,
                          color: Colors.white,
                        ),
                        thirdOnPressed: () {
                          // context.read<VoiceCallerCubit>().switchSpeakerphone();
                        },
                        thirdTitle: "Speaker",
                        thirdIcon: Icon(

                          // _instanceVoice.callData.speakerMode
                          //     ? Icons.volume_up
                          //     :
                          Icons.volume_down,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {
                      // final _isJoined = context
                      //     .select((VoiceCallerCubit state) => state.isJoined);
                      // if (_isJoined) {
                      //   context.read<VoiceCallerCubit>().leaveChannel();
                      //   Navigator.pop(context);
                      // }
                      _instanceVoice.leave();
                    },
                    icon: const Icon(
                      Icons.call_end_sharp,
                      color: Colors.red,
                      size: 42.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
