import 'package:call_demo/models/our_user_model.dart';
import 'package:call_demo/service/logger_service.dart';
import 'package:hive_flutter/hive_flutter.dart';


/// Created by highcoder on 6:37 pm
/// this class will just be used for the purpose of reading and writing data into local storage




class LocalStorage {
  void setLoggedIn({required OurUser user}) async{
    Box _userBox = await Hive.openBox("userDetails");
    //if (_userBox.isNotEmpty) {
    _userBox.put('user', user);
    Logger.logS('User stored in local Storage', 'localstorage');
    //}
    //else {
    //Logger.logE('Error storing user ', 'localstorage');
    //}
  }

  getOurUser() async{
    try {
      Box _userBox = await Hive.openBox("userDetails");

      OurUser ourUser = _userBox.get('user')!;
      return ourUser;
    } catch (e) {
      print(e);

      return null;
    }
  }

  deleteOurUser() async{
    try{
      Box _userBox = await Hive.openBox("userDetails");

      OurUser ourUser = OurUser(
        name: "",
        uid: "",
        email: "",
      );
      await _userBox.put("user",ourUser);
    }catch(e) {
      print(e);
    }
  }

}