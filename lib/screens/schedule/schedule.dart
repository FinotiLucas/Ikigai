import 'package:ikigai/widgets/mainAppBar.dart';
import 'package:ikigai/widgets/myGridView.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int option = 1;
  int index = 0;
  double fontSize = 18;
  Future _future;
  double _width;
  WeekDayList _selectedWeekDay;

  @override
  void initState() {
    _future = getSchedule();
    super.initState();
  }

  Future getSchedule() async {
    var jikan = Jikan();
    var anime = await jikan.getSchedule();
    return anime;
  }

  List _returnWeekDayData(data) {
    return [
      data.sunday,
      data.monday,
      data.tuesday,
      data.wednesday,
      data.thursday,
      data.friday,
      data.saturday,
    ];
  }

  body(data) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(_width * 0.1, 0, _width * 0.1, 0),
          height: 60,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                hint: _selectedWeekDay == null
                    ? Text(
                        'Choose a day of the week',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        _selectedWeekDay.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 45,
                ),
                isExpanded: true,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
                items: WeekDayList.getLanguages().map((WeekDayList weekDay) {
                  return DropdownMenuItem<WeekDayList>(
                    value: weekDay,
                    child: Text(weekDay.name),
                  );
                }).toList(),
                onChanged: (WeekDayList val) {
                  setState(
                    () {
                      _selectedWeekDay = val;
                      index = _selectedWeekDay.id;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: myGridView(data, option, false),
        ),
      ],
    );
  }

  futureBuilder() {
    return new FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return body(_returnWeekDayData(snapshot.data)[index]);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: futureBuilder(),
      appBar: mainAppBar(context, "Anime Schedule"),
    );
  }
}

class WeekDayList {
  final int id;
  final String name;

  WeekDayList(this.id, this.name);

  static List<WeekDayList> getLanguages() {
    return <WeekDayList>[
      WeekDayList(0, 'Sunday'),
      WeekDayList(1, 'Monday'),
      WeekDayList(2, 'Tuesday'),
      WeekDayList(3, 'Wednesday'),
      WeekDayList(4, 'Thursday'),
      WeekDayList(5, 'Friday'),
      WeekDayList(6, 'Saturday'),
    ];
  }
}
