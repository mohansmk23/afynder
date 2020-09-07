import 'package:afynder/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<CategoriesModel> categoriesList = [
    CategoriesModel('assets/cat1.jpg', "Furnitures", false),
    CategoriesModel('assets/cat2.jpeg', "Electronics", false),
    CategoriesModel('assets/cat3.jpeg', "Kitchen", false),
    CategoriesModel('assets/cat4.jpg', "Dresses", false),
    CategoriesModel('assets/cat1.jpg', "Furnitures", false),
    CategoriesModel('assets/cat2.jpeg', "Electronics", false),
  ];

  int selectedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
            'Select Categories',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 24.0,
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            // crossAxisCount: 2,
            itemCount: 6,
            itemBuilder: (context, index) =>CategoryWidget(
                imgUrl: categoriesList[index].imgUrl,
                isSelected: categoriesList[index].isSelected,
                catName: categoriesList[index].catName,
                onTap: () {
                  setState(() {
                    categoriesList[index].isSelected =
                        !categoriesList[index].isSelected;

                    if (categoriesList[index].isSelected)
                      selectedCount++;
                    else
                      selectedCount--;
                  });
                },
              )
          ),
          /*SizedBox(
            height: 16.0,
          ),*/
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
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
    return Expanded(
      child: Container(
        height: 150.0,
        width: 150.0,
        child: InkWell(
          onTap: onTap,
          child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    imgUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    color: Color.fromRGBO(255, 255, 255, 0.19),
                  ),
                  Center(
                    child: Text(
                      catName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white, width: 2.0)),
                        child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: AnimatedOpacity(
                              opacity: isSelected ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 700),
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
      ),
    );
  }
}

class CategoriesModel {
  final String imgUrl;
  final String catName;
  bool isSelected;

  CategoriesModel(this.imgUrl, this.catName, this.isSelected);
}
