
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nymble/logic_layer/get_controllers/game_selection_controller.dart';
import 'package:nymble/logic_layer/get_controllers/get_stats_controller.dart';
import 'package:nymble/presentation_layer/utils/colors.dart';

class GameStats extends StatelessWidget {
  
  Color getColor(String s){
    if(s=="Win"){
      return Colors.green;
    }
    else if(s=="Lost"){
      return Colors.red;
    }
    else{
      return Colors.orange;
    }
  }
  
  final GameSelectionPageController _controller=Get.find();
  final GetPlayerStatsController _statsController=Get.put(GetPlayerStatsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGround,
      body: SafeArea(
        child: Obx((){
          _controller.getUser();
          if(_controller.isLoggedIn.value==false){
            return Center(child: Text("Please login to see stats",style: TextStyle(fontSize: 18.sp,color: kPrimary),),);
          }
          else{
            return Obx((){
              _statsController.getStatus();
              if(_statsController.fetchStatus.value=="empty"){
                return Center(child: Text("No match played",style: TextStyle(fontSize: 18.sp,color: kPrimary),),);
              }
              else if(_statsController.fetchStatus.value=="error"){
                return Center(child: Text("Error occurred",style: TextStyle(fontSize: 18.sp,color: kPrimary),),);
              }
              else if(_statsController.fetchStatus.value=="loaded"){
                return ListView(
                  children: _statsController.list.map((e) => Container(
                    padding: EdgeInsets.all(10.w),
                    margin: EdgeInsets.all(7.w),
                    height: 80.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.h,),
                              Text(e.name!,style: TextStyle(fontSize: 20.sp,color: kPrimary),),
                              SizedBox(height: 10.h,),
                              Text(e.time!,style: const TextStyle(color: Colors.black45),)
                            ],
                          ),
                        ),
                        Text(e.status!,style: TextStyle(fontSize: 25.sp,color: getColor(e.status!),fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),).toList(),
                );
              }
              else{
                return const Center(child: CircularProgressIndicator(),);
              }
            });
          }
        }),
      ),
    );
  }
}
