import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'all_products_model.dart';
import 'filter_selection.dart';

class ProductSearchParams extends ChangeNotifier {
  List<ProductList> productList = [];
  SharedPrefManager _sharedPrefManager = SharedPrefManager();
  FilterSelection filter = new FilterSelection(
      apiMethod: "productList",
      productId: "",
      searchString: "",
      categories: [],
      listingType: "",
      sorting: "",
      priceFrom: "",
      priceTo: "",
      mobileUniqueCode: "");
  bool isLoading = false, isFiltered = false, isEmptyState = true;

  Future<void> changeFilterParams() async {
    isLoading = true;

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      Response response = await dio.post(allProducts, data: filter.toJson());

      print('${filter.toJson()} kushi');

      final Map<String, dynamic> parsed = json.decode(response.data);
      print(parsed);
      if (parsed["status"] == "success") {
        final AllProducts model = AllProducts.fromJson(parsed);
        productList = model.productList.toList();
        isEmptyState = false;
      } else {
        isEmptyState = true;
        //_showSnackBar(parsed["message"]);
      }
    } catch (e) {
      isEmptyState = true;

      print(e);
    }

    isLoading = false;

    notifyListeners();
  }

  void setSearchString(String value) {
    filter.searchString = value;
    notifyListeners();
  }

  void addCategories(Categories categories) {
    filter.categories.add(categories);
    notifyListeners();
  }

  void setListingType(String listingType) {
    filter.listingType = listingType;
    notifyListeners();
  }

  void setSorting(String sortingType) {
    filter.sorting = sortingType;
    notifyListeners();
  }

  void setPriceFrom(String frmPrice) {
    filter.priceFrom = frmPrice;
    notifyListeners();
  }

  void setPriceTo(String priceTo) {
    filter.priceTo = priceTo;
    notifyListeners();
  }

  void clearFilters() {
    filter = new FilterSelection(
        apiMethod: "productList",
        productId: "",
        searchString: '',
        categories: [],
        listingType: "",
        sorting: "",
        priceFrom: "",
        priceTo: "",
        mobileUniqueCode: "");
    notifyListeners();
  }

  bool isFiltersEmpty() {
    return (filter.categories.length != 0 &&
        filter.listingType != '' &&
        filter.sorting != '' &&
        filter.priceFrom != '' &&
        filter.priceTo != '');
  }
}
