import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Helper/repository.dart';
import '../Model/viewReviewModel.dart';

class ViewReviewBloc extends Bloc<ViewReviewEvent, ViewReviewState> {
  ViewReviewBloc() : super(ViewReviewState()) {
    on<CheckViewReview>(_CheckViewReview);
  }



  Future<FutureOr<void>> _CheckViewReview(
      CheckViewReview event, Emitter<ViewReviewState> emit) async {
    emit(CheckingViewReview());
    ViewReviewModel view;
    view = await Repository().viewreview(url: '/view/review');
    if (view.status == true) {
      // await TempStorage.addToken(ViewReviewModel.token.toString());
      // print(ViewReviewModel.token.toString());
      emit(ViewChecked(view));
    } else {
      emit(ViewError(error: view.msg.toString()));
    }
  }
}
//events
class ViewReviewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}



class CheckViewReview extends ViewReviewEvent {

}



//states

class ViewReviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckingViewReview extends ViewReviewState {}
class ViewChecked extends ViewReviewState {
  final ViewReviewModel? view;
  ViewChecked(this.view);
}

class ViewError extends ViewReviewState {
  final String error;
  ViewError({required this.error});
}