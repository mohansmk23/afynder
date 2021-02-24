import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/category_model.dart';
import 'package:afynder/response_models/filter_selection.dart';
import 'package:afynder/response_models/productSearchSelection.dart';
import 'package:afynder/screens/nointernet_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategories extends StatefulWidget {
  static var routeName = 'allcategories';

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  Response response;
  int selectedCount = 0;
  SharedPrefManager _sharedPrefManager = SharedPrefManager();

  List<CategoryList> categoryList = [];

  void getCategories() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var rnm = await Navigator.pushNamed(context, NoInternet.routeName);

      getCategories();

      return;
    }
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    String shopeeId = await _sharedPrefManager.getShopeeId();

    try {
      response = await dio.post(fetchCategories, data: {
        "apiMethod": "CategoryList",
        "shopeeId": shopeeId,
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
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: ListView(children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Product Categories',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    GridView.builder(
                        padding: EdgeInsets.only(bottom: 54.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        // crossAxisCount: 2,
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) => CategoryWidget(
                              imgUrl: categoryList[index].categoryImage,
                              isSelected:
                                  categoryList[index].isSelected == "yes",
                              catName: categoryList[index].categoryName,
                              onTap: () {
                                FilterSelection filterSelection =
                                    new FilterSelection();

                                Provider.of<ProductSearchParams>(
                                        context,
                                        listen: true)
                                    .addCategories(Categories(
                                        categoryName:
                                            categoryList[index].categoryName,
                                        categoryId:
                                            categoryList[index].categoryId));

                                Provider.of<ProductSearchParams>(context,
                                        listen: true)
                                    .changeFilterParams("1");

                                Navigator.pop(context,
                                    jsonEncode(filterSelection.toJson()));
                              },
                            )),
                    /*SizedBox(
            height: 16.0,
          ),*/

                    SizedBox(
                      height: 8.0,
                    ),
                  ]),
                ),
              ));
  }
}

class CategoryWidget extends StatelessWidget {
  final String imgUrl;
  final String catName;
  final bool isSelected;
  final Function onTap;

  const CategoryWidget(
      {this.imgUrl, this.catName, this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 150.0,
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: <Widget>[
                FadeInImage.assetNetwork(
                  fadeInDuration: Duration(seconds: 1),
                  image: imgUrl,
                  placeholder: 'assets/loader.gif',
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
                      catName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
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
