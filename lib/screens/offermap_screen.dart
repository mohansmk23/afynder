import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/map_model.dart';
import 'package:afynder/screens/map_marker.dart';
import 'package:afynder/screens/merchantprofile_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Markergenerator.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferMap extends StatefulWidget {
  @override
  _OfferMapState createState() => _OfferMapState();
}

class _OfferMapState extends State<OfferMap> {
  String _mapStyle;
  static const LatLng _center = const LatLng(13.0540, 80.2641);
  List<Marker> customMarkers = new List();
  Completer<GoogleMapController> _controller = Completer();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true, isLocationFetching = true, _isAllOfferSelected = false;
  Response response;
  Position _position;
  List<bool> isSelected = [true, false];

  List<MerchantList> merchantList = [];
  List<LatLng> locations = [];
  List<Widget> mapMarkers = [];

  void getMerchantsList() async {
    print("called");
    setState(() {
      isLoading = true;
    });

    // dio.interceptors.add(PrettyDioLogger());

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(merchantLocationList, data: {
        "apiMethod": "merchantsList",
        "offerStatus": _isAllOfferSelected ? "" : "withOffer",
        "mobileUniqueCode": mobileUniqueCode
      });
      final Map<String, dynamic> parsed = json.decode(response.data);
      mapMarkers.clear();
      locations.clear();
      customMarkers.clear();
      merchantList.clear();
      if (parsed["status"] == "success") {
        final MapModel model = MapModel.fromJson(parsed);
        merchantList = model.merchantList.toList();
        print('${merchantList.length} mapmarker');
        for (MerchantList merchant in merchantList) {
          print('${merchant.shopName} mapmarker');

          locations.add(LatLng(
              merchant.lng.isNotEmpty ? double.parse(merchant.lat) : 47.1164,
              merchant.lat.isNotEmpty ? double.parse(merchant.lng) : 101.2996));

          mapMarkers.add(MapMarker(merchant.offerAmt, merchant.shopName));
        }

        MarkerGenerator(mapMarkers, (bitmaps) {
          customMarkers = mapBitmapsToMarkers(bitmaps);

          setState(() {});
        }).generate(context);
      } else {
        MarkerGenerator(mapMarkers, (bitmaps) {
          customMarkers = mapBitmapsToMarkers(bitmaps);

          setState(() {});
        }).generate(context);
        if (!_isAllOfferSelected) {
          showAlertDialog(context);
          isSelected = [false, true];
          _isAllOfferSelected = true;
          getMerchantsList();
        }
      }
    } catch (e) {
      //  _showSnackBar("Network Error");
      print("cskay");
    }

    setState(() {
      isLoading = false;
    });
  }

  void _showSnackBar(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void getCurrentLocation() async {
    setState(() {
      isLocationFetching = true;
    });
    _position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      isLocationFetching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    getMerchantsList();
    getCurrentLocation();
  }

  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    List<Marker> markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      markersList.add(Marker(
          markerId: MarkerId("MANO fURNITURES $i"),
          position: locations[i],
          icon: BitmapDescriptor.fromBytes(bmp),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  MerchantList merchant = merchantList[i];
                  print('${merchant.shopName} bottomsheet');
                  return bottomSheet(
                      context,
                      merchant.merchantId,
                      merchant.shopName ?? "",
                      merchant.shopCategoryName ?? "",
                      merchant.ratingCount,
                      double.tryParse(merchant.rating) == null
                          ? 0.0
                          : double.parse(merchant.rating),
                      merchant.offerAmt,
                      "",
                      merchant.offerUntil ?? "",
                      merchant.shopAddress ?? "",
                      double.tryParse(merchant.lat) == null
                          ? 0.0
                          : double.parse(merchant.lat),
                      double.tryParse(merchant.lng) == null
                          ? 0.0
                          : double.parse(merchant.lng),
                      merchant.shopContactNumber ?? "",
                      merchant.isOffer == "yes");
                });
          }));
    });
    return markersList;
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_mapStyle);
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: isLocationFetching
                        ? LatLng(11.0168, 76.9558)
                        : LatLng(_position.latitude, _position.longitude) ??
                            LatLng(11.0168, 76.9558),
                    zoom: 10.0,
                  ),
                  markers: customMarkers.toSet(),
                ),
                Positioned(
                  top: 10.0,
                  left: 16.0,
                  child: Card(
                    child: ToggleButtons(
                      borderColor: Colors.black,
                      fillColor: Colors.blue,
                      borderWidth: 0,
                      selectedBorderColor: Colors.black,
                      isSelected: isSelected,
                      selectedColor: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            MaterialIcons.local_offer,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.store,
                          ),
                        ),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == index;

                            if (index == 0) {
                              _isAllOfferSelected = false;
                            } else {
                              _isAllOfferSelected = true;
                            }

                            getMerchantsList();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Widget bottomSheet(
    BuildContext context,
    String merchantId,
    String merchantName,
    String merchantCategory,
    String ratingCount,
    double rating,
    String offerAmount,
    String offerDescription,
    String offerUntil,
    String address,
    double lat,
    double lng,
    String phone,
    bool isOffer) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 12.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Icon(Icons.close),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MerchantProfile(
                                merchantId: merchantId,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          merchantName,
                          style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 24.0,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  merchantCategory,
                  style: TextStyle(
                    color: ThemeColors.themeColor5,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    Text(
                      "$ratingCount Ratings",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MerchantProfile(
                              merchantId: merchantId,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "View Products",
                        style: TextStyle(
                          color: ThemeColors.themeColor5,
                          fontSize: 16.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.0,
                ),
              ],
            ),
            Divider(
              height: 28.0,
              thickness: 1.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  isOffer ? "$offerAmount% OFF" : "No Offers Now",
                  style: TextStyle(
                      color: isOffer ? Colors.green : Colors.redAccent,
                      fontSize: 16.0),
                ),
                Spacer(),
                isOffer
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Until",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                          Text(
                            offerUntil,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                        ],
                      )
                    : SizedBox()
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              isOffer ? offerDescription : "Keep on track to grab offer",
              style: TextStyle(
                color: ThemeColors.themeColor5,
                fontSize: 14.0,
              ),
            ),
            Divider(
              height: 28.0,
              thickness: 1.0,
            ),
            Text(
              address,
              style: TextStyle(
                color: ThemeColors.themeColor5,
                fontSize: 18.0,
              ),
            ),
            Divider(
              height: 28.0,
              thickness: 1.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    launch(
                        "https://www.google.com/maps/dir/?api=1&destination=$lng,$lng&travelmode=driving");
                  },
                  child: CircleAvatar(
                    radius: 24.0,
                    child: Icon(Icons.directions),
                  ),
                ),
                SizedBox(
                  width: 24.0,
                ),
                InkWell(
                  onTap: () {
                    launch("tel://$phone");
                  },
                  child: CircleAvatar(
                    radius: 24.0,
                    child: Icon(Icons.call),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog

  AlertDialog alert = AlertDialog(
    title: Text("Currently No Offers!"),
    content: Text(
        "Sorry! No offers currently running in any store, stay connected and check back later for new offers."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
