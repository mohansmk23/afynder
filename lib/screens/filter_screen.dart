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
  final FilterSelection filterSelection;

  const FilterScreen({this.filterSelection});

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
  bool isLoading = true;

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();
  FilterSelection selectedOptions = new FilterSelection();

  List<String> sortingValues = [
    "Price High to low",
    "Price low to high",
  ];

  List<CategoryList> categoryList = [];

  List<String> selectedCatIds = [];

  void getOldInstance() {
    if (widget.filterSelection.categories != null &&
        widget.filterSelection.categories.length > 0) {
      for (Categories category in widget.filterSelection.categories) {
        selectedCatIds.add(category.categoryId);
      }
    }

    if (widget.filterSelection.sorting.isNotEmpty) {
      if (widget.filterSelection.sorting == "priceAsc") {
        sortSelectedPosition = 1;
      } else {
        sortSelectedPosition = 0;
      }
    }

    if (widget.filterSelection.priceFrom.isNotEmpty) {
      values = RangeValues(double.parse(widget.filterSelection.priceFrom),
          double.parse(widget.filterSelection.priceTo));
      labels = RangeLabels("Rs  ${widget.filterSelection.priceFrom}",
          "Rs ${widget.filterSelection.priceTo}");
      startLabel = "Rs ${widget.filterSelection.priceFrom}";
      endLabel = "Rs ${widget.filterSelection.priceTo}";
    } else {}
  }

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
        getOldInstance();
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
      labelStyle: selectedCatIds.contains(categoryList[catIndex].categoryId)
          ? TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)
          : TextStyle(color: Colors.black87),
      label: Text(categoryList[catIndex].categoryName),
      selected: selectedCatIds.contains(categoryList[catIndex].categoryId),
      onSelected: (value) {
        setState(() {
          if (value) {
            selectedCatIds.add(categoryList[catIndex].categoryId);
          } else {
            selectedCatIds.removeAt(
                selectedCatIds.indexOf(categoryList[catIndex].categoryId));
          }
        });
      },
    );
  }

  Widget sortWidget(int ageIndex) {
    return FilterChip(
      labelStyle: sortSelectedPosition == ageIndex
          ? TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)
          : TextStyle(color: Colors.black87),
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
    //values = RangeValues(minPrice, maxPrice);
    getCategories();
    values = RangeValues(minPrice, maxPrice);
    labels = RangeLabels("Rs  ${minPrice.round()}", "Rs ${maxPrice.round()}");
    startLabel = "Rs ${minPrice.round()}";
    endLabel = "Rs ${maxPrice.round()}";
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
      key: scaffoldState,
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                            labels = RangeLabels(
                                "Rs ${value.start}", "Rs ${value.end}");
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              FilterSelection filterSelection =
                                  new FilterSelection();

                              filterSelection.apiMethod = "productList";
                              filterSelection.productId = "";
                              filterSelection.searchString = "";

                              print(values.start);
                              print(values.end);

                              if (values.start == 100.0 &&
                                  values.end == 100000.0) {
                                filterSelection.priceFrom = "";
                                filterSelection.priceTo = "";
                              } else {
                                filterSelection.priceFrom =
                                    values.start.round().toString();
                                filterSelection.priceTo =
                                    values.end.round().toString();
                              }

                              filterSelection.mobileUniqueCode =
                                  mobileUniqueCode;

                              filterSelection.sorting =
                                  sortSelectedPosition == 1
                                      ? "priceAsc"
                                      : sortSelectedPosition == 0
                                          ? "priceDesc"
                                          : "";
                              filterSelection.categories = [];

                              for (CategoryList category in categoryList) {
                                if (selectedCatIds
                                    .contains(category.categoryId)) {
                                  filterSelection.categories.add(Categories(
                                      categoryName: category.categoryName,
                                      categoryId: category.categoryId));
                                }
                              }

                              Navigator.pop(context,
                                  jsonEncode(filterSelection.toJson()));
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
                                selectedCatIds.clear();
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
