import 'package:afynder/constants/colors.dart';
import 'package:flutter/material.dart';

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
  var locationSelectedPosition;
  var categorySelectedPosition;
  var sortSelectedPosition;
  var isAgeChanged = false;
  var isPriceChanged = false;
  var isLocationChanged = false;
  var isCategoryChanged = false;
  var themeData;
  var dateRangeValue = "";
  var minPrice = 0.0;
  var maxPrice = 1000.0;
  DateTime fromDate;
  DateTime toDate;

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  Map<String, String> _eventName = {};

  List<String> locationValues = [
    "All",
    "< 5 Kms",
    "5 to 10 Kms",
    "10 to 20Kms",
    "20+ Kms"
  ];

  List<String> sortingValues = [
    "Price High to low",
    "Price low to high",
    "Nearby first",
    "Farther first",
  ];

  List<String> categoryValues = [
    "All",
    "Furnitures",
    "Electronics",
    "Electricals",
    "Kitchen",
    "Decoratives",
    "Tools",
    "Interiors"
  ];

  Widget locationWidget(String location) {
    return FilterChip(
      labelStyle: TextStyle(
          color: locationSelectedPosition == locationValues.indexOf(location)
              ? ThemeColors.themeOrange
              : Colors.black87),
      label: Text(location),
      selected: locationSelectedPosition == locationValues.indexOf(location),
      onSelected: (value) {
        setState(() {
          if (value) {
            isLocationChanged = true;
            locationSelectedPosition = locationValues.indexOf(location);
          }
        });
      },
    );
  }

  List<Widget> getCategoriesList() {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < categoryValues.length; i++) {
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

  Widget categoryWidget(int ageIndex) {
    return FilterChip(
      labelStyle: TextStyle(
          color: categorySelectedPosition == ageIndex
              ? ThemeColors.themeOrange
              : Colors.black87),
      label: Text(categoryValues[ageIndex]),
      selected: categorySelectedPosition == ageIndex,
      onSelected: (value) {
        setState(() {
          if (value) {
            isAgeChanged = true;
            categorySelectedPosition = ageIndex;
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
            isCategoryChanged = true;
            sortSelectedPosition = ageIndex;
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
    locationSelectedPosition = 0;
    categorySelectedPosition = 0;
    super.initState();
  }

  void showSnackBar(String content) {
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
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Text("Location"),
              SizedBox(
                height: 5,
              ),
              Wrap(runSpacing: 6.0, spacing: 6.0, children: <Widget>[
                for (String location in locationValues) locationWidget(location)
              ]),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
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
                        Navigator.pop(context);
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
                      onPressed: () {},
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
