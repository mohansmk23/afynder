import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/screens/map_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../Markergenerator.dart';

class OfferMap extends StatefulWidget {
  @override
  _OfferMapState createState() => _OfferMapState();
}

class _OfferMapState extends State<OfferMap> {
  String _mapStyle;

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> customMarkers = new List();

  List<LatLng> locations = [
    LatLng(13.0540, 80.2641),
    LatLng(13.0585, 80.2642),
    LatLng(13.0585, 80.2682),
    LatLng(13.0486, 80.2430),
    LatLng(13.0488, 80.2474),
    LatLng(13.0483, 80.2412),
    LatLng(13.0476, 80.2443),
  ];

  List<Widget> mapMarkers = [
    MapMarker("20% OFF"),
    MapMarker("10% OFF"),
    MapMarker("50% OFF"),
    MapMarker("70% OFF"),
    MapMarker("60% OFF"),
    MapMarker("10% OFF"),
    MapMarker("30% OFF"),
  ];

  static const LatLng _center = const LatLng(13.0540, 80.2641);

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    super.initState();
    MarkerGenerator(mapMarkers, (bitmaps) {
      customMarkers = mapBitmapsToMarkers(bitmaps);

      print(customMarkers.length);

      setState(() {});
    }).generate(context);
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
                context: context, builder: (context) => bottomSheet(context));
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
    return Stack(
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
    );
  }
}

Widget bottomSheet(BuildContext context) {
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
                        Navigator.pushNamed(context, '/merchantdetails');
                      },
                      child: Text(
                        "Manoj Furnitures",
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
                        Navigator.pushNamed(context, '/merchantdetails');
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
                  "Furnitures",
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
                      rating: 3.35,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    Text(
                      "587 Ratings",
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
                  "20% OFF",
                  style: TextStyle(color: Colors.green, fontSize: 16.0),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Until",
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    Text(
                      "7 September 2020",
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "20% off on purchases over 2000 Rs.",
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
              "No.4 Third floor,peters rd, Royapettah , Chennai - 600057",
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
                CircleAvatar(
                  radius: 24.0,
                  child: Icon(Icons.directions),
                ),
                SizedBox(
                  width: 24.0,
                ),
                CircleAvatar(
                  radius: 24.0,
                  child: Icon(Icons.call),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
