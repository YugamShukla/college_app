import 'package:college_app/constants.dart';
import 'package:college_app/department.dart';
import 'package:college_app/faculty.dart';
import 'package:flutter/material.dart';

class Views extends StatefulWidget {
  @override
  _ViewsState createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Views"),
      //   backgroundColor: xLightBlue,
      // ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 100,
                    child: Image.asset('assets/logo.png'),
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Text(
                            "Welcome to Info@MUJ",
                            style: new TextStyle(
                              fontSize: 30.0,
                              color: xBrown,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                  new Container(
                    height: 20,
                  ),
                  FlatButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DepartmentList(),
                      ),
                    ),
                    child: Text("Faculty Stats"),
                    textColor: Colors.white,
                    color: xLightBlue,
                  ),
                  new Container(
                    height: 20,
                  ),
                  FlatButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DepartmentList(),
                      ),
                    ),
                    child: Text("Student Stats"),
                    textColor: Colors.white,
                    color: xLightBlue,
                  ),
                  Container(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
