

import '../../data/network/network_api_services.dart';

class BookRepository {
  final _baseUrl = 'https://openlibrary.org/';

  Future<dynamic> getBookSuggestions(String query) async {
    final url = _baseUrl + 'search.json?q=$query';

    try {
      final response = await NetworkApiServices().getApi(url);
      List<dynamic> suggestions = response['docs'];
      return suggestions;
      
    } catch (e) {
      print('Error getting book suggestions: $e');
      throw e;
    }
  }
}
