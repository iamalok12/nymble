import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nymble/presentation_layer/screens/game_selection_page.dart';
import 'package:nymble/presentation_layer/utils/colors.dart';
import 'package:nymble/presentation_layer/utils/styles.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGround,
      body: SafeArea(
        child:Column(
          children: [
            SizedBox(height: 80.h,),
            Center(child: Text("Nymble",style: TextStyle(color: kPrimary,fontSize: 26.sp,fontWeight: FontWeight.w500),),),
            SizedBox(height: 30.h,),
            Center(child: Text("Tic Tac Toe",style: TextStyle(color: Colors.white,fontSize: 40.sp,fontWeight: FontWeight.w500,fontFamily: "PermanentMarker"),),),
            SizedBox(height: 260.h,),
            ElevatedButton(
              onPressed: () {
                Future<void> signInWithGoogle() async {
                  try{
                    await FirebaseAuth.instance.signOut();
                    final GoogleSignInAccount? googleUser =
                    await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication? googleAuth =
                    await googleUser?.authentication;
                    final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth?.accessToken,
                      idToken: googleAuth?.idToken,
                    );
                    await FirebaseAuth.instance
                        .signInWithCredential(credential).then((value)async{
                      Get.to(GameSelection());
                    });
                  }
                  catch(e){
                    debugPrint(e.toString());
                  }
                }
                signInWithGoogle();
              },
              child: SizedBox(
                width: 250.w,
                height: 40.h,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      height: 38.w,
                      width: 38.w,
                      color: Colors.white,
                      child: Image.asset(
                        "assets/icons/sign_in_icon.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Text(
                      "Sign up with Google",
                      style: kGoogleButton,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Get.to(GameSelection());
              },
              child: Container(
                height: 25.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ,),
                child: Center(child: Text("Skip",style: TextStyle(color: kPrimary,fontSize: 16.sp),),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
