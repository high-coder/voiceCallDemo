import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


import '../models/our_user_model.dart';

class OurDatabase {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    Map<String,dynamic> data = user.toJson();
    data["someOneCalling"] = {
      "callStatus":"",
      "callingRightNow":false,
      "uidOfCaller":"",
    };
    try {
      await _firestore.collection('users').doc(user.uid).set(data);
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try {
      // this block is running fine
      DocumentSnapshot _docSnapshot =
      await _firestore.collection("users").doc(uid).get();
      print("Above the document snapshot data");
      print(_docSnapshot.data());
      print("below the document snapshot data");
      //retVal(_docSnapshot.data()['name']);

      Map<String, dynamic>? data = _docSnapshot.data() as Map<String, dynamic>?;
      retVal = OurUser.fromJson(_docSnapshot.data() as Map<String, dynamic>);

      print("Exiting the get user information function now");
    } catch (e) {
      print("in the catch of the get user info");
      print(e);
    }
    return retVal;
  }

  // Future<String> updateUserData(OurUser user, {File? file}) async {
  //   String retVal = "error";
  //
  //   try {
  //     String downloadLink;
  //     if (file != null) {
  //       var snapshot =
  //       await FirebaseStorage.instance.ref(user.uid).putFile(file);
  //       downloadLink = await snapshot.ref.getDownloadURL();
  //
  //       user.resume = downloadLink;
  //       await _firestore
  //           .collection("users")
  //           .doc(user.uid)
  //           .update(user.toJson());
  //       retVal = "success";
  //     } else {
  //       await _firestore
  //           .collection("users")
  //           .doc(user.uid)
  //           .update(user.toJson());
  //       retVal = "success";
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   return retVal;
  // }

  List<OurUser> fetchUser = [];
  Future<List<OurUser>> fetchUsersToCall() async{

    try{
      // var snaps = FirebaseFirestore.instance.collection("users")
      //     .withConverter<OurUser>(fromFirestore: (snapshot, _) => OurUser.fromJson(snapshot.data()!),
      //     toFirestore: (user,_) =>  user.toJson());

      var snaps =await _firestore.collection("users").get();
      for (var element in snaps.docs) {
        element.data();
      }
      await Future.forEach<dynamic>(snaps.docs, (element) async{
        Map<String,dynamic> data = await element?.data();
        fetchUser.add(OurUser.fromJson(data));
      });


      print("fetchUser ${fetchUser.length}");
    }
    catch(e) {
      print(e);
    }



    return fetchUser;
  }


  Future<String> updateCall(String userId,Map<String,dynamic> data) async{
    String retVal = "error";

    try{
      _firestore.collection("users").doc(userId).update({"someOneCalling":data});
      retVal = "success";
    }catch(e) {
      print(e);
    }

    return retVal;
  }



}