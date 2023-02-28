class AlertClass {
  final String time;
  final List<dynamic> AlertDays;
  AlertClass(this.time, this.AlertDays);
  AlertClass.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        AlertDays = json['AlertDays'];
  Map<String, dynamic> toJson() => {
        'time': time,
        'AlertDays': AlertDays,
      };
}
