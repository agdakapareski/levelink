import 'package:flutter/cupertino.dart';
import 'package:sivat/api/rating_api.dart';
import 'package:sivat/model/rating_model.dart';

class RatingProvider extends ChangeNotifier {
  SummaryRating rating = SummaryRating();
  bool isLoading = false;

  getRating(int idUser) async {
    isLoading = true;
    rating = await RatingApi().getRating(idUser);
    isLoading = false;

    notifyListeners();
  }
}
