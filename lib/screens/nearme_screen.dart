import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/all_products_model.dart';
import 'package:afynder/response_models/filter_selection.dart';
import 'package:afynder/screens/filter_screen.dart';
import 'package:afynder/screens/productdetails_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import 'home_screen.dart';

class NearMe extends StatefulWidget {
  final categorySelection;

  const NearMe({this.categorySelection});

  @override
  _NearMeState createState() => _NearMeState();
}

class _NearMeState extends State<NearMe> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true, isFiltered = false, isEmptyState = true;
  String filterParams;
  Response response;
  List<ProductList> productList = [];
  FilterSelection requestModel = FilterSelection();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();

  void getAllProducts() async {
    setState(() {
      isLoading = true;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(allProducts, data: requestModel);
      print(json.encode(requestModel));
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        final AllProducts model = AllProducts.fromJson(parsed);
        productList = model.productList.toList();
        isEmptyState = false;
      } else {
        isEmptyState = true;
        //_showSnackBar(parsed["message"]);
      }
    } catch (e) {
      isEmptyState = true;
      _showSnackBar("Network Error");
      print(e);
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

  List<Widget> getFilteredChips() {
    List<Widget> chips = [];

    for (Categories category in requestModel.categories) {
      print("${chips.length}  for");
      chips.add(filterChipWidget(category.categoryName,
          Icon(AntDesign.filter, size: 16.0, color: Colors.white)));
    }

    if (requestModel.sorting != "") {
      print("${chips.length}  sort");
      chips.add(filterChipWidget(
          requestModel.sorting == "priceAsc"
              ? "Price Low to High"
              : "Price High to Low",
          Icon(
            Entypo.price_tag,
            size: 16.0,
            color: Colors.white,
          )));
    }

    if (requestModel.priceFrom != "") {
      print("${chips.length}  range");
      chips.add(filterChipWidget(
          "Price ${requestModel.priceFrom} - ${requestModel.priceTo}",
          Icon(
            Entypo.price_tag,
            size: 16.0,
            color: Colors.white,
          )));
    }

    if (chips.length > 0) {
      print("${chips.length}  clear");
      chips.insert(
          0,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: InkWell(
              onTap: () {
                requestModel.apiMethod = "productList";
                requestModel.productId = "";
                requestModel.searchString = "";
                requestModel.categories = [];
                requestModel.priceTo = "";
                requestModel.priceFrom = "";
                requestModel.sorting = "";
                isFiltered = false;
                getAllProducts();
              },
              child: Chip(
                backgroundColor: Colors.indigo,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Clear Filters",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Icon(
                      FontAwesome.times_circle,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ));
    }

    print("${chips.length}  csk");

    return chips;
  }

  Widget filterChipWidget(String txt, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: Chip(
        backgroundColor: Colors.indigo,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon,
            SizedBox(
              width: 6.0,
            ),
            Text(
              txt,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // requestModel.apiMethod = "productList";
    // requestModel.productId = "";
    // requestModel.searchString = "";
    // requestModel.categories = [];
    // requestModel.priceTo = "";
    // requestModel.priceFrom = "";
    // requestModel.sorting = "";
    // isFiltered = false;

    requestModel =
        FilterSelection.fromJson(json.decode(widget.categorySelection));
    isFiltered = true;

    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.grey[200],
              child: ListView(
                children: <Widget>[
                  Container(
                    height: getFilteredChips().length == 0 ? 0.0 : 50.0,
                    color: Colors.grey[200],
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: isFiltered ? getFilteredChips() : [SizedBox()],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 12.0),
                        child: Text(
                          "Todays Picks",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.filter_list,
                              color: Colors.blue,
                            ),
                            InkWell(
                              onTap: () async {
                                filterParams = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FilterScreen(
                                        filterSelection: requestModel,
                                      ),
                                    ));

                                setState(() {
                                  requestModel = FilterSelection.fromJson(
                                      json.decode(filterParams));
                                  isFiltered = true;
                                  getAllProducts();
                                });
                              },
                              child: Text(
                                " Filter",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  isEmptyState
                      ? emptyState()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              padding: EdgeInsets.only(bottom: 80.0),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount:
                                  productList.isEmpty ? 0 : productList.length,
                              itemBuilder: (context, index) => AllProductsItem(
                                    imagePath:
                                        productList[index].productImages[0],
                                    productName: productList[index].productName,
                                    isOffer:
                                        productList[index].isOffer == "yes",
                                    isFeatured:
                                        productList[index].isFeature == "yes",
                                    actualPrice:
                                        productList[index].actualAmount,
                                    price: productList[index].sellingAmount,
                                    offerPercent:
                                        productList[index].offerAmount,
                                    categoryName:
                                        productList[index].shopCategoryName,
                                    productId: productList[index].productId,
                                    areaName: productList[index].shopArea,
                                    rating: productList[index].avgRatings,
                                  )),
                        ),
                ],
              ),
            ),
    );
  }
}

