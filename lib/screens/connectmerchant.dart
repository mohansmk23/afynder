import 'package:afynder/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ConnectMerchant extends StatefulWidget {
  @override
  _ConnectMerchantState createState() => _ConnectMerchantState();
}

class _ConnectMerchantState extends State<ConnectMerchant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xd9ffffff),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.transparent,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                  child: Icon(Icons.close),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                Expanded(
                  child: Hero(
                      tag: 'interest',
                      child: Text(
                        "Interested ? ",
                        style: TextStyle(color: Colors.black54, fontSize: 22.0),
                      )),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 24.0,
            ),
            SocialMediaButton(
              prefixIcon: Icon(Icons.call),
              text: "Call to phone",
              buttonColor: Colors.blueAccent,
            ),
            SizedBox(
              height: 12.0,
            ),
            SocialMediaButton(
              prefixIcon: Icon(Icons.mail_outline),
              text: "Send E-Mail",
              buttonColor: Colors.redAccent,
            ),
            SizedBox(
              height: 12.0,
            ),
            SocialMediaButton(
              prefixIcon: Icon(FontAwesome.whatsapp),
              text: "Whatsapp",
              buttonColor: Colors.greenAccent,
            )
          ],
        ),
      ),
    );
  }
}
