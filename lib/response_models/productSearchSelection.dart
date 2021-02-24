import 'dart:convert';
import 'dart:io';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'all_products_model.dart';
import 'filter_selection.dart';

class ProductSearchParams extends ChangeNotifier {
  List<ProductList> productList = [];
  AllProducts model;

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
      pageNo: "1",
      apkPageName: "listingPage",
      mobileUniqueCode: "");
  bool isLoading = false, isFiltered = false, isEmptyState = true;

  Future<void> changeFilterParams(String pageNo) async {
    filter.pageNo = pageNo;

    isLoading = true;
    notifyListeners();

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    dio.interceptors.add(PrettyDioLogger());

    try {
      Response response = await dio.post(allProducts, data: filter.toJson());

      print('${jsonEncode(filter)} kushi');

      final Map<String, dynamic> parsed = json.decode(response.data);
      print(parsed);
      if (parsed["status"] == "success") {
        model = AllProducts.fromJson(parsed);
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
        pageNo: "1",
        priceTo: "",
        apkPageName: "listingPage",
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
