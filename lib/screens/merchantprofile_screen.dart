import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/merchant_details.dart';
import 'package:afynder/response_models/merchant_product_list.dart';
import 'package:afynder/screens/nointernet_screen.dart';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nearme_screen.dart';

class MerchantProfile extends StatefulWidget {
  final String merchantId;

  const MerchantProfile({this.merchantId});

  @override
  _MerchantProfileState createState() => _MerchantProfileState();
}

class _MerchantProfileState extends State<MerchantProfile>
    with TickerProviderStateMixin {
  TabController _controller;
  SharedPrefManager _sharedPrefManager = SharedPrefManager();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  Response response;
  final controller = PageController();
  MerchantDetailsModel model = new MerchantDetailsModel();
  MerchantProductsModel productsModel = new MerchantProductsModel();
  List<ProductList> productList = [];
  List<String> bannerImageList = [];
  bool isConnectClicked = false;

  int _selectedIndex = 0;

  void getMerchantsDetails() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var rnm = await Navigator.pushNamed(context, NoInternet.routeName);

      getMerchantsDetails();
      getMerchantsProducts();

      return;
    }
    setState(() {
      isLoading = true;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(merchantLocationList, data: {
        "apiMethod": "merchantDetails",
        "merchantId": widget.merchantId,
        "mobileUniqueCode": mobileUniqueCode
      });

      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        model = MerchantDetailsModel.fromJson(parsed);

        bannerImageList.add(model.merchantInformations.bannerImage1);

        if (model.merchantInformations.bannerImage2.isNotEmpty) {
          bannerImageList.add(model.merchantInformations.bannerImage2);
        }
        if (model.merchantInformations.bannerImage3.isNotEmpty) {
          bannerImageList.add(model.merchantInformations.bannerImage3);
        }
        print(model.toJson());
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      // _showSnackBar("Network Error");
      print('merchant info');
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  void getMerchantsProducts() async {
    setState(() {
      isLoading = true;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(allProducts, data: {
        "apiMethod": "productList",
        "merchantId": widget.merchantId,
        "mobileUniqueCode": mobileUniqueCode
      });

      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        productsModel = MerchantProductsModel.fromJson(parsed);
        productList = productsModel.productList.toList();
        print(model.merchantInformations.rating);
      } else {
        // _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      print('merchant products');
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
    getMerchantsDetails();
    getMerchantsProducts();
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });

    return Scaffold(
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        backgroundColor: Colors.grey[200],
        floatingActionButton: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  curve: Curves.easeInOutQuint,
                  height: isConnectClicked ? 0.0 : 35.0,
                  width: isConnectClicked ? 0.0 : 140.0,
                  duration: Duration(milliseconds: 200),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      setState(() {
                        isConnectClicked = !isConnectClicked;
                      });
                    },
                    color: ThemeColors.themeOrange,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Interested?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      height: isConnectClicked ? 50.0 : 0.0,
                      width: isConnectClicked ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: FloatingActionButton(
                        heroTag: "o",
                        child: isConnectClicked ? Icon(Icons.call) : SizedBox(),
                        onPressed: () {
                          launch(
                              "tel:// ${model.merchantInformations.shopContactNumber}");
                        },
                      ),
                    ),
                    AnimatedContainer(
                      width: isConnectClicked ? 70.0 : 0.0,
                      height: 0.0,
                      duration: Duration(milliseconds: 200),
                    ),
                    AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      height: isConnectClicked ? 50.0 : 0.0,
                      width: isConnectClicked ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: FloatingActionButton(
                        heroTag: "1",
                        backgroundColor: Colors.indigo,
                        child: isConnectClicked ? Icon(Icons.mail) : SizedBox(),
                        onPressed: () {
                          var url =
                              'sms: ${model.merchantInformations.shopContactNumber}?body=Hey I\'m interested in your products / services. Sent from afynder app.';
                          launch(url);
                        },
                      ),
                    ),
                    AnimatedContainer(
                      width: isConnectClicked ? 70.0 : 0.0,
                      height: 0.0,
                      duration: Duration(milliseconds: 200),
                    ),
                    AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      height: isConnectClicked ? 50.0 : 0.0,
                      width: isConnectClicked ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: FloatingActionButton(
                        heroTag: "2",
                        backgroundColor: Colors.green,
                        child: isConnectClicked
                            ? Icon(Icons.directions)
                            : SizedBox(),
                        onPressed: () {
                          launch(
                              "https://www.google.com/maps/dir/?api=1&destination=${model.merchantInformations.lat},${model.merchantInformations.lng}&travelmode=driving");
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 0.0,
                child: Icon(Icons.arrow_back, color: Colors.white),
                backgroundColor: Colors.black38,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: Container(
                          color: Colors.white,
                          child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    height: 250.0,
                                    width: double.infinity,
                                    child: PageView.builder(
                                      physics: BouncingScrollPhysics(),
                                      controller: controller,
                                      onPageChanged: (pos) {
                                        print(pos);
                                      },
                                      itemCount: bannerImageList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Image.network(
                                          bannerImageList[index],
                                          fit: BoxFit.none,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes
                                                    : null,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 36.0,
                                  left: 16.0,
                                  child: SmoothPageIndicator(
                                      controller: controller,
                                      count: bannerImageList.length,
                                      effect: WormEffect(
                                          spacing: 4.0,
                                          radius: 5.0,
                                          dotWidth: 10.0,
                                          activeDotColor: Colors.blue,
                                          dotHeight:
                                              10.0), // your preferred effect
                                      onDotClicked: (index) {}),
                                ),

                                // SizedBox(
                                //   width: double.infinity,
                                //   child: CarouselSlider.builder(
                                //     itemCount: bannerImageList.length,
                                //     itemBuilder:
                                //         (BuildContext context, int itemIndex) =>
                                //             Container(
                                //       width: double.infinity,
                                //       color: Colors.white,
                                //       child: Image.network(
                                //         bannerImageList[itemIndex],
                                //         fit: BoxFit.cover,
                                //       ),
                                //     ),
                                //     options: CarouselOptions(
                                //       height: 200,
                                //       initialPage: 0,
                                //       viewportFraction: 1.0,
                                //       enableInfiniteScroll: true,
                                //       reverse: false,
                                //       autoPlay: true,
                                //       autoPlayInterval: Duration(seconds: 3),
                                //       autoPlayAnimationDuration:
                                //           Duration(milliseconds: 800),
                                //       autoPlayCurve: Curves.fastOutSlowIn,
                                //       enlargeCenterPage: true,
                                //       scrollDirection: Axis.horizontal,
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                  top: 150,
                                  child: Container(
                                      width: 140.0,
                                      height: 140.0,
                                      child: ClipOval(
                                        child: FadeInImage.assetNetwork(
                                          image: model.merchantInformations
                                                  .shopLogo ??
                                              'https://onlinemallfnq.com/wp-content/plugins/yith-woocommerce-multi-vendor-premium/assets/images/shop-placeholder.jpg',
                                          placeholder: 'assets/loader.gif',
                                          fadeInDuration:
                                              Duration(milliseconds: 500),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      )),
                                )
                              ]),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.merchantInformations.shopName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ThemeColors.themeColor5,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    model.merchantInformations.shopCategoryName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        model.merchantInformations
                                                    .ratingCount ==
                                                '0'
                                            ? '-'
                                            : model.merchantInformations.rating,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ThemeColors.themeColor5,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: model.merchantInformations
                                                    .ratingCount ==
                                                '0'
                                            ? Colors.grey
                                            : Colors.yellowAccent,
                                      )
                                    ],
                                  ),
                                  Text(
                                    "${model.merchantInformations.ratingCount} Ratings",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ThemeColors.themeColor5,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.5,
                      ),
                      Card(
                        child: Container(
                          child: TabBar(controller: _controller, tabs: [
                            Tab(
                              child: Text(
                                "Shop Info",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Products",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Container(
                            color: Colors.grey[200],
                            child: _selectedIndex == 0
                                ? info(model)
                                : products(productList, context)),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isConnectClicked,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isConnectClicked = false;
                        });
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  )
                ],
              ));
  }
}

