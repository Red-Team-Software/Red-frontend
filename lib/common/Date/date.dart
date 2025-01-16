class DateMapper {
  static String isoToDDMMYY(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year.toString().substring(2)}";
  }

  static String isoToHHMMAM(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour >= 12 ? "pm" : "am";
    hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return "${hour.toString().padLeft(2, '0')}:"
        "${minute.toString().padLeft(2, '0')} $period";
  }
}
