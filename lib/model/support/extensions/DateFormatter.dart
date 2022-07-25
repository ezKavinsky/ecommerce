import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  static DateTime fromString(String value){
    return DateTime(int.parse(value.substring(4,0)), int.parse(value.substring(2,4)), int.parse(value.substring(0,2)));
  }

  String toStringUnlashed(){
    NumberFormat formatter = NumberFormat("00");
    return formatter.format(day) + formatter.format(month) + formatter.format(year);
  }

  String toStringSlashed(){
    NumberFormat formatter = NumberFormat("00");
    return formatter.format(day) + "/" + formatter.format(month) + "/" + formatter.format(year);
  }

}