import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/filter_selection.dart';
import 'package:afynder/response_models/productSearchSelection.dart';
import 'package:afynder/response_models/search_suggestion.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static var routeName = 'searchscreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();
  bool isLoading = true;
  TextEditingController _searchController = new TextEditingController();
  List<SearchHistory> suggestionList = [];
  Response response;

  void getSuggestions(String searchString) async {
    suggestionList.clear();
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    setState(() {
      isLoading = true;
    });

    try {
      response = await dio.post(searchSuggestion, data: {
        "apiMethod": "searchLog",
        "searchString": searchString,
        "mobileUniqueCode": "mohan23"
      });
      print(searchString);
      print(response);

      final Map<String, dynamic> parsed = json.decode(response.data);

      if (parsed["status"] == "success") {
        final SearchSuggestionModel model =
            SearchSuggestionModel.fromJson(parsed);

        suggestionList = model.searchHistory;

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
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
    // TODO: implement initState
    getSuggestions("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ThemeColors.themeColor5,
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.search,
            autofocus: true,
            onEditingComplete: () {
              FilterSelection filterSelection = new FilterSelection();

              //filterSelection.searchString = _searchController.text;

              Provider.of<ProductSearchParams>(context, listen: true)
                  .setSearchString(_searchController.text);

              Provider.of<ProductSearchParams>(context, listen: true)
                  .changeFilterParams();

              Navigator.pop(context, jsonEncode(filterSelection.toJson()));
            },
            onChanged: (text) {
              if (text.length > 2) {
                getSuggestions(text);
              }
            },
            decoration: InputDecoration(
                fillColor: Color(0xff424242),
                filled: true,
                focusedBorder: InputBorder.none,
                hintText: 'Search aFynder',
                hintStyle: TextStyle(color: Colors.grey)),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return suggestionItem(suggestionList[index], () {
                  Provider.of<ProductSearchParams>(context, listen: true)
                      .setSearchString(suggestionList[index].searchKey);

                  Provider.of<ProductSearchParams>(context, listen: true)
                      .changeFilterParams();

                  Navigator.pop(context, "  ");
                });
              }),
    );
  }

  Column suggestionItem(SearchHistory suggestionList, Function onclick) {
    return Column(
      children: [
        InkWell(
          onTap: onclick,
          child: ListTile(
            leading: Icon(Icons.search),
            title: Text(suggestionList.searchKey),
            trailing: InkWell(
              onTap: () {
                _searchController.text = suggestionList.searchKey;
              },
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(45 / 360),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
