import 'package:afynder/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "Profile",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromRGBO(12, 63, 102, 1)),
          ),
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new ExactAssetImage(
                                            'assets/profileavatar.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Wallet balance",
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 22.0,
                                        backgroundColor: Colors.indigoAccent,
                                        child: Icon(Ionicons.md_wallet),
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        "580 Rs",
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24.0),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                            child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/wishlist');
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "WishLists",
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 22.0,
                                          backgroundColor: Colors.indigoAccent,
                                          child: Icon(Icons.bookmark),
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          "27",
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/paymenthistory');
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.history,
                        color: Colors.indigoAccent,
                      ),
                      title: Text("See my wallet history"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showGeneralDialog(
                          barrierColor:
                              Colors.black.withOpacity(0.5), //SHADOW EFFECT
                          transitionBuilder: (context, a1, a2, widget) {
                            return Center(
                              child: Container(
                                height: 400, // USE PROVIDED ANIMATION
                                width: 400,
                                color: Colors.blueAccent,
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width: 75.0,
                                        height: 75.0,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            image: new ExactAssetImage(
                                                'assets/profileavatar.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 16.0,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          "John Doe",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              decoration: TextDecoration.none),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Image.asset("assets/qrcode.png")
                                  ],
                                ),
                              ),
                            );
                          },
                          transitionDuration: Duration(
                              milliseconds: 200), // DURATION FOR ANIMATION
                          barrierDismissible: true,
                          barrierLabel: 'LABEL',
                          context: context,
                          pageBuilder: (context, animation1, animation2) {
                            return Text('PAGE BUILDER');
                          });
                    },
                    child: ListTile(
                      leading: Icon(
                        FontAwesome.qrcode,
                        color: Colors.indigoAccent,
                      ),
                      title: Text("Use Wallet Balance"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
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
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter Email ID"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
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
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter Mobile Number"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
