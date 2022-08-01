import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Helper/repository.dart';
import '../Model/enterReviewModel.dart';


class EnterReviewBloc extends Bloc<EnterReviewEvent
, EnterReviewState
> {
  EnterReviewBloc
      () : super(EnterReviewState
    ()) {

    on<CheckReview>(_CheckReview);
  }



  Future<FutureOr<void>> _CheckReview(
      CheckReview event, Emitter<EnterReviewState
      > emit) async {
    emit(CheckingReview());
    EnterReviewModel enterReviewModel;
    Map data = {
      "location": event.location,
      "review": event.review,
    };


    enterReviewModel =
    await Repository().review(url: '/review/recieve', data: data);
    if (enterReviewModel.status == true) {
      emit(ReviewChecked());
    } else {
      emit(ReviewError(error: enterReviewModel.msg.toString()));
    }
  }
}
//events
class EnterReviewEvent
    extends Equatable {
  @override
  List<Object?> get props => [];
}



class CheckReview extends EnterReviewEvent
{
  final String location, review;
  CheckReview({required this.review, required this.location});
}


//states

class EnterReviewState
    extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckingReview extends EnterReviewState
{}
class ReviewChecked extends EnterReviewState
{}

class ReviewError extends EnterReviewState
{
  final String error;
  ReviewError({required this.error});
}