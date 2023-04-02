import 'dart:collection';

import 'package:get/get.dart';
import 'package:getx_mvvm/data/response/status.dart';
import 'package:getx_mvvm/models/home/user_list_model.dart';
import 'package:getx_mvvm/repository/home_repository/home_repository.dart';
import 'package:getx_mvvm/repository/suggestions/suggestions_repository.dart';



class SuggestionController extends GetxController {
  final _api = SuggestionRepository();


  final rxRequestStatus = Status.LOADING.obs;
  RxList suggestionList = [].obs; // this is succesious
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setsuggestionList(List<Book> _value) => suggestionList.value = _value;
  void setError(String _value) => error.value = _value;



  void suggestionListApi(String query) {
    //  setRxRequestStatus(Status.LOADING);

    _api.getSuggesitons(query).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setsuggestionList(value);
    
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  
}