class NearbyItem extends StatelessWidget {
  final String imagePath,
      productName,
      price,
      category,
      actualPrice,
      offerPercent,
      productId;
  final bool isOffer, isFeatured;

  const NearbyItem(
      {this.imagePath,
      this.productName,
      this.price,
      this.isOffer,
      this.category,
      this.actualPrice,
      this.isFeatured,
      this.offerPercent,
      this.productId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                productId: productId,
              ),
            ),
          );
        },
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      FadeInImage.memoryNetwork(
                        image: imagePath,
                        placeholder: kTransparentImage,
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.fill,
                      ),
                      Visibility(
                        visible: isFeatured,
                        child: Positioned(
                          top: 2.0,
                          right: 2.0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: ThemeColors.themeOrange,
                                    size: 15.0,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    "Featured",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isOffer,
                        child: Positioned(
                          bottom: 4.0,
                          right: 4.0,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "$offerPercent% OFF",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0),
                              ),
                            ),
                            color: ThemeColors.themeOrange,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              productName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              category,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget emptyState() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/nodata.png',
          height: 400.0,
          width: double.maxFinite,
        ),
        Text("No Products Found",
            style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold,
                fontSize: 24.0)),
        SizedBox(
          height: 8.0,
        ),
        Text("Try Changing Filter Options",
            style: TextStyle(color: Colors.blueGrey[600], fontSize: 16.0)),
      ],
    ),
  );
}

class AllProductsItem extends StatelessWidget {
  final String imagePath,
      categoryName,
      productName,
      price,
      offerPercent,
      productId,
      areaName,
      rating,
      actualPrice;
  final bool isOffer, isFeatured;

  const AllProductsItem(
      {this.imagePath,
      this.categoryName,
      this.productName,
      this.price,
      this.offerPercent,
      this.productId,
      this.actualPrice,
      this.isOffer,
      this.isFeatured,
      this.areaName,
      this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetails(
                  productId: productId,
                ),
              ));
        },
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 110.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    color: Colors.grey,
                                    child: FadeInImage.memoryNetwork(
                                      image: imagePath,
                                      placeholder: kTransparentImage,
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 2.0,
                            left: 2.0,
                            child: Visibility(
                              visible: isFeatured,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 0.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 4.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: ThemeColors.themeOrange,
                                          size: 14.0,
                                        ),
                                        SizedBox(
                                          width: 2.0,
                                        ),
                                        Text(
                                          "Featured",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Visibility(
                              visible: isOffer,
                              child: Container(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "$offerPercent% OFF",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color: Colors.white),
                                    ),
                                  ),
                                  color: ThemeColors.themeOrange,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              productName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          categoryName,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(-2.0, 0),
                              child: Icon(
                                Icons.location_on,
                                color: ThemeColors.themeOrange,
                                size: 16.0,
                              ),
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              areaName,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey[200],
                          endIndent: 18.0,
                          thickness: 1.0,
                        ),
                        Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                isOffer
                                    ? Text(
                                        "Rs $actualPrice",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    : SizedBox(),
                                Text(
                                  "Rs $price",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesome.star,
                                    size: 12.0,
                                    color: Colors.amber[700],
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    rating,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
