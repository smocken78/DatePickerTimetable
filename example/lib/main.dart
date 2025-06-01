import 'package:date_picker_timetable/date_picker_timetable.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Date Picker Table Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    this.title,
  });
  final String? title;

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatePickerController _controller = DatePickerController();

  DateTime _selectedDayValue = DateTime.now();
  DateTime _selectedMonthValue = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  // function to get total days in a month
  int daysInMonth(DateTime date) {
    var firstDayThisMonth = firstDayOfMonth(
      date,
    );
    var firstDayNextMonth = new DateTime(
      date.year,
      date.month + 1,
      1,
    );

    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  // function to get the first day of the month
  DateTime firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () {
            _controller.animateToSelection();
          },
        ),
        body: Container(
          padding: EdgeInsets.all(
            20.0,
          ),
          color: Colors.blueGrey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You Selected Month:"),
              Padding(
                padding: EdgeInsets.all(
                  10,
                ),
              ),
              Text(
                _selectedMonthValue.toString(),
              ),
              Padding(
                padding: EdgeInsets.all(
                  20,
                ),
              ),
              Text("You Selected Day:"),
              Padding(
                padding: EdgeInsets.all(
                  10,
                ),
              ),
              Text(
                _selectedDayValue.toString(),
              ),
              Padding(
                padding: EdgeInsets.all(
                  20,
                ),
              ),
              Container(
                child: MonthPicker(
                  startDate: DateTime.now(),
                  height: 90,
                  initialSelectedDate: _selectedMonthValue,
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedMonthValue = date;
                    });
                  },
                ),
              ),
              Container(
                child: DatePicker(
                  firstDayOfMonth(_selectedMonthValue),
                  width: 60,
                  height: 90,
                  controller: _controller,
                  initialSelectedDate: _selectedDayValue,
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  daysCount: daysInMonth(_selectedMonthValue),
                  inactiveDates: [
                    DateTime.now().add(
                      Duration(
                        days: 3,
                      ),
                    ),
                    DateTime.now().add(
                      Duration(
                        days: 4,
                      ),
                    ),
                    DateTime.now().add(
                      Duration(
                        days: 7,
                      ),
                    ),
                  ],
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedDayValue = date;
                    });
                  },
                ),
              ),
              YearPickerTimeline(
                startDate: DateTime.now(),
                yearCount: 10,
                height: 90,
                width: 70,
                initialSelectedDate: _selectedMonthValue,
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                borderRadius: BorderRadius.circular(
                  12,
                ),
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedMonthValue = date;
                  });
                },
              )
            ],
          ),
        ));
  }
}
