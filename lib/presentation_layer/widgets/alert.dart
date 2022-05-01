import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nymble/logic_layer/models/player_stats.dart';
import 'package:nymble/presentation_layer/screens/game_selection_page.dart';
import 'package:nymble/presentation_layer/utils/colors.dart';


void showAlert(BuildContext context, String s) {
  Widget showResult(String s) {
    if (s == "X") {
      return Lottie.asset(
        'assets/lottie/win.json',
        height: 200.w,
        width: 200.w,
        fit: BoxFit.scaleDown,
      );
    } else if (s == "D") {
      return Center(
        child: Text(
          "Draw",
          style: TextStyle(
              fontSize: 30.sp, color: kPrimary, fontFamily: "PermanentMarker",),
        ),
      );
    } else {
      return Lottie.asset(
        'assets/lottie/lost.json',
        height: 200.w,
        width: 200.w,
        fit: BoxFit.scaleDown,
      );
    }
  }

  showDialog(
    context: context,
    builder: (_) {
      return Material(
        color: Colors.transparent,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              color: Colors.white,
              height: 250.h,
              width: 200.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 200.w,
                    width: 200.w,
                    child: showResult(s),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(FirebaseAuth.instance.currentUser!=null){
                        String status="Lost";
                        if(s=="X"){
                          status="Win";
                        }
                        else if(s=="D"){
                          status="Draw";
                        }
                        final PlayerStats model=PlayerStats(
                          name: FirebaseAuth.instance.currentUser!.displayName,
                          status: status,
                          time: "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute}",
                        );
                        await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc().set(
                          model.toJson(),
                        ).then((value){
                          Navigator.pop(_);
                          Get.to(GameSelection());
                        }).onError((error, stackTrace){
                          Get.snackbar("Something wrong", "");
                        });
                      }
                      else{
                        Navigator.pop(_);
                        Get.to(GameSelection());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kPrimary,
                      fixedSize: Size(120.w, 30.h),
                    ),
                    child: Text(
                      "Next match",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
