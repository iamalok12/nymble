class PlayerStats {
  String? name;
  String? status;
  String? time;

  PlayerStats({this.name, this.status, this.time});

  PlayerStats.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    status = json['status'] as String;
    time = json['time'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['status'] = status;
    data['time'] = time;
    return data;
  }
}
