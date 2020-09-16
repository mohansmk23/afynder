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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
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
  bool isLoading = true;
  Response response;

  List<MerchantList> merchantList = [];
  List<LatLng> locations = [];
  List<Widget> mapMarkers = [];

  void getMerchantsList() async {
    setState(() {
      isLoading = true;
    });
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();
    ;

    try {
      response = await dio.post(merchantLocationList, data: {
        "apiMethod": "merchantsList",
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        final MapModel model = MapModel.fromJson(parsed);
        merchantList = model.merchantList.toList();

        for (MerchantList merchant in merchantList) {
          if (merchant.lng.isNotEmpty && merchant.lat.isNotEmpty) {
            locations.add(
                LatLng(double.parse(merchant.lat), double.parse(merchant.lng)));
            mapMarkers.add(MapMarker(merchant.offerAmt));

            print(merchant.offerAmt);
          }
        }
        MarkerGenerator(mapMarkers, (bitmaps) {
          customMarkers = mapBitmapsToMarkers(bitmaps);

          print(customMarkers.length);

          setState(() {});
        }).generate(context);
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

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    getMerchantsList();
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
                  return bottomSheet(
                      context,
                      merchant.merchantId,
                      merchant.firstName,
                      merchant.shopCategoryName,
                      "754",
                      2.5,
                      merchant.offerAmt,
                      "all products offer lorem ",
                      "23 september 2020",
                      merchant.shopAddress,
                      double.parse(merchant.lat),
                      double.parse(merchant.lng),
                      merchant.shopContactNumber,
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
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 16.0,
            ),
            markers: customMarkers.toSet(),
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
    bool isOFfer) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                        merchantName,
                        style: TextStyle(
                            color: ThemeColors.themeColor5,
                            fontSize: 24.0,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
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
                  isOFfer ? "$offerAmount% OFF" : "No Offers Now",
                  style: TextStyle(
                      color: isOFfer ? Colors.green : Colors.redAccent,
                      fontSize: 16.0),
                ),
                Spacer(),
                isOFfer
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
              isOFfer ? offerDescription : "Keep on track to grab offer",
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
