import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/api_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

class ApiFetchBloc extends Bloc<ApiFetchEvent, ApiFetchState> {
  ApiFetchBloc() : super(ApiFetchInitial()) {
    on<Fetch>((event, emit) async {
      emit(ApiFetchProgress());
      try {
        String endpoint = 'http://localhost:5000/users';

        final response = await http.get(Uri.parse(endpoint));

        if (response.statusCode == 200) {
          dynamic actualResponse = jsonDecode(response.body);
          debugPrint(actualResponse.toString());
          List<User> userList = UserList.fromApi(actualResponse).users;
          emit(ApiFetchSuccess(userList));
        } else {
          debugPrint(response.toString());
          emit(ApiFetchFailure("Failed to load users"));
        }
      }  catch (e) {
         debugPrint(e.toString());
      }
    });
  }
}

//states instantiation
abstract class ApiFetchState {}

//events instantiation
abstract class ApiFetchEvent {}

//states implementation
class ApiFetchInitial extends ApiFetchState {}

class ApiFetchProgress extends ApiFetchState {}

class ApiFetchSuccess extends ApiFetchState {
  final List<User> users;
  ApiFetchSuccess(this.users);
}

class ApiFetchFailure extends ApiFetchState {
  ApiFetchFailure(this.error);
  final dynamic error;
}

//events implementation
class Fetch extends ApiFetchEvent {
  
}
