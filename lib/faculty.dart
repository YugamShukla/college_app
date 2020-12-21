import 'package:college_app/awards_faculty.dart';
import 'package:college_app/research_faculty.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Faculty extends StatefulWidget {
  Faculty({
    this.xvalues,
    this.yvalues,
    this.graph,
    this.xlabel,
    this.ylabel,
  });
  List xvalues;
  List yvalues;
  int graph;
  String xlabel;
  String ylabel;
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
            backgroundColor: xLightBlue,
            bottom: TabBar(
              labelColor: xOrange,
              unselectedLabelColor: Colors.white,
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
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  xLightYellow,
                  xOrange,
                ],
              ),
            ),
            child: TabBarView(children: [
              FacultyResearch(),
              FacultyAwards(
                graph: widget.graph,
                xlabel: widget.xlabel,
                xvalues: widget.xvalues,
                ylabel: widget.ylabel,
                yvalues: widget.yvalues,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
