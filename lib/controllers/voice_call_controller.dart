import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:call_demo/callModel.dart';
import 'package:call_demo/utils/app_sounds.dart';
import 'package:call_demo/utils/const_values.dart' as configApp;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:flutter/material.dart";
/// This call will contain all the Logic for the Video call Sdk
/// Initialising the Sdk and handling the call etc
class VoiceCallCont extends GetxController {
  static const String appId = "6678818fb89b462492d57f77d83e6306";
  late RtcEngine agoraEngine;
  int? remoteId;

  late AudioPlayer player;

  late CallingDetails callData;

  ///Initialising the agora sdk
  Future<void> setupVoiceSDKEngine(String callStatus) async {
    player = AudioPlayer();

    callData = CallingDetails(
        callerName: "something",
        isMuted: true,
        speakerMode: false,
        callerToName: "dfiljode",
        channelName: "highcoderr",
        channelToken: configApp.token,
        isJoined: false);
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(
        const RtcEngineContext(appId: "6678818fb89b462492d57f77d83e6306"));
    if(callStatus!="Answered") {
      await agoraEngine.enableAudio();
    }
    //await agoraEngine.setClientRole(role: callData.clientRole); // this will be broadcast for the sender and
    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("Local user uid:${connection.localUid} joined the channel");
          playSound(AppSounds.callerSound);

          /// TODO: update the user has jonied
          //});
        },
        onUserJoined:
            (RtcConnection connection, int remoteUid, int elapsed) async {
          print("Remote user uid:$remoteUid joined the channel");

          if (player.playing) {
            await player.stop();
          }
          callData.remotedId = remoteUid;

          /// TODO: update the user has jonied
          //});
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          print("Remote user uid:$remoteUid left the channel");
          playSound(AppSounds.connectionLost);

          //setState(() {
          callData.remotedId = null;

          /// TODO: update the user has jonied
          //});
        },
      ),
    );
  }


  Future<void> setupVoiceSDKEngine2() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          // setState(() {
          //   _isJoined = true;
          // });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          //setState(() {
          //_remoteUid = remoteUid;
          //});
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          Get.back();
          //setState(() {
          //_remoteUid = null;
//          });
        },
      ),
    );
  }


  showMessage(String message) {
    Get.showSnackbar(GetSnackBar(messageText: Text(message),title: "something",));
  }

  /// this function should be used to join the a call channel in the application
  void join(String channelName, int uid) async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: configApp.token,
      channelId: configApp.channelId,
      options: options,
      uid: 0,
    );
  }

  createAChannel({required String channelName, required int uid}) async {
    await setupVoiceSDKEngine2();
    join(channelName, uid);
  }

  /// this is when the user has ended the call
  void leave() async{
    //setState(() {
    //_isJoined = false;
    //_remoteUid = null;
    callData.isJoined = false;
    callData.remotedId = null;
    //});
    await agoraEngine.leaveChannel();
    Get.back();
  }

  var microphoneStatus = true.obs;

  void switchMicrophone() {
    callData.isMuted = !callData.isMuted;
    microphoneStatus.value = !microphoneStatus.value;
    //isMicMute = !isMicMute;
    agoraEngine
        .enableLocalAudio(callData.isMuted)
        .then((value) {})
        .catchError((err) {
      //log('enableLocalAudio $err');
    });
    print(configApp.channelId);
    update();
  }

  Future<void> playSound(String fileName) async {
    if (player.playing) {
      await player.stop();
    }
    await player.setAsset(fileName);
    player.play();
  }
}
