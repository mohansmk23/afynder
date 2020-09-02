import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Flexible(
                  child: new TextField(
                    decoration: const InputDecoration(
                      hintText: "Enter Your Name",
                    ),
                  ),
                ),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(
                      'Email ID',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Flexible(
                  child: new TextField(
                    decoration:
                        const InputDecoration(hintText: "Enter Email ID"),
                  ),
                ),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(
                      'Mobile',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Flexible(
                  child: new TextField(
                    decoration:
                        const InputDecoration(hintText: "Enter Mobile Number"),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
