import '../../data/network/network_api_services.dart';
import '../../models/getuser/get_user_model.dart';
import '../../res/app_url/app_url.dart';

class SuggestionRepository{
   final _apiService  = NetworkApiServices() ;


   Future<dynamic> getSuggesitons(String query) async{
    dynamic response = await _apiService.getApi(AppUrl.ApibaseUrl+'search.json?q=$query');
       List<dynamic> suggestions = response['docs'].sublist(0,30);
       Set<String> uniqueTitles = Set();
List<Map<String, dynamic>> uniqueBooks = [];

for (var book in suggestions) {
  String title = book['title'];
  if (!uniqueTitles.contains(title)) {
    uniqueTitles.add(title);
    uniqueBooks.add(book);
  }
}
    return uniqueBooks;
   }
}