import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nymble/logic_layer/get_controllers/game_selection_controller.dart';
import 'package:nymble/presentation_layer/screens/auth_page.dart';
import 'package:nymble/presentation_layer/screens/game_page.dart';
import 'package:nymble/presentation_layer/screens/game_stats.dart';
import 'package:nymble/presentation_layer/utils/colors.dart';
import 'package:nymble/presentation_layer/widgets/help.dart';

class GameSelection extends StatefulWidget {
  @override
  State<GameSelection> createState() => _GameSelectionState();
}

class _GameSelectionState extends State<GameSelection> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      _controller.getUser();
    });
    super.initState();
  }

  final GoogleSignIn _googleSignIn =GoogleSignIn();

  final GameSelectionPageController _controller =
      Get.put(GameSelectionPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGround,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  showHelp(context);
                },
                icon: Icon(
                  Icons.help,
                  size: 30.sp,
                  color: kPrimary,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.to(const GamePage());
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kPrimary, width: 2),
                  ),
                  height: 200.w,
                  width: 200.w,
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.computer_outlined,
                          color: kPrimary,
                          size: 100.sp,
                        ),
                        Text(
                          "vs",
                          style: TextStyle(fontSize: 18.sp, color: kPrimary),
                        ),
                        Text(
                          "AI",
                          style: TextStyle(fontSize: 50.sp, color: kPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200.w,
              width: 200.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        height: 200.w,
                        width: 200.w,
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.perm_identity,
                                color: Colors.grey,
                                size: 100.sp,
                              ),
                              Text(
                                "vs",
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              Text(
                                "Player",
                                style: TextStyle(
                                  fontSize: 50.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.white54,
                  ),
                  Center(
                    child: Text(
                      "Coming soon!",
                      style: TextStyle(color: kPrimary, fontSize: 20.sp),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 120.h,
            ),
            Container(
              padding: EdgeInsets.all(2.w),
              width: 250.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Obx(
                  () {
                    if (_controller.isLoggedIn.value == false) {
                      return IconButton(
                        onPressed: () {
                          Get.to(GameStats());
                        },
                        icon: Icon(
                          Icons.leaderboard,
                          size: 30.sp,
                          color: kPrimary,
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(GameStats());
                            },
                            icon: Icon(
                              Icons.leaderboard,
                              size: 30.sp,
                              color: kPrimary,
                            ),
                          ),
                          IconButton(
                            onPressed: ()async {
                              await FirebaseAuth.instance.signOut().then((value)async{
                                await _googleSignIn.disconnect().then((value){
                                  Get.to(const AuthPage());
                                });
                              });
                            },
                            icon: Icon(
                              Icons.logout,
                              size: 30.sp,
                              color: kPrimary,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
