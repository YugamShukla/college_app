import 'package:college_app/faculty.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class DepartmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Department Lists",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Department List"),
          backgroundColor: xDarkBlue,
        ),
        body: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     xLightYellow,
            //     xOrange,
            //   ],
            // ),
            color: xLightBlue,
          ),
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              choices.length,
              (index) {
                return Center(
                  child: SelectCard(choice: choices[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'SCIT', icon: Icons.computer_rounded),
  const Choice(title: 'Electrical', icon: Icons.sensor_window_rounded),
  const Choice(title: 'SAMM', icon: Icons.car_repair),
  const Choice(title: 'Chem&Civil', icon: Icons.home),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: xLightBlue,
      fontSize: 30,
    );
    return Card(
      color: xDarkBlue,
      child: Center(
          child: FlatButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Faculty(),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              choice.icon,
              size: 50.0,
              color: xLightBlue,
            ),
            Text(
              choice.title,
              style: textStyle,
            ),
          ],
        ),
      )),
    );
  }
}
