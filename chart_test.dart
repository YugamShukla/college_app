import 'dart:ffi';
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
      home: ChartBuilder(graph: "line"),
    );
  }
}

class ChartBuilder extends StatefulWidget {
  ChartBuilder({@required this.graph,this.xvaluesline,this.yvaluesline,this.xvaluesbar,this.yvaluesbar,this.xlabel,this.ylabel,this.taskpie,this.taskpercentagepie});
  List<DateTime> xvaluesline;
  List<int> yvaluesline;
  List<String> xvaluesbar;
  List<int> yvaluesbar;
  List<String> taskpie;
  List<double> taskpercentagepie;
  String graph;
  String xlabel;
  String ylabel;
  @override
  _ChartBuilderState createState() {
    return _ChartBuilderState();
  }
}

class _ChartBuilderState extends State<ChartBuilder> {

  List<charts.Series<LineChartValue, DateTime>> _seriesLineData;
  List<charts.Series<BarChartValue, String>> _seriesBarData;
  List<charts.Series<PieChartValue, String>> _seriesPieData;
  RandomColor _randomColor = RandomColor();
  _generatelineData(){
    var linedata = [
      for(int i=0;i<widget.xvaluesline.length;i++)
        new LineChartValue(widget.xvaluesline[i], widget.yvaluesline[i])
    ];
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Line Graph',
        data: linedata,
        domainFn: (LineChartValue chart, _) => chart.time,
        measureFn: (LineChartValue chart, _) => chart.yval,
      ),
    );
  }
  _generatebarData(){
    var bar = [
      for(int i=0;i<widget.xvaluesbar.length;i++)
        new BarChartValue(widget.xvaluesbar[i], widget.yvaluesbar[i])
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
  _generatepiedata(){
    var pie = [
      for(int i=0;i<widget.taskpie.length;i++)
        new PieChartValue(widget.taskpie[i], widget.taskpercentagepie[i], _randomColor.randomColor())
    ];
    _seriesPieData.add(
      charts.Series(
        domainFn: (PieChartValue task, _) => task.task,
        measureFn: (PieChartValue task, _) => task.taskvalue,
        colorFn: (PieChartValue task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: pie,
        labelAccessorFn: (PieChartValue row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _seriesLineData = List<charts.Series<LineChartValue, DateTime>>();
    _seriesBarData = List<charts.Series<BarChartValue, String>>();
    _seriesPieData = List<charts.Series<PieChartValue, String>>();
    if(widget.graph.toLowerCase() == "line")
      _generatelineData();
    else if(widget.graph.toLowerCase() == "bar")
      _generatebarData();
    else if(widget.graph.toLowerCase() =='pie')
      _generatepiedata();
  }
  Material myLineChart(String title, int color) {
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
                    child: charts.TimeSeriesChart(
                        _seriesLineData,
                        defaultRenderer: new charts.LineRendererConfig(
                            includeArea: true, stacked: true),
                        animate: true,
                        animationDuration: Duration(seconds: 2),
                        behaviors: [
                          new charts.ChartTitle(widget.xlabel,
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification: charts
                                  .OutsideJustification.middleDrawArea),
                          new charts.ChartTitle(widget.ylabel,
                              behaviorPosition: charts.BehaviorPosition.start,
                              titleOutsideJustification: charts
                                  .OutsideJustification.middleDrawArea),
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
                      width: 350,
                      height: 350,
                      child: charts.BarChart(
                        _seriesBarData,
                        animate: true,
                          behaviors: [
                            new charts.ChartTitle(widget.xlabel,
                                behaviorPosition: charts.BehaviorPosition.bottom,
                                titleOutsideJustification: charts
                                    .OutsideJustification.middleDrawArea),
                            new charts.ChartTitle(widget.ylabel,
                                behaviorPosition: charts.BehaviorPosition.start,
                                titleOutsideJustification: charts
                                    .OutsideJustification.middleDrawArea),
                          ],
                        animationDuration: Duration(seconds: 5),
                        barRendererDecorator: new charts.BarLabelDecorator<String>(),
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
                    width: 350,
                    height: 350,
                    child: charts.PieChart(
                      _seriesPieData,
                      animate: true,
                      animationDuration: Duration(seconds: 5),
                      behaviors: [
                    new charts.DatumLegend(
                    outsideJustification: charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 2,
                      cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
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
        children: <Widget>
        [widget.graph=='bar'? myBarChart( "Faculty Awards", 0xffed622b):myLineChart("Faculty Awards", 0xffed622b),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 400.0),
        ],
      ),
    );
  }
}

class LineChartValue{
  DateTime time;
  int yval;

  LineChartValue(this.time,this.yval);
}
class BarChartValue{
  String year;
  int yval;
  BarChartValue(this.year,this.yval);
}

class PieChartValue {
  String task;
  double taskvalue;
  Color colorval;

  PieChartValue(this.task, this.taskvalue, this.colorval);
}
