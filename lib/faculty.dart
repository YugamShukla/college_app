import 'package:college_app/awards_faculty.dart';
import 'package:college_app/research_faculty.dart';
import 'package:flutter/material.dart';

class Faculty extends StatefulWidget {
  @override
  _FacultyState createState() => _FacultyState();
}

class _FacultyState extends State<Faculty> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffffffff),
            bottom: TabBar(
              labelColor: Colors.orangeAccent,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: "Research",
                ),
                Tab(
                  text: "Awards",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            FacultyResearch(),
            FacultyAwards(),
          ]),
        ),
      ),
    );
  }
}
