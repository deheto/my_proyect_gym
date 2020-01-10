import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryOverView extends StatefulWidget {
  @override
  _HistoryOverViewState createState() => _HistoryOverViewState();
}

class _HistoryOverViewState extends State<HistoryOverView> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
    );
  }
}
