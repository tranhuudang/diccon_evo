import 'dart:async';
import 'package:diccon_evo/src/core/utils/tokens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../data/data.dart';
import '../../../data/services/auth_service.dart';
import 'package:diccon_evo/src/core/core.dart';

/// User Events
abstract class UserEvent {}

class UserDeleteDateEvent extends UserEvent {}

class GoogleLoginEvent extends UserEvent {}

class UserLogoutEvent extends UserEvent {}
class CheckIsSignedInEvent extends UserEvent {}

class UserSyncEvent extends UserEvent {
}

/// User State
abstract class UserState {}

abstract class UserActionState extends UserState {}

class UserUninitialized extends UserState {}

class NoInternetState extends UserActionState {}

class UserLoggingOutState extends UserActionState {}

class UserLogoutCompletedState extends UserActionState {}

class UserLogoutErrorState extends UserActionState {}

class UserLoginState extends UserState {
  bool isSyncing = false;
  UserLoginState({required this.isSyncing});
}

class UserLoggedInSuccessfulState extends UserActionState {}

class UserSyncingState extends UserState {}

class UserSyncCompleted extends UserActionState {}

/// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserUninitialized()) {
    on<GoogleLoginEvent>(_googleLogin);
    on<UserLogoutEvent>(_userLogout);
    on<UserSyncEvent>(_userSyncData);
    on<UserDeleteDateEvent>(_deleteAllData);
    on<CheckIsSignedInEvent>(_checkIsSignedIn);
  }

  FutureOr<void> _deleteAllData(
      UserDeleteDateEvent deleteAll, Emitter<UserState> emit) async {
    /// Remove online file
    await UserHandler().deleteUserDataFile();

    /// Remove local file
    await FileHandler(LocalDirectory.wordHistoryFileName)
        .deleteOnUserData();
    await FileHandler(LocalDirectory.storyHistoryFileName)
        .deleteOnUserData();
    await FileHandler(LocalDirectory.storyBookmarkFileName)
        .deleteOnUserData();
    await FileHandler(LocalDirectory.topicHistoryFileName)
        .deleteOnUserData();
    await FileHandler(LocalDirectory.essentialFavouriteFileName)
        .deleteOnUserData();
    await Future.delayed(const Duration(seconds: 2));
  }

  FutureOr<void> _userSyncData(
      UserSyncEvent sync, Emitter<UserState> emit) async {
    emit(UserLoginState(isSyncing: true,));
    await UserHandler().downloadUserDataFile();
    await UserHandler()
        .uploadUserDataFile(LocalDirectory.wordHistoryFileName);
    await UserHandler()
        .uploadUserDataFile(LocalDirectory.storyHistoryFileName);
    await UserHandler()
        .uploadUserDataFile(LocalDirectory.storyBookmarkFileName);
    await UserHandler()
        .uploadUserDataFile(LocalDirectory.topicHistoryFileName);
    await UserHandler()
        .uploadUserDataFile(LocalDirectory.essentialFavouriteFileName);
    emit(UserLoginState(isSyncing: false,));
    emit(UserSyncCompleted());
    if (kDebugMode) {
      print("Data is synced");
    }
  }

  /// --------------------------------------------------------------------------
  Future _checkIsSignedIn(CheckIsSignedInEvent event, Emitter<UserState> emit) async {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(UserLoginState(isSyncing: false));
    }
  }
  Future _googleLogin(GoogleLoginEvent login, Emitter<UserState> emit) async {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(UserLoginState(isSyncing: false));
    } else {
      // Check internet connection
      bool isInternetConnected =
          await InternetConnectionChecker().hasConnection;
      if (kDebugMode) {
        print("[Internet Connection] $isInternetConnected");
      }
      if (isInternetConnected) {
        AuthService authService = AuthService();
        await authService.googleSignIn();
        await Tokens.addTokenToNewUser();
        emit(UserLoginState(isSyncing: false));
        emit(UserLoggedInSuccessfulState());
        // Sync user data right after log in successful
        add(UserSyncEvent());
      } else {
        emit(NoInternetState());
      }
    }
  }

  FutureOr<void> _userLogout(
      UserLogoutEvent logout, Emitter<UserState> emit) async {
    /// Reset User object
    emit(UserLoggingOutState());

    /// Logout Auth services
    AuthService authService = AuthService();
    authService.googleSignOut();
    FirebaseAuth.instance.currentUser?.delete();
    /// Remove local file
    await FileHandler(LocalDirectory.wordHistoryFileName)
        .deleteOnUserData();
    await FileHandler(LocalDirectory.storyHistoryFileName)
        .deleteOnUserData();
    await FileHandler(LocalDirectory.storyBookmarkFileName)
        .deleteOnUserData();
    await FileHandler(LocalDirectory.topicHistoryFileName)
        .deleteOnUserData();
    await FileHandler(LocalDirectory.essentialFavouriteFileName)
        .deleteOnUserData();

    /// Reset properties
    await Future.delayed(const Duration(seconds: 2));
    emit(UserLogoutCompletedState());
    emit(UserUninitialized());
  }
}
