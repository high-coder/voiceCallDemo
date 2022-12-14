import 'package:call_demo/controllers/authController.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

import '../../controllers/current_state.dart';
import '../../utils/our_colours.dart';

class OurLoginPage extends StatefulWidget {
  const OurLoginPage({Key? key}) : super(key: key);

  @override
  _OurLoginPageState createState() => _OurLoginPageState();
}

class _OurLoginPageState extends State<OurLoginPage> {

  var isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final CurrentState _instance = Get.find();
  final AuthService authController = Get.put(AuthService());
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    double width = mediaQueryData.size.width;
    double height = mediaQueryData.size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: width,
                  height: height - 130,
                  //height: height / 3.3 > 270 ? 280 : height / 3.3,
                  child: Lottie.asset("assets/lottie/login.json")),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.all(20),
                    child: NeoPopButton(
                      color: Colors.black,
                      bottomShadowColor: MyColors.googleGreen,
                      rightShadowColor: MyColors.googleBlue,
                      //leftShadowColor: MyColors.googleYellow,
                      animationDuration: Duration(milliseconds: 100),
                      depth: 3,
                      onTapUp: () {
                        print("someone is calling me here mate");
                        authController.loginUserWithGoogle(context);
                      },
                      onTapDown: () {
                        print("Calling me in the down area");
                      },

                      child: Padding(
                        //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Login with Google",
                                style: GoogleFonts.openSans(
                                    color: Colors.white, fontSize: 15)),
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset('assets/icons/Google.png')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
