import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nymble/presentation_layer/utils/colors.dart';

void showHelp(BuildContext context) {
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
              width: 220.w,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.w),
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        '''A 3-by-3 grid game, the player who is playing "X" always goes first. Players alternate placing Xs and Os on the board until either player has three in a row, horizontally, vertically, or diagonally or until all squares on the grid are filled. If a player is able to draw three Xs or three Os in a row, then that player wins.''',
                        style: TextStyle(fontSize: 15.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(_);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kPrimary,
                        fixedSize: Size(120.w, 30.h),
                      ),
                      child: Text(
                        "Close",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
