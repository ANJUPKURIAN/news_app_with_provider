import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_with_provider/model/new_api_res_model.dart';

class HomeScreenController with ChangeNotifier {
 List<String> categories = [
  "business",
  "entertainment",
  "general",
  "health",
  "science",
  "sports",
  "technology"

  ];

NewApiResModel ? resByCategory;// variable for get response
int selectedCategoryIndex = 0;

NewApiResModel? resModel;
  bool isLoading = false;

  // get data by category
    Future getDataByCategory({String category = "business"}) async{ 
     isLoading = true;
    notifyListeners();
    // step1
    Uri url = Uri.parse(
        " https://newsapi.org/v2/top-headlines?country=in&category=${categories[selectedCategoryIndex]}&apiKey=e77cf912ffb64b5fbf8db5dcf4a4e621");// from newsapi top headlines


    // step2
    var res = await http.get(url);

    //step 3
    if (res.statusCode == 200) {
      //  step 4 - decode
      var decodedData = jsonDecode(res.body);

      //  step 5 //convert to model class
      resModel = NewApiResModel.fromJson(decodedData);
      //step 6 state update
    } else {
  print("failed");
    }
    isLoading = false;
    notifyListeners();
  }

// on category selection
onCategorySelection(int value){
 selectedCategoryIndex = value;
 notifyListeners();
 getDataByCategory();
}

// for  get details from url


// Future getData(String searchQuery) async {
//     isLoading = true;
//     notifyListeners();
//     // step1
//     Uri url = Uri.parse(
//         "https://newsapi.org/v2/everything?q=$searchQuery&apiKey=742488509a4f4f23b93e7ac3afc24cad");

//     // step2
//     var res = await http.get(url);

//     //step 3
//     if (res.statusCode == 200) {
//       //  step 4 - decode
//       var decodedData = jsonDecode(res.body);

//       //  step 5 //convert to model class
//       resModel = NewApiResModel.fromJson(decodedData);
//       //step 6 state update
//     } else {
//       print("failed");
//     }
//     isLoading = false;
//     notifyListeners();
//   }

}