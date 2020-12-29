import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/category_model.dart';
import 'package:afynder/response_models/filter_selection.dart';
import 'package:afynder/response_models/productSearchSelection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  var typeSelectedPosition;
  var themeData;
  var dateRangeValue = "";
  double minPrice;
  double maxPrice;
  DateTime fromDate;
  DateTime toDate;
  bool isLoading = true;

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();
  FilterSelection selectedOptions = new FilterSelection();

  List<String> sortingValues = [
    "Price High to Low",
    "Price Low to High",
    "Rating Low to High",
    "Rating High to Low"
  ];

  List<String> typeValues = [
    "Hot Offers",
    "Featured",
    "New Additions",
  ];

  List<CategoryList> categoryList = [];

  List<String> selectedCatIds = [];

  void getOldInstance() {
    FilterSelection oldSelection =
        Provider.of<ProductSearchParams>(context, listen: true).filter;

    if (oldSelection.categories != null && oldSelection.categories.length > 0) {
      for (Categories category in oldSelection.categories) {
        selectedCatIds.add(category.categoryId);
      }
    }

    if (oldSelection.sorting.isNotEmpty) {
      if (oldSelection.sorting == "priceDesc") {
        sortSelectedPosition = 0;
      } else if (oldSelection.sorting == "priceAsc") {
        sortSelectedPosition = 1;
      } else if (oldSelection.sorting == "ratingAsc") {
        sortSelectedPosition = 2;
      } else if (oldSelection.sorting == "ratingDesc") {
        sortSelectedPosition = 3;
      } else {
        sortSelectedPosition = null;
      }
    }

    if (oldSelection.listingType.isNotEmpty) {
      if (oldSelection.listingType == "HotOffers") {
        typeSelectedPosition = 0;
      } else if (oldSelection.listingType == "Featured") {
        typeSelectedPosition = 1;
      } else {
        typeSelectedPosition = 2;
      }
    }

    if (oldSelection.priceFrom.isNotEmpty) {
      values = RangeValues(double.parse(oldSelection.priceFrom),
          double.parse(oldSelection.priceTo));
      labels = RangeLabels(
          "₹  ${oldSelection.priceFrom}", "₹ ${oldSelection.priceTo}");
      startLabel = "₹ ${oldSelection.priceFrom}";
      endLabel = "₹ ${oldSelection.priceTo}";
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
        minPrice = double.parse(model.minMaxList.min);
        maxPrice = double.parse(model.minMaxList.max);
        values = RangeValues(minPrice, maxPrice);
        labels = RangeLabels("₹  ${minPrice.round()}", "₹ ${maxPrice.round()}");
        startLabel = "₹ ${minPrice.round()}";
        endLabel = "₹ ${maxPrice.round()}";

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

  List<Widget> getTypeList() {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < typeValues.length; i++) {
      list.add(typeWidget(i));
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

  Widget typeWidget(int ageIndex) {
    return FilterChip(
      labelStyle: typeSelectedPosition == ageIndex
          ? TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)
          : TextStyle(color: Colors.black87),
      label: Text(typeValues[ageIndex]),
      selected: typeSelectedPosition == ageIndex,
      onSelected: (value) {
        setState(() {
          if (value) {
            typeSelectedPosition = ageIndex;
          } else {
            typeSelectedPosition = null;
          }
        });
      },
    );
  }

  @override
  void initState() {
    //values = RangeValues(minPrice, maxPrice);
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
                            startLabel ?? '0',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            endLabel ?? '0',
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
                        divisions: 100,
                        min: minPrice,
                        max: maxPrice,
                        labels: labels,
                        values: values,
                        onChanged: (value) {
                          setState(() {
                            values = value;
                            labels = RangeLabels(
                                "₹ ${value.start}", "₹ ${value.end}");
                            startLabel = "₹ ${value.start}";
                            endLabel = "₹ ${value.end}";
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
                    Text("Type"),
                    SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      runSpacing: 6.0,
                      spacing: 6.0,
                      children: getTypeList(),
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

                              if (values.start == minPrice &&
                                  values.end == maxPrice) {
                                Provider.of<ProductSearchParams>(context,
                                        listen: true)
                                    .setPriceFrom('');
                                Provider.of<ProductSearchParams>(context,
                                        listen: true)
                                    .setPriceTo('');
                              } else {
                                Provider.of<ProductSearchParams>(context,
                                        listen: true)
                                    .setPriceFrom(
                                        values.start.round().toString());

                                Provider.of<ProductSearchParams>(context,
                                        listen: true)
                                    .setPriceTo(values.end.round().toString());
                              }

                              filterSelection.mobileUniqueCode =
                                  mobileUniqueCode;

                              if (typeSelectedPosition == 0) {
                                Provider.of<ProductSearchParams>(context,
                                        listen: true)
                                    .setListingType('HotOffers');
                              } else if (typeSelectedPosition == 1) {
                                Provider.of<ProductSearchParams>(context,
                                        listen: true)
                                    .setListingType('Featured');
                              } else if (typeSelectedPosition == 2) {
                                Provider.of<ProductSearchParams>(context,
                                        listen: true)
                                    .setListingType('NewEdition');
                              } else {
                                Provider.of<ProductSearchParams>(context,
                                        listen: true)
                                    .setListingType('');
                              }

                              switch (sortSelectedPosition) {
                                case 0:
                                  Provider.of<ProductSearchParams>(context,
                                          listen: true)
                                      .setSorting('priceDesc');
                                  break;
                                case 1:
                                  Provider.of<ProductSearchParams>(context,
                                          listen: true)
                                      .setSorting('priceAsc');
                                  break;
                                case 2:
                                  Provider.of<ProductSearchParams>(context,
                                          listen: true)
                                      .setSorting('ratingAsc');
                                  break;
                                case 3:
                                  Provider.of<ProductSearchParams>(context,
                                          listen: true)
                                      .setSorting('ratingDesc');
                                  break;
                                default:
                                  Provider.of<ProductSearchParams>(context,
                                          listen: true)
                                      .setSorting('');
                                  break;
                              }

                              Provider.of<ProductSearchParams>(context,
                                      listen: true)
                                  .filter
                                  .categories = [];

                              for (CategoryList category in categoryList) {
                                if (selectedCatIds
                                    .contains(category.categoryId)) {
                                  Provider.of<ProductSearchParams>(context,
                                          listen: true)
                                      .addCategories(Categories(
                                          categoryName: category.categoryName,
                                          categoryId: category.categoryId));
                                }
                              }

                              Provider.of<ProductSearchParams>(context,
                                      listen: true)
                                  .changeFilterParams();

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
                                labels = RangeLabels("₹  ${minPrice.round()}",
                                    "₹ ${maxPrice.round()}");
                                startLabel = "₹ ${minPrice.round()}";
                                endLabel = "₹ ${maxPrice.round()}";
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
