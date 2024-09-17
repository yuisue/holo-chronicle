import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const HoloChronicle());
}

class HoloChronicle extends StatelessWidget {
  const HoloChronicle({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holo Chronicle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const HoloCalendar(title: 'Hololive Calendar'),
    );
  }
}

class HoloCalendar extends StatefulWidget {
  const HoloCalendar({super.key, required this.title});
  final String title;

  @override
  State<HoloCalendar> createState() => _HoloCalendarState();
}

class _HoloCalendarState extends State<HoloCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2017, 09, 01),
        lastDay: DateTime.utc(2099, 12, 31),
        focusedDay: _focusedDay,
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onDaySelected: _onDaySelected,
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
