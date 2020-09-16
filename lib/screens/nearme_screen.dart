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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import 'home_screen.dart';

class NearMe extends StatefulWidget {
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
        _showSnackBar(parsed["message"]);
      } else {
        isEmptyState = true;
        _showSnackBar(parsed["message"]);
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
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  List<Widget> getFilteredChips() {
    List<Widget> chips = [];

    for (Categories category in requestModel.categories) {
      chips.add(filterChipWidget(category.categoryName));
    }

    if (requestModel.sorting.isNotEmpty) {
      chips.add(filterChipWidget(requestModel.sorting == "priceAsc"
          ? "Price Low to High"
          : "Price High to Low"));
    }

    chips.add(filterChipWidget(
        "Price ${requestModel.priceFrom} - ${requestModel.priceTo}"));

    return chips;
  }

  Widget filterChipWidget(String txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: Chip(
        label: Text(txt),
      ),
    );
  }

  @override
  void initState() {
    requestModel.apiMethod = "productList";
    requestModel.productId = "";
    requestModel.searchString = "";
    requestModel.categories = [];
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
                    color: Colors.grey[200],
                    child: Wrap(
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
                                      builder: (context) => FilterScreen(),
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
                      : ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 36.0),
                          children: <Widget>[
                            SizedBox(
                              height: 12.0,
                            ),
                            GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                ),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                // crossAxisCount: 2,
                                itemCount: productList.isEmpty
                                    ? 0
                                    : productList.length,
                                itemBuilder: (context, index) => NearbyItem(
                                      imagePath:
                                          productList[index].productImages[0],
                                      productName:
                                          productList[index].productName,
                                      isOffer:
                                          productList[index].isOffer == "yes",
                                      isFeatured:
                                          productList[index].isFeature == "yes",
                                      actualPrice:
                                          productList[index].actualAmount,
                                      price: productList[index].sellingAmount,
                                      offerPercent:
                                          productList[index].offerAmount,
                                      category:
                                          productList[index].shopCategoryName,
                                      productId: productList[index].productId,
                                    )),
                          ],
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
                        height: 150,
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
                                    color: Colors.white),
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
                          children: <Widget>[
                            Text(
                              category,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              productName,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            isOffer
                                ? Text(
                                    "Rs.$actualPrice",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                : SizedBox(),
                            Text(
                              "Rs.$price",
                              style: TextStyle(
                                color: Colors.black,
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
      children: <Widget>[
        Image.asset('assets/nodata.png'),
        Text("No Products Found",
            style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold,
                fontSize: 18.0)),
        SizedBox(
          height: 8.0,
        ),
        Text("Try changing filter optons",
            style: TextStyle(
                color: Colors.blueGrey[600],
                fontWeight: FontWeight.bold,
                fontSize: 12.0)),
      ],
    ),
  );
}
