class SearchSuggestionModel {
  String status;
  String message;
  List<SearchHistory> searchHistory;

  SearchSuggestionModel({this.status, this.message, this.searchHistory});

  SearchSuggestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['searchHistory'] != null) {
      searchHistory = new List<SearchHistory>();
      json['searchHistory'].forEach((v) {
        searchHistory.add(new SearchHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.searchHistory != null) {
      data['searchHistory'] =
          this.searchHistory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchHistory {
  String searchId;
  String searchKey;

  SearchHistory({this.searchId, this.searchKey});

  SearchHistory.fromJson(Map<String, dynamic> json) {
    searchId = json['searchId'];
    searchKey = json['searchKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchId'] = this.searchId;
    data['searchKey'] = this.searchKey;
    return data;
  }
}
