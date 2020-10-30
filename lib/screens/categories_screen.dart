import 'dart:convert';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/category_model.dart';
import 'package:afynder/response_models/category_selection.dart';
import 'package:afynder/screens/dashboard_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:afynder/constants/api_urls.dart';

class Categories extends StatefulWidget {
  static const routeName = "/categories";

  final String fromScreen;

  const Categories({this.fromScreen});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  Response response;
  int selectedCount = 0;
  SharedPrefManager _sharedPrefManager = SharedPrefManager();

  List<CategoryList> categoryList = [];

  void getCategories() async {
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
        selectedCount = getNoOfSelected(categoryList);
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

  void postCategories(CategorySelectionModel model) async {
    setState(() {
      isLoading = true;
    });
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      print(json.encode(model));
      response = await dio.post(categorySelection, data: json.encode(model));
      print(response);

      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        if (widget.fromScreen == "profile") {
          Navigator.pop(context);
        } else {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Dashboard.routeName, (Route<dynamic> route) => false);
          });
        }
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.maxFinite,
            child: RaisedButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/dashboard');

                if (selectedCount != 0) {
                  final CategorySelectionModel selectionParams =
                      new CategorySelectionModel();
                  List<SelectedCategories> categorySelection = [];
                  for (CategoryList category in categoryList) {
                    categorySelection.add(SelectedCategories(
                        categoryId: category.categoryId,
                        isSelected: category.isSelected));
                  }
                  selectionParams.apiMethod = 'CategorySelection';
                  selectionParams.mobileUniqueCode = mobileUniqueCode;
                  selectionParams.categories = categorySelection;

                  postCategories(selectionParams);
                } else {
                  _showSnackBar("Please Select Atleast one Category");
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: ThemeColors.themeOrange,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Select $selectedCount categories",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                      'Category Preference',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      'Please select the product categories that interests you',
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
                                setState(() {
                                  categoryList[index].isSelected =
                                      categoryList[index].isSelected == "yes"
                                          ? "no"
                                          : "yes";

                                  if (categoryList[index].isSelected == "yes")
                                    selectedCount++;
                                  else
                                    selectedCount--;
                                });
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
                FadeInImage.memoryNetwork(
                  fadeInDuration: Duration(seconds: 1),
                  image: imgUrl,
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
                      catName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.0)),
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: AnimatedOpacity(
                            opacity: isSelected ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 500),
                            child: CircleAvatar(
                              radius: 12.0,
                              backgroundColor: ThemeColors.themeOrange,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

int getNoOfSelected(List<CategoryList> list) {
  int count = 0;

  for (var category in list) {
    if (category.isSelected == "yes") count++;
  }

  return count;
}
