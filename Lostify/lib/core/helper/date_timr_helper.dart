import 'package:flutter/material.dart';

class DateTimeHelper {
  /// Format Date to dd/MM/yyyy or show placeholder text
  static String formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  /// Format TimeOfDay according to locale or show placeholder text
  static String formatTimeOfDay(TimeOfDay? time, BuildContext context) {
    if (time == null) return 'Select Time';
    return MaterialLocalizations.of(context).formatTimeOfDay(time);
  }

  /// Show Date Picker dialog and return picked date or null
  static Future<DateTime?> pickDate(BuildContext context,
      {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
    );
  }

  /// Show Time Picker dialog and return picked time or null
  static Future<TimeOfDay?> pickTime(BuildContext context,
      {TimeOfDay? initialTime}) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
  }
}

