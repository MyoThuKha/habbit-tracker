DateTime changeToDateTime(String yyyymmdd) {
  int year = int.parse(yyyymmdd.substring(0, 4));
  int month = int.parse(yyyymmdd.substring(4, 6));
  int day = int.parse(yyyymmdd.substring(6, 8));
  return DateTime(year, month, day);
}

String changeToString(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String day = dateTime.day.toString();

  month = month.length == 1 ? "0$month" : month;
  day = day.length == 1 ? "0$day" : day;

  return year + month + day;
}

String todayDate() {
  DateTime current = DateTime.now();
  String result = changeToString(current);

  return result;
}
