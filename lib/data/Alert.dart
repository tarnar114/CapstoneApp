class AlertClass {
  final String time;
  final List<dynamic> alertDays;
  AlertClass(this.time, this.alertDays);
  AlertClass.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        alertDays = json['AlertDays'];
  Map<String, dynamic> toJson() => {
        'time': time,
        'AlertDays': alertDays,
      };
}
