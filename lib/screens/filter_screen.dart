import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/category_model.dart';
import 'package:afynder/response_models/filter_selection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = "/filters";

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues values;
  var labels;
  var startLabel;
  var endLabel;
  var sortSelectedPosition;
  var themeData;
  var dateRangeValue = "";
  var minPrice = 100.0;
  var maxPrice = 100000.0;
  DateTime fromDate;
  DateTime toDate;
  bool isLoading;

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();

  List<String> sortingValues = [
    "Price High to low",
    "Price low to high",
  ];

  List<CategoryList> categoryList = [];

  List<int> selectedCatIndexes = [];

  void getCategories() async {
    setState(() {
      isLoading = false;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      var response = await dio.post(fetchCategories, data: {
        "apiMethod": "CategoryList",
        "mobileUniqueCode": mobileUniqueCode
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

  List<Widget> getCategoriesList() {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < categoryList.length; i++) {
      list.add(categoryWidget(i));
    }
    return list;
  }

  List<Widget> getSortingList() {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < sortingValues.length; i++) {
      list.add(sortWidget(i));
    }
    return list;
  }

  Widget categoryWidget(int catIndex) {
    return FilterChip(
      labelStyle: TextStyle(
          color: selectedCatIndexes.contains(catIndex)
              ? ThemeColors.themeOrange
              : Colors.black87),
      label: Text(categoryList[catIndex].categoryName),
      selected: selectedCatIndexes.contains(catIndex),
      onSelected: (value) {
        setState(() {
          if (value) {
            selectedCatIndexes.add(catIndex);
          } else {
            selectedCatIndexes.removeAt(selectedCatIndexes.indexOf(catIndex));
          }
        });
      },
    );
  }

  Widget sortWidget(int ageIndex) {
    return FilterChip(
      labelStyle: TextStyle(
          color: sortSelectedPosition == ageIndex
              ? ThemeColors.themeOrange
              : Colors.black87),
      label: Text(sortingValues[ageIndex]),
      selected: sortSelectedPosition == ageIndex,
      onSelected: (value) {
        setState(() {
          if (value) {
            sortSelectedPosition = ageIndex;
          } else {
            sortSelectedPosition = null;
          }
        });
      },
    );
  }

  @override
  void initState() {
    values = RangeValues(minPrice, maxPrice);
    labels = RangeLabels("Rs  ${minPrice.round()}", "Rs ${maxPrice.round()}");
    startLabel = "Rs ${minPrice.round()}";
    endLabel = "Rs ${maxPrice.round()}";
    getCategories();
    super.initState();
  }

  void _showSnackBar(String content) {
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: 1500),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    themeData = Theme.of(context);
    return Scaffold(
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
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Filters",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromRGBO(12, 63, 102, 1)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                "Price Range",
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      startLabel,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      endLabel,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(trackHeight: 2),
                child: RangeSlider(
                  activeColor: ThemeColors.themeOrange,
                  inactiveColor: Colors.grey,
                  divisions: 10,
                  min: minPrice,
                  max: maxPrice,
                  labels: labels,
                  values: values,
                  onChanged: (value) {
                    setState(() {
                      values = value;
                      labels =
                          RangeLabels("Rs ${value.start}", "Rs ${value.end}");
                      startLabel = "Rs ${value.start}";
                      endLabel = "Rs ${value.end}";
                    });
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Text("Categories"),
              SizedBox(
                height: 5,
              ),
              Wrap(
                runSpacing: 6.0,
                spacing: 6.0,
                children: getCategoriesList(),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Text("Sort By"),
              SizedBox(
                height: 5,
              ),
              Wrap(
                runSpacing: 6.0,
                spacing: 6.0,
                children: getSortingList(),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        "Apply",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        FilterSelection filterSelection = new FilterSelection();

                        filterSelection.apiMethod = "productList";
                        filterSelection.productId = "";
                        filterSelection.searchString = "";
                        filterSelection.priceFrom =
                            values.start.round().toString();
                        filterSelection.priceTo = values.end.round().toString();
                        filterSelection.mobileUniqueCode = mobileUniqueCode;

                        filterSelection.sorting = sortSelectedPosition == 1
                            ? "priceAsc"
                            : sortSelectedPosition == 0 ? "priceDesc" : "";
                        filterSelection.categories = [];

                        for (int selectedIndex in selectedCatIndexes) {
                          filterSelection.categories.add(Categories(
                              categoryId:
                                  categoryList[selectedIndex].categoryId,
                              categoryName:
                                  categoryList[selectedIndex].categoryName));
                        }

                        Navigator.pop(
                            context, jsonEncode(filterSelection.toJson()));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: ThemeColors.themeOrange),
                      ),
                      color: ThemeColors.themeOrange,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    RaisedButton(
                      child: Text(
                        "Clear",
                        style: TextStyle(
                            color: ThemeColors.themeOrange,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedCatIndexes.clear();
                          sortSelectedPosition = null;
                          values = RangeValues(minPrice, maxPrice);
                          labels = RangeLabels("Rs  ${minPrice.round()}",
                              "Rs ${maxPrice.round()}");
                          startLabel = "Rs ${minPrice.round()}";
                          endLabel = "Rs ${maxPrice.round()}";
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: ThemeColors.themeOrange),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