Widget products(List<ProductList> productList, BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: productList.isEmpty
        ? emptyState()
        : GridView.builder(
            padding: EdgeInsets.only(top: 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.8),
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            // crossAxisCount: 2,
            itemCount: productList.isEmpty ? 0 : productList.length,
            itemBuilder: (context, index) => NearbyItem(
                  imagePath: productList[index].productImages[0],
                  productName: productList[index].productName,
                  isOffer: productList[index].isOffer == "yes",
                  isFeatured: productList[index].isFeature == "yes",
                  actualPrice: productList[index].actualAmount,
                  price: productList[index].sellingAmount,
                  offerPercent: productList[index].offerAmount,
                  category: productList[index].shopCategoryName,
                  productId: productList[index].productId,
                  isOfferTypePercent:
                      productList[index].offerType == "percentage",
                )),
  );
}

Widget info(MerchantDetailsModel model) {
  return Column(
    children: <Widget>[
      Visibility(
        visible: model.merchantInformations.description == null ? false : true,
        child: SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.info,
                        color: ThemeColors.themeColor5,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'About Us',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ThemeColors.themeColor5,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      model.merchantInformations.description ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ThemeColors.themeColor5,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: ThemeColors.themeColor5,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Address',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ThemeColors.themeColor5,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    model.merchantInformations.shopFullAddress,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ThemeColors.themeColor5,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: ThemeColors.themeColor5,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Operating Hours',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ThemeColors.themeColor5,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Monday",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Tuesday",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Wednesday",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Thursday",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Friday",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Saturday",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Sunday",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0)
                        ],
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        children: [
                          Text(
                            "${model.merchantInformations.shopTimings.monday.openingTime} - ${model.merchantInformations.shopTimings.monday.closeingTime} ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "${model.merchantInformations.shopTimings.monday.openingTime} - ${model.merchantInformations.shopTimings.monday.closeingTime} ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "${model.merchantInformations.shopTimings.monday.openingTime} - ${model.merchantInformations.shopTimings.monday.closeingTime} ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "${model.merchantInformations.shopTimings.monday.openingTime} - ${model.merchantInformations.shopTimings.monday.closeingTime} ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "${model.merchantInformations.shopTimings.monday.openingTime} - ${model.merchantInformations.shopTimings.monday.closeingTime} ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "${model.merchantInformations.shopTimings.monday.openingTime} - ${model.merchantInformations.shopTimings.monday.closeingTime} ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "${model.merchantInformations.shopTimings.monday.openingTime} - ${model.merchantInformations.shopTimings.monday.closeingTime} ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget emptyState() {
  return Container(
    color: Colors.grey[200],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 48.0,
          ),
          Image.asset(
            'assets/noproductsillus.png',
            height: 200.0,
            width: double.maxFinite,
          ),
          Text("No products available yet!",
              style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          SizedBox(
            height: 8.0,
          ),
          Text("No Products from this seller",
              style: TextStyle(color: Colors.blueGrey[600], fontSize: 14.0)),
        ],
      ),
    ),
  );
}
