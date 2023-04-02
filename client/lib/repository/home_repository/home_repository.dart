import 'dart:ui';

import 'package:getx_mvvm/data/network/network_api_services.dart';
import 'package:getx_mvvm/models/home/user_list_model.dart';
import 'package:getx_mvvm/res/app_url/app_url.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();
  Future<List<Book>> BookList() async {
    List<Book> BookList = [];
    dynamic response = await _apiService.getApi(AppUrl.fetchallbooks);
     final List<String> keys = [];
    for (Map<String, dynamic> i in response) {
      keys.add('ISBN:${i['key']}');
    }

    final Map<String, dynamic> data = await _apiService.getApi(
        'https://openlibrary.org/api/books?bibkeys=${keys.join(",")}&format=json&jscmd=data');

    List<dynamic> list = data.values.toList();
    for (int i = 0; i < list.length; i++) {
      BookList.add(Book(
          id: response[i]['_id'],
          user: response[i]['user'],
          key: response[i]['key'],
          price: response[i]['price'],
          title: list[i]['title'],
          coverUrl: list[i]['cover']['medium']));
    }
    
    return BookList;
  }
}
