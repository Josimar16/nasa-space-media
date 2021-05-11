class DateToStringConverter {
  static String convert(DateTime date) {
    var dateSpliteed = date.toString().split(' ');
    return dateSpliteed.first;
  }
}
