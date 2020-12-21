import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class FacultyAwards extends StatefulWidget {
  @override
  _FacultyAwardsState createState() => _FacultyAwardsState();
}

class _FacultyAwardsState extends State<FacultyAwards> {

  List<charts.Series<Awards, int>> _seriesLineData;
  _generateData(){
    var linedataSCIT = [
      new Awards(0, 40),
      new Awards(1, 45),
      new Awards(2, 35),
      new Awards(3, 62),
      new Awards(4, 50),
      new Awards(5, 70),
    ];
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'SCIT',
        data: linedataSCIT,
        domainFn: (Awards award, _) => award.yearval,
        measureFn: (Awards award, _) => award.awardsval,
      ),
    );
  }

  @override
  void initState(){
      super.initState();
      _seriesLineData = List<charts.Series<Awards, int>>();
      _generateData();
  }
  Material myChart(String title, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(color: new Color(color), fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 350,
                  child: charts.LineChart(
                    _seriesLineData,
                      defaultRenderer: new charts.LineRendererConfig(includeArea:true, stacked: true),
                      animate: true,
                      animationDuration: Duration(seconds: 3),
                      behaviors: [
                        new charts.ChartTitle('Years',
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                        new charts.ChartTitle('Awards',
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                      ]
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  Material myCard(String title, String total ,int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(color: new Color(color), fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      total,
                      style: TextStyle(color: new Color(color), fontSize: 30.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        children: <Widget>[
          myChart( "Faculty Awards", 0xffed622b),
          myCard( "Total Awards", "200",0xffed622b),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 400.0),
          StaggeredTile.extent(2, 150.0)
        ],
      ),
    );
  }
}

class Awards{
  int awardsval;
  int yearval;

  Awards(this.yearval,this.awardsval);
}
