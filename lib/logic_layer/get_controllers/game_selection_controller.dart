import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GameSelectionPageController extends GetxController{
  RxBool isLoggedIn=false.obs;

  void getUser(){
    if(FirebaseAuth.instance.currentUser!=null){
      isLoggedIn(true);
    }
    else{
      isLoggedIn(false);
    }
  }
}
