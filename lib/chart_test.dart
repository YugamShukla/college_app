import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:random_color/random_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ChartBuilder(),
    );
  }
}

class ChartBuilder extends StatefulWidget {
  ChartBuilder({
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
  _ChartBuilderState createState() => _ChartBuilderState();
}

class _ChartBuilderState extends State<ChartBuilder> {
  // List xvalues;
  // List yvalues;
  // int graph;
  // String xlabel;
  // String ylabel;
  // _ChartBuilderState(
  //     this.xlabel, this.ylabel, this.xvalues, this.yvalues, this.graph);
  List<charts.Series<LineChartValue, int>> _seriesLineData;
  List<charts.Series<BarChartValue, String>> _seriesBarData;
  List<charts.Series<PieChartValue, String>> _seriesPieData;
  RandomColor _randomColor = RandomColor();
  _generatelineData() {
    var linedata = [
      for (int i = 0; i < widget.xvalues.length; i++)
        new LineChartValue(widget.xvalues[i], widget.yvalues[i])
    ];
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Line Graph',
        data: linedata,
        domainFn: (LineChartValue chart, _) => chart.xval,
        measureFn: (LineChartValue chart, _) => chart.yval,
      ),
    );
  }

  _generatebarData() {
    var bar = [
      for (int i = 0; i < widget.xvalues.length; i++)
        new BarChartValue(widget.xvalues[i].toString(), widget.yvalues[i])
    ];
    _seriesBarData.add(
      charts.Series(
        domainFn: (BarChartValue chart, _) => chart.year,
        measureFn: (BarChartValue chart, _) => chart.yval,
        id: 'Bar Graph',
        data: bar,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (BarChartValue chart, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );
  }

  // _generatepiedata() {
  //   var pie = [
  //     for (int i = 0; i < widget.xvalues.length; i++)
  //       new PieChartValue(widget.xvalues[i].toString(), widget.yvalues[i],
  //           _randomColor.randomColor())
  //   ];
  //   _seriesPieData.add(
  //     charts.Series(
  //       domainFn: (PieChartValue task, _) => task.task,
  //       measureFn: (PieChartValue task, _) => task.taskvalue,
  //       colorFn: (PieChartValue task, _) =>
  //           charts.ColorUtil.fromDartColor(task.colorval),
  //       id: 'Air Pollution',
  //       data: pie,
  //       labelAccessorFn: (PieChartValue row, _) => '${row.taskvalue}',
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _seriesLineData = List<charts.Series<LineChartValue, int>>();
    _seriesBarData = List<charts.Series<BarChartValue, String>>();
    _seriesPieData = List<charts.Series<PieChartValue, String>>();
    if (widget.graph == 0)
      _generatelineData();
    else if (widget.graph == 1) _generatebarData();
    // else if (widget.graph == 2) _generatepiedata();
  }

  Material mylineChart(String title, int color) {
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
                    child: charts.LineChart(_seriesLineData,
                        defaultRenderer: new charts.LineRendererConfig(
                            includeArea: true, stacked: true),
                        animate: true,
                        animationDuration: Duration(seconds: 1),
                        behaviors: [
                          new charts.ChartTitle(widget.xlabel,
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea),
                          new charts.ChartTitle(widget.ylabel,
                              behaviorPosition: charts.BehaviorPosition.start,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea),
                        ]))
              ],
            )
          ],
        ),
      ),
    );
  }

  Material myBarChart(String title, int color) {
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
                  width: 350.0,
                  height: 350.0,
                  child: charts.BarChart(
                    _seriesBarData,
                    animate: true,
                    behaviors: [
                      new charts.ChartTitle(widget.xlabel,
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      new charts.ChartTitle(widget.ylabel,
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                    ],
                    animationDuration: Duration(seconds: 1),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Material myPieChart(String title, int color) {
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
                  width: 350.0,
                  height: 350.0,
                  child: charts.PieChart(_seriesPieData,
                      animate: true,
                      animationDuration: Duration(seconds: 1),
                      behaviors: [
                        new charts.DatumLegend(
                          outsideJustification:
                              charts.OutsideJustification.endDrawArea,
                          horizontalFirst: false,
                          desiredMaxRows: 2,
                          cellPadding:
                              new EdgeInsets.only(right: 4.0, bottom: 4.0),
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.purple.shadeDefault,
                              fontFamily: 'Georgia',
                              fontSize: 11),
                        )
                      ],
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 100,
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.inside)
                          ])),
                ),
              ],
            )
          ],
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
          widget.graph == 1
              ? myBarChart("Faculty Awards", 0xffed622b)
              : mylineChart("Faculty Awards", 0xffed622b),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 400.0),
        ],
      ),
    );
  }
}

class LineChartValue {
  int xval;
  int yval;

  LineChartValue(this.xval, this.yval);
}

class BarChartValue {
  String year;
  int yval;
  BarChartValue(this.year, this.yval);
}

class PieChartValue {
  String task;
  double taskvalue;
  Color colorval;

  PieChartValue(this.task, this.taskvalue, this.colorval);
}
