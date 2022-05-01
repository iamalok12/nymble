import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nymble/logic_layer/models/player_stats.dart';


class GetPlayerStats{
  Future<List<PlayerStats>> getStats()async{
    final List<PlayerStats> list=[];
    final data=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).get();
    if(data.size>0){
      for(int i=0;i<data.size;i++){
        final PlayerStats model=PlayerStats.fromJson(data.docs[i].data());
        list.add(model);
      }
    }
    return list;
  }
}
