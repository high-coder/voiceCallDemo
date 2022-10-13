//import 'dart:html';

import 'package:call_demo/controllers/voice_call_controller.dart';
import 'package:call_demo/screens/homeScreen/home_screen2.dart';
import 'package:call_demo/service/local_storage.dart';
import 'package:call_demo/service/our_Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../models/our_user_model.dart';
import '../screens/callerScreen/incoming_call_screen.dart';
import '../screens/loginScreen/our_login.dart';

class CurrentState extends GetxController {
  final LocalStorage localStorage = LocalStorage();
  OurUser? currentUser = OurUser();

  OurDatabase ourDatabase = OurDatabase();

  navigateUserToTheDesiredScreen() async {
    currentUser = await localStorage.getOurUser();

    if (currentUser == null) {
      // Navigate the user to the Login Screen
      Get.offAll(OurLoginPage());
    } else {
      if (currentUser?.uid == null) {
        Get.offAll(OurLoginPage());
      } else {
        // Navigate the user to the home screen()
        Get.offAll(HomeScreen2());
      }
    }
  }

  setCurrentUserValue() async{
    currentUser = await localStorage.getOurUser();
  }

  var allUsers =
      [].obs; // in future pagination can be added to fetch less users
  goAndFetchMeUsers() async {
    allUsers.value = await ourDatabase.fetchUsersToCall();
    if (allUsers.isEmpty) {
      // show the message to the user that the list is empty
    } else {
      // do your normal thingyyyyyy............
    }
  }

  late OurUser callerDetails;
  /// stream watching for a call
  //Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
  Stream streamDataOfUser() async* {
    print(currentUser?.uid);
    Stream callStream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .snapshots();
    callStream.listen((event) {
      print("Inside here watching a stream value");
      print(event.data());
      Map<String,dynamic> data = event.data();
      if (data["someOneCalling"]["callingRightNow"]!=null) {
        print("NOT NULL.............................");
        // update the UI of the application
        if(data["someOneCalling"]["callingRightNow"] == true) {
          print("over here ======================================");
          callerDetails = OurUser();
          callerDetails.uid =  data["someOneCalling"]["uidOfCaller"];
          callerDetails.name = data["someOneCalling"]["nameOfCaller"];
          Get.to(() => IncomingCallScreen());
          if(data["someOneCalling"]["callStatus"] == "Started") {
            // just Verify if the user is on the IncomingCallScreen()
          }

          /// Tested working fine
          else if(data["someOneCalling"]["callStatus"] == "Declined"){
            // Navigate the user back to the previous screen and also
            Get.back();
            VoiceCallCont voiceCallCont = Get.put(VoiceCallCont());
            voiceCallCont.leave();
            //TODO: here also make sure that the someOneCallingbool is turned to false
          }

        }
        //else if(data["someOneCalling"]["callStatus"] == "")
        // Initialise the agora channel too
      }
    });
  }

  makeACallDoAllSteps(String uid, String callStatus) async {
    VoiceCallCont voiceCallCont = Get.find();
    await voiceCallCont.setupVoiceSDKEngine(callStatus);
    voiceCallCont.join("", 1);

    Map<String, dynamic> data = {
      "callStatus": callStatus, // Started, Answered, Declined, Unanswered,
      "callingRightNow": true,
      "uidOfCaller": currentUser?.uid,
      "nameOfCaller":currentUser?.name,
    };
    //ourDatabase.updateCall();
    await ourDatabase.updateCall(uid,data);

  }

  /// This function will manage when a user answers the call on the receiving end
  incomingCallAction(String decision) async {
    if (decision == "Decline") {
      Map<String,dynamic> data = {
        "callStatus":"Declined",
        "callingRightNow":false,
      };
      ourDatabase.updateCall(callerDetails.uid ?? "", data);
    } else if (decision == 'unanswered') {
    }

    /// this is the main case where the user has answered the call
    else {
      FirebaseFirestore.instance.collection("users").doc().get();
      makeACallDoAllSteps(currentUser?.uid ?? "", "Answered");
    }
  }
}
