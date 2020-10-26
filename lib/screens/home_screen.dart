import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/category_model.dart';
import 'package:afynder/response_models/filter_selection.dart';
import 'package:afynder/response_models/homesccreen_model.dart';
import 'package:afynder/screens/productdetails_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  final Function popularCategorySelection;

  const HomeScreen({this.popularCategorySelection});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true, isRecentProductsAvailable = false;
  Response response;
  SharedPrefManager _sharedPrefManager = SharedPrefManager();
  int hotOfferFix = 0;

  List<ChoosenList> choiceList = [];
  List<ProductList> featuredList = [];
  List<ProductList> newAdditionList = [];
  List<ProductList> hotOffers = [];
  List<ProductList> recentProducts = [];
  List<CategoryList> categoryList = [];

  void getProducts() async {
    setState(() {
      isLoading = true;
    });

    print(await _sharedPrefManager.getAuthKey());
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(homeScreen, data: {
        "apiMethod": "featureList",
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        final HomeScreenModel model = HomeScreenModel.fromJson(parsed);
        choiceList = model.choosenList.toList();
        featuredList = model.productList.toList();
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

  void getNewAdditions() async {
    setState(() {
      isLoading = true;
    });

    print(await _sharedPrefManager.getAuthKey());
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(allProducts, data: {
        "apiMethod": "newAdditionProducts",
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        final HomeScreenModel model = HomeScreenModel.fromJson(parsed);
        newAdditionList = model.productList.toList();
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      print("error");
      _showSnackBar("Network Error");
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  void getHotOffers() async {
    setState(() {
      isLoading = true;
    });

    print(await _sharedPrefManager.getAuthKey());
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(allProducts, data: {
        "apiMethod": "hotOffers",
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        final HomeScreenModel model = HomeScreenModel.fromJson(parsed);
        hotOffers = model.productList.toList();
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

  void getRecentProducts() async {
    setState(() {
      isLoading = true;
    });

    print(await _sharedPrefManager.getAuthKey());
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(allProducts, data: {
        "apiMethod": "recentProducts",
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        final HomeScreenModel model = HomeScreenModel.fromJson(parsed);
        recentProducts = model.productList.toList();

        if (recentProducts.length > 0) {
          isRecentProductsAvailable = true;
        } else {
          isRecentProductsAvailable = false;
        }
      } else {
        // _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      //_showSnackBar("Network Error");
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  void getCategories() async {
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    String shopeeId = await _sharedPrefManager.getShopeeId();

    try {
      response = await dio.post(fetchCategories, data: {
        "apiMethod": "CategoryList",
        "shopeeId": shopeeId,
        "callFor": "popularCategory",
        "mobileUniqueCode": "jana1221"
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        final CategoryModel model = CategoryModel.fromJson(parsed);
        categoryList = model.categoryList.toList();
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
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void initState() {
    // getProducts();
    getNewAdditions();
    getHotOffers();
    getRecentProducts();
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView(
                padding: EdgeInsets.only(bottom: 48.0),
                children: <Widget>[
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          "New Additions",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                    height: 210,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: newAdditionList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          print("${newAdditionList.length} new Addition");
                          return NewAdditionItem(
                            imagePath: newAdditionList[index].productImages[0],
                            productName: newAdditionList[index].productName,
                            isOffer: newAdditionList[index].isOffer == "yes",
                            offerPercent: newAdditionList[index].offerAmount,
                            productId: newAdditionList[index].productId,
                            isFeatured:
                                newAdditionList[index].isFeature == "yes",
                          );
                        }),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          "Hot Offers",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                    child: Container(
                      height: 153 * 2.0,
                      child: PageView.builder(
                          controller: PageController(viewportFraction: 0.9),
                          scrollDirection: Axis.horizontal,
                          itemCount: (hotOffers.length / 2).round(),
                          itemBuilder: (BuildContext ctxt, int index) {
                            if (index != 0) {
                              hotOfferFix++;
                            }
                            index = index + hotOfferFix;
                            print((hotOffers.length / 2).round());
                            return Column(
                              children: <Widget>[
                                ((index) < hotOffers.length)
                                    ? HotOffersItem(
                                        productId: hotOffers[index].productId,
                                        imagePath:
                                            hotOffers[index].productImages[0],
                                        productName: hotOffers[index]
                                            .productName
                                            .toLowerCase(),
                                        isOffer:
                                            hotOffers[index].isOffer == "yes",
                                        offerPercent:
                                            hotOffers[index].offerAmount,
                                        actualPrice:
                                            hotOffers[index].actualAmount,
                                        price: hotOffers[index].sellingAmount,
                                        categoryName:
                                            hotOffers[index].shopCategoryName,
                                        isFeatured:
                                            hotOffers[index].isFeature == "yes",
                                        area: hotOffers[index].shopArea,
                                        ratings: hotOffers[index].avgRatings,
                                      )
                                    : SizedBox(),
                                ((index + 1) < hotOffers.length)
                                    ? HotOffersItem(
                                        productId:
                                            hotOffers[index + 1].productId,
                                        imagePath: hotOffers[index + 1]
                                            .productImages[0],
                                        productName:
                                            hotOffers[index + 1].productName,
                                        isOffer: hotOffers[index + 1].isOffer ==
                                            "yes",
                                        offerPercent:
                                            hotOffers[index + 1].offerAmount,
                                        actualPrice:
                                            hotOffers[index + 1].actualAmount,
                                        price:
                                            hotOffers[index + 1].sellingAmount,
                                        categoryName: hotOffers[index + 1]
                                            .shopCategoryName,
                                        isFeatured:
                                            hotOffers[index + 1].isFeature ==
                                                "yes",
                                        area: hotOffers[index + 1].shopArea,
                                        ratings:
                                            hotOffers[index + 1].avgRatings,
                                      )
                                    : SizedBox()
                              ],
                            );
                          }),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          "POPULAR CATEGORIES",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                    height: 150,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            categoryList.isEmpty ? 0 : categoryList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                            onTap: () {
                              FilterSelection filterSelection =
                                  new FilterSelection();

                              filterSelection.apiMethod = "productList";
                              filterSelection.productId = "";
                              filterSelection.searchString = "";
                              filterSelection.priceFrom = "";
                              filterSelection.priceTo = "";
                              filterSelection.mobileUniqueCode =
                                  mobileUniqueCode;

                              filterSelection.sorting = "";
                              filterSelection.categories = [];

                              filterSelection.categories.add(Categories(
                                  categoryName:
                                      categoryList[index].categoryName,
                                  categoryId: categoryList[index].categoryId));

                              widget.popularCategorySelection(
                                jsonEncode(filterSelection.toJson()),
                              );
                            },
                            child: PopularCategoryItem(
                              imagePath: categoryList[index].categoryImage,
                              name: categoryList[index].categoryName,
                              catId: categoryList[index].categoryId,
                            ),
                          );
                        }),
                  ),
                  Visibility(
                    visible: isRecentProductsAvailable,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Text(
                            "RECENT PRODUCTS",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                    height: 210,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            recentProducts.isEmpty ? 0 : recentProducts.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return NewAdditionItem(
                            imagePath: recentProducts[index].productImages[0],
                            productName: recentProducts[index].productName,
                            isOffer: recentProducts[index].isOffer == "yes",
                            offerPercent: recentProducts[index].offerAmount,
                            productId: recentProducts[index].productId,
                            isFeatured:
                                recentProducts[index].isFeature == "yes",
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}

class ChoiceItem extends StatelessWidget {
  final String imagePath,
      categoryName,
      productName,
      price,
      offerPercent,
      productId,
      actualPrice;
  final bool isOffer;

  const ChoiceItem(
      {this.imagePath,
      this.categoryName,
      this.productName,
      this.price,
      this.isOffer,
      this.offerPercent,
      this.actualPrice,
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
                      fit: BoxFit.fitWidth,
                    ),
                    Visibility(
                      visible: isOffer,
                      child: Align(
                          alignment: Alignment.topRight,
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
                          )),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            productName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            categoryName,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        isOffer
                            ? Text(
                                "Rs. $actualPrice",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : SizedBox(),
                        Text(
                          "Rs. $price",
                          style: TextStyle(
                              color: ThemeColors.themeColor5, fontSize: 14.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PopularCategoryItem extends StatelessWidget {
  final String imagePath, name, catId;

  const PopularCategoryItem({this.imagePath, this.name, this.catId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 150.0,
      child: InkWell(
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: <Widget>[
                FadeInImage.memoryNetwork(
                  fadeInDuration: Duration(seconds: 1),
                  image: imagePath,
                  placeholder: kTransparentImage,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    color: Colors.black38,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
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

class HotOffersItem extends StatelessWidget {
  final String imagePath,
      categoryName,
      productName,
      price,
      offerPercent,
      productId,
      actualPrice,
      area,
      ratings;
  final bool isOffer, isFeatured;

  const HotOffersItem(
      {this.imagePath,
      this.categoryName,
      this.productName,
      this.price,
      this.offerPercent,
      this.productId,
      this.actualPrice,
      this.isOffer,
      this.isFeatured,
      this.area,
      this.ratings});

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
          height: 145.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                              Align(
                                alignment: Alignment.topCenter,
                                child: Visibility(
                                  visible: isFeatured,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 0.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0.0, -18.0),
                        child: Visibility(
                          visible: isOffer,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "$offerPercent% OFF",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                    color: Colors.white),
                              ),
                            ),
                            color: ThemeColors.themeOrange,
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                flex: 7,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            productName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          Spacer(),
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
                            area,
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
                                  ratings,
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
                      SizedBox(
                        width: 18.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewAdditionItem extends StatelessWidget {
  final String imagePath, productName, category, offerPercent, productId;
  final bool isOffer, isFeatured;

  const NewAdditionItem(
      {this.imagePath,
      this.productName,
      this.isOffer,
      this.category,
      this.isFeatured,
      this.offerPercent,
      this.productId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
                        width: 150,
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
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          productName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
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
