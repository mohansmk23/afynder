import 'package:afynder/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "All Transactions",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
                  ),
                  title: Text("Manoj Furnitures"),
                  subtitle: Text("August 15 2020"),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Redeem",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ),
                        color: Colors.red[300],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "-",
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(
                            FontAwesome.rupee,
                            color: Colors.redAccent,
                            size: 18.0,
                          ),
                          Text(
                            "300",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                        "https://www.pngitem.com/pimgs/m/627-6275754_chad-profile-pic-profile-photo-circle-png-transparent.png"),
                  ),
                  title: Text("Nakoda Electronics"),
                  subtitle: Text("August 17 2020"),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Credit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ),
                        color: Colors.green[300],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "+",
                            style: TextStyle(color: Colors.green),
                          ),
                          Icon(
                            FontAwesome.rupee,
                            color: Colors.green,
                            size: 18.0,
                          ),
                          Text(
                            "300",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                        "https://www.pngitem.com/pimgs/m/75-758282_walter-circle-person-photo-in-circle-hd-png.png"),
                  ),
                  title: Text("Test Shop"),
                  subtitle: Text("july 25 2020"),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Credit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ),
                        color: Colors.green[300],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "-",
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(
                            FontAwesome.rupee,
                            color: Colors.redAccent,
                            size: 18.0,
                          ),
                          Text(
                            "30",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                        "https://www.getroadmap.com/wp-content/uploads/2019/01/final-1.png"),
                  ),
                  title: Text("Givson Musicals"),
                  subtitle: Text("September 23 2020"),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Credit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ),
                        color: Colors.green[300],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "+",
                            style: TextStyle(color: Colors.green),
                          ),
                          Icon(
                            FontAwesome.rupee,
                            color: Colors.green,
                            size: 18.0,
                          ),
                          Text(
                            "5000",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
                  ),
                  title: Text("Manoj Furnitures"),
                  subtitle: Text("August 15 2020"),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Redeem",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ),
                        color: Colors.red[300],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "-",
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(
                            FontAwesome.rupee,
                            color: Colors.redAccent,
                            size: 18.0,
                          ),
                          Text(
                            "300",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
                  ),
                  title: Text("Manoj Furnitures"),
                  subtitle: Text("August 15 2020"),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Credit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ),
                        color: Colors.green[300],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "-",
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(
                            FontAwesome.rupee,
                            color: Colors.redAccent,
                            size: 18.0,
                          ),
                          Text(
                            "300",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                        "https://www.pngitem.com/pimgs/m/404-4042710_circle-profile-picture-png-transparent-png.png"),
                  ),
                  title: Text("Manoj Furnitures"),
                  subtitle: Text("August 15 2020"),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Credit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                        ),
                        color: Colors.green[300],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "-",
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(
                            FontAwesome.rupee,
                            color: Colors.redAccent,
                            size: 18.0,
                          ),
                          Text(
                            "300",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
