import 'package:hive/hive.dart';

part 'our_user_model.g.dart';

/// The user can signup using google and also with email and password
@HiveType(typeId: 123, adapterName: "OurUserDetailOriginal")
class OurUser {
  @HiveField(0)
  String? uid;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? imgUrl;



  /// from the map to convert the data back into the normal form
  factory OurUser.fromJson(Map<String, dynamic> data) {
    return OurUser(
      uid: data['uid'],
      email: data['email'],
      name: data["name"],
      imgUrl:data["imgUrl"],
    );
  }

  /// this will be used to save the map data in the firebase database
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name":name,
      "imgUrl":imgUrl,
    };
  }

  OurUser(
      {
        this.email,
        this.name,
        this.uid,
        this.imgUrl,
      });
}
