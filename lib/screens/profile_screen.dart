import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/filter_selection.dart';
import 'package:afynder/response_models/merchant_details.dart';
import 'package:afynder/response_models/profile_info.dart';
import 'package:afynder/screens/dashboard_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'categories_screen.dart' as categoriesscreen;
import 'nointernet_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _status = true, isImagePicked = false;
  File _image;
  final FocusNode myFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String fName, lName, email, mobile, password, qrCodePic;
  bool isLoading = true;
  Response response;
  ProfileModel model = new ProfileModel();
  final _controller = ScrollController();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();
  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController emailIdController = new TextEditingController();
  TextEditingController mobileNoController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void open_gallery() async {
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);

    _image = await ImageCropper.cropImage(
        sourcePath: _image.path, cropStyle: CropStyle.circle);

    setState(() {
      print("done");
      isImagePicked = true;
      updateProfileInfo();
    });
  }

  int getRandomNumber() {
    Random random = new Random();
    return random.nextInt(100); // from 0 upto 99 included
  }

  Widget getProfileImage() {
    if (isImagePicked && _image != null) {
      return Image.file(
        _image,
        fit: BoxFit.cover,
      );
    } else {
      return model.shopeeDetails.profileImage == null
          ? Placeholder()
          : FadeInImage.assetNetwork(
              image:
                  '${model.shopeeDetails.profileImage}?dummy=${getRandomNumber()}',
              placeholder: 'assets/profileplaceholder.jpg',
              fadeInDuration: Duration(seconds: 1),
              fit: BoxFit.cover,
            );
    }
  }

  Future<void> updateProfileInfo() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushNamed(context, NoInternet.routeName);

      return;
    }
    setState(() {
      isLoading = true;
    });

    FormData formData = FormData.fromMap({
      "apiMethod": "profileUpdate",
      "firstName": fNameController.text,
      "lastName": lNameController.text,
      "contactNumber": mobileNoController.text,
      "emailId": emailIdController.text,
      "profileImage": _image == null
          ? null
          : await MultipartFile.fromFile(_image.path, filename: "image.jpg")
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(updateProfile, data: formData);

      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        // print(parsed);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            profileImage, parsed["shoppeInformations"]["profileImage"]);
        print(parsed["shoppeInformations"]["profileImage"]);
        _showSnackBar("Profile Updated Successfully");
        _status = true;
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      _showSnackBar("Network Error");
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  void getProfileDetails() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var rteurned = await Navigator.pushNamed(context, NoInternet.routeName);

      getProfileDetails();
      return;
    }

    setState(() {
      isLoading = true;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();
    dio.interceptors.add(PrettyDioLogger());

    try {
      response = await dio.post(profileInfo, data: {
        "apiMethod": "profileInfo",
        "mobileUniqueCode": mobileUniqueCode
      });

      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        model = ProfileModel.fromJson(parsed);
        qrCodePic = model.shopeeDetails.refQrCode;
        fNameController.text = model.shopeeDetails.shopeeName;
        lNameController.text = model.shopeeDetails.lastName;
        emailIdController.text = model.shopeeDetails.mailId;
        mobileNoController.text = model.shopeeDetails.contactNumber;
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      _showSnackBar("Network Error");
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to Logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                _sharedPrefManager.signOutUser();
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Dashboard.routeName, (Route<dynamic> route) => false);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Future<void> initState() {
    // TODO: implement initState
    getProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
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
          actions: <Widget>[
            InkWell(
              onTap: () {
                _showMyDialog();
              },
              child: Icon(
                FontAwesome.sign_out,
                color: Colors.redAccent,
              ),
            ),
          ],
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
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : new Container(
                color: Colors.white,
                child: new ListView(
                  controller: _controller,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        new Container(
                          color: Colors.white,
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20.0, left: 16.0),
                                child:
                                    new Stack(fit: StackFit.loose, children: <
                                        Widget>[
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 24.0),
                                            child: Container(
                                                width: 100.0,
                                                height: 100.0,
                                                child: ClipOval(
                                                    child: getProfileImage()),
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.blue,
                                                )),
                                          ),
                                          Positioned(
                                            left: 80.0,
                                            top: 60.0,
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    open_gallery();
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    radius: 16.0,
                                                    child: new Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${fNameController.text} ${lNameController.text}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.0),
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            '${mobileNoController.text}',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.0),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            'Refferal Code',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0),
                                          ),
                                          Row(
                                            children: [
                                              SelectableText(
                                                model.shopeeDetails
                                                    .referenceNumber,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14.0,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    Clipboard.setData(
                                                        new ClipboardData(
                                                            text: model
                                                                .shopeeDetails
                                                                .referenceNumber));
                                                    _showSnackBar(
                                                        "Your Referral Code Copied!");
                                                  },
                                                  child: Icon(
                                                      Icons.copy_outlined)),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    FlutterShare.share(
                                                      title: "Refferal",
                                                      text: model.shopeeDetails
                                                          .referenceCodeShareContent,
                                                    );
                                                  },
                                                  child:
                                                      Icon(Icons.share_sharp))
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                    ],
                                  ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Wallet balance",
                                          style:
                                              TextStyle(color: Colors.indigo),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 22.0,
                                              backgroundColor:
                                                  Colors.indigoAccent,
                                              child: Icon(Ionicons.md_wallet),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              "${model.shopeeDetails.walletAmount} ₹",
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
                                    Navigator.pushNamed(context, '/wishlist')
                                        .then((flag) {
                                      if (flag) {
                                        getProfileDetails();
                                      }
                                    });
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "WishLists",
                                            style:
                                                TextStyle(color: Colors.indigo),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 22.0,
                                                backgroundColor:
                                                    Colors.indigoAccent,
                                                child: Icon(Icons.bookmark),
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Text(
                                                model
                                                    .shopeeDetails.wislistCount,
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
                            //  _showSnackBar('Coming soon!');

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
                            //_showSnackBar('Coming soon!');

                            showGeneralDialog(
                                barrierColor: Colors.black
                                    .withOpacity(0.5), //SHADOW EFFECT32
                                transitionBuilder: (context, a1, a2, widget) {
                                  return Center(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          color: Colors.black38,
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {},
                                                child: QrImage(
                                                  data: model
                                                      .shopeeDetails.redeemCode,
                                                  backgroundColor: Colors.white,
                                                  version: QrVersions.auto,
                                                  size: 320.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16.0,
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: Text(
                                                  'Show this QR code to an aFynder Shop and redeem wallet credits against your bill !',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                transitionDuration: Duration(
                                    milliseconds:
                                        200), // DURATION FOR ANIMATION
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      categoriesscreen.Categories(
                                    fromScreen: "profile",
                                  ),
                                ));
                          },
                          child: ListTile(
                            leading: Icon(
                              FontAwesome.filter,
                              color: Colors.indigoAccent,
                            ),
                            title: Text("Category Preference"),
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
                                        Text(
                                          'Personal Information',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        _status ? _getEditIcon() : SizedBox()
                                      ],
                                    )),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      profileTextField(
                                        hint: "First Name",
                                        controller: fNameController,
                                        isMobile: false,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            print("working");
                                            return 'Please enter first name';
                                          } else {
                                            print("not");
                                            fName = value;
                                          }
                                          return null;
                                        },
                                      ),
                                      profileTextField(
                                        hint: "Last Name",
                                        controller: lNameController,
                                        isMobile: false,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter last name';
                                          } else {
                                            lName = value;
                                          }
                                          return null;
                                        },
                                      ),
                                      profileTextField(
                                        hint: "E-Mail",
                                        isMobile: false,
                                        controller: emailIdController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (!RegExp(
                                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                              .hasMatch(value)) {
                                            return 'Please enter valid email';
                                          } else {
                                            email = value;
                                          }
                                          return null;
                                        },
                                      ),
                                      profileTextField(
                                        hint: "Mobile",
                                        isMobile: true,
                                        keyboardType: TextInputType.number,
                                        controller: mobileNoController,
                                        validator: (value) {
                                          if (value.length != 10) {
                                            return 'Please enter valid mobile number';
                                          } else {
                                            mobile = value;
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                !_status
                                    ? _getActionButtons()
                                    : new Container(),
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

  Column profileTextField(
      {String hint,
      TextEditingController controller,
      Function validator,
      bool isMobile,
      TextInputType keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 25.0, top: 25.0),
            child: new Text(
              hint,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
            child: new TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: keyboardType,
              maxLength: isMobile ? 10 : null,
              decoration: InputDecoration(
                prefixIcon: isMobile
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          "+91",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    : null,
                hintText: "",
              ),
              enabled: !_status,
              autofocus: !_status,
            )),
      ],
    );
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
                    if (_formKey.currentState.validate()) {
                      updateProfileInfo();
                    }

                    // _status = true;
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
                  fNameController.text = model.shopeeDetails.shopeeName;
                  lNameController.text = model.shopeeDetails.lastName;
                  emailIdController.text = model.shopeeDetails.mailId;
                  mobileNoController.text = model.shopeeDetails.contactNumber;
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
        _controller.animateTo(
          _controller.position.maxScrollExtent + 100.0,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      },
    );
  }
}
