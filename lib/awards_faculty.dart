// import 'dart:ui';

import 'package:college_app/chart_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class FacultyAwards extends StatefulWidget {
  FacultyAwards({
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
  _FacultyAwardsState createState() => _FacultyAwardsState();
}

class _FacultyAwardsState extends State<FacultyAwards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        children: <Widget>[
          // myChart( "Faculty Awards", 0xffed622b),
          // myCard( "Total Awards", "200",0xffed622b),
          ChartBuilder(
            graph: widget.graph,
            xlabel: widget.xlabel,
            xvalues: widget.xvalues,
            ylabel: widget.ylabel,
            yvalues: widget.yvalues,
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 400.0),
          StaggeredTile.extent(2, 150.0)
        ],
      ),
    );
  }
}
