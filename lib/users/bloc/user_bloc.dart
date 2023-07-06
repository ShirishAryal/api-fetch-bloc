import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user.dart';
import '../services/api_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final ApiServices apiService = ApiServices();
    on<GetUserEvent>(
      (event, emit) async {
        emit(UserLoading());
        try {
          final userList = await apiService.getUser();
          emit(UserLoaded(userList));
        } catch (e) {
          emit(UserError(e.toString()));
        }
      },
    );
  }
}
