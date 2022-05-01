import 'package:get/get.dart';
import 'package:nymble/data_layer/get_stats.dart';
import 'package:nymble/logic_layer/models/player_stats.dart';

class GetPlayerStatsController extends GetxController{
  final GetPlayerStats _stats=GetPlayerStats();
  RxString fetchStatus="loading".obs;
  RxList<PlayerStats> list=<PlayerStats>[].obs;
  Future<void> getStatus()async{
    try{
      final List<PlayerStats> statusList=await _stats.getStats();
      if(statusList.isEmpty){
        fetchStatus("empty");
      }
      else{
        list.value=statusList;
        fetchStatus("loaded");
      }
    }
    catch(e){
      fetchStatus("error");
    }
  }
}
