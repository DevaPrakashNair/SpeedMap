import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenManagerBloc extends Bloc<TokenManagerEvent, TokenManagerState> {
  String? place;
  String? review;
  bool a=false;
  TokenManagerBloc() : super(TokenManagerState()) {}
}



//events
class TokenManagerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}



class OTP extends TokenManagerEvent {
  final String otpNumber, phone;
  OTP({required this.otpNumber, required this.phone});
}
class ShowProfile extends TokenManagerEvent{}


//states

class TokenManagerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Otp extends TokenManagerState {}
class Checked extends TokenManagerState {}

class Error extends TokenManagerState {
  final String error;
  Error({required this.error});
}

