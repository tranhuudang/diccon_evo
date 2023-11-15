import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../common/domain/models/user_info/user_info.dart' as user_model;
import 'package:diccon_evo/src/common/common.dart';
import '../../../common/data/services/auth_service.dart';

/// User Events
abstract class UserEvent {}

class UserDeleteDateEvent extends UserEvent {}

class UserLoginEvent extends UserEvent {}

class UserLogoutEvent extends UserEvent {}

class UserSyncEvent extends UserEvent {
  user_model.UserInfo userInfo;
  UserSyncEvent({required this.userInfo});
}

/// User State
abstract class UserState {}

abstract class UserActionState extends UserState {}

class UserUninitialized extends UserState {}

class NoInternetState extends UserActionState {}

class UserLoggingoutState extends UserActionState {}

class UserLogoutCompletedState extends UserActionState {}

class UserLogoutErrorState extends UserActionState {}

class UserLoginState extends UserState {
  bool isSyncing = false;
  user_model.UserInfo userInfo;
  UserLoginState({required this.userInfo, required this.isSyncing});
}

class UserLoggedInSuccessfulState extends UserActionState {}

class UserSyncingState extends UserState {}

class UserSyncCompleted extends UserActionState {}

/// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserUninitialized()) {
    on<UserLoginEvent>(_userLogin);
    on<UserLogoutEvent>(_userLogout);
    on<UserSyncEvent>(_userSyncData);
    on<UserDeleteDateEvent>(_deleteAllData);
  }

  FutureOr<void> _deleteAllData(
      UserDeleteDateEvent deleteAll, Emitter<UserState> emit) async {
    /// Remove online file
    await UserHandler().deleteUserDataFile();

    /// Remove local file
    await FileHandler(Constants.wordHistoryFileName)
        .deleteOnUserData();
    await FileHandler(Constants.storyHistoryFileName)
        .deleteOnUserData();
    await FileHandler(Constants.storyBookmarkFileName)
        .deleteOnUserData();
    await FileHandler(Constants.topicHistoryFileName)
        .deleteOnUserData();
    await FileHandler(Constants.essentialFavouriteFileName)
        .deleteOnUserData();
    await Future.delayed(const Duration(seconds: 2));
  }

  FutureOr<void> _userSyncData(
      UserSyncEvent sync, Emitter<UserState> emit) async {
    emit(UserLoginState(isSyncing: true, userInfo: sync.userInfo));
    await UserHandler().downloadUserDataFile();
    await UserHandler()
        .uploadUserDataFile(Constants.wordHistoryFileName);
    await UserHandler()
        .uploadUserDataFile(Constants.storyHistoryFileName);
    await UserHandler()
        .uploadUserDataFile(Constants.storyBookmarkFileName);
    await UserHandler()
        .uploadUserDataFile(Constants.topicHistoryFileName);
    await UserHandler()
        .uploadUserDataFile(Constants.essentialFavouriteFileName);
    emit(UserLoginState(isSyncing: false, userInfo: sync.userInfo));
    emit(UserSyncCompleted());
    if (kDebugMode) {
      print("Data is synced");
    }
  }

  /// --------------------------------------------------------------------------

  Future _userLogin(UserLoginEvent login, Emitter<UserState> emit) async {
    var currentLoggedInUser = _currentLoggedInUser();
    if (currentLoggedInUser != null) {
      Properties.userInfo = Properties.userInfo.copyWith(
        uid: currentLoggedInUser.uid,
        displayName: currentLoggedInUser.displayName ?? '',
        photoURL: currentLoggedInUser.photoURL ?? '',
        email: currentLoggedInUser.email ?? '',
      );
      emit(UserLoginState(userInfo: Properties.userInfo, isSyncing: false));
    } else {
      // Check internet connection
      bool isInternetConnected =
          await InternetConnectionChecker().hasConnection;
      if (kDebugMode) {
        print("[Internet Connection] $isInternetConnected");
      }
      if (isInternetConnected) {
        AuthService authService = AuthService();
        User? user = await authService.googleSignIn();
        Properties.userInfo = Properties.userInfo.copyWith(
          uid: user!.uid,
          displayName: user.displayName ?? '',
          photoURL: user.photoURL ?? '',
          email: user.email ?? '',
        );
        emit(UserLoginState(userInfo: Properties.userInfo, isSyncing: false));
        emit(UserLoggedInSuccessfulState());
        // Sync user data right after log in successful
        add(UserSyncEvent(userInfo: Properties.userInfo));
      } else {
        emit(NoInternetState());
      }
    }
  }

  FutureOr<void> _userLogout(
      UserLogoutEvent logout, Emitter<UserState> emit) async {
    /// Reset User object
    emit(UserLoggingoutState());

    /// Logout Auth services
    AuthService authService = AuthService();
    authService.googleSignOut();

    /// Remove local file
    await FileHandler(Constants.wordHistoryFileName)
        .deleteOnUserData();
    await FileHandler(Constants.storyHistoryFileName)
        .deleteOnUserData();
    await FileHandler(Constants.storyBookmarkFileName)
        .deleteOnUserData();
    await FileHandler(Constants.topicHistoryFileName)
        .deleteOnUserData();
    await FileHandler(Constants.essentialFavouriteFileName)
        .deleteOnUserData();

    /// Reset properties
    Properties.userInfo = user_model.UserInfo.empty();
    await Future.delayed(const Duration(seconds: 2));
    emit(UserLogoutCompletedState());
    emit(UserUninitialized());
  }

  User? _currentLoggedInUser() {
    // Check if user still login to device
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.uid.isNotEmpty) {
        if (kDebugMode) {
          print("User.uid.isNotEmpty: ${user.uid}");
        }
      }
      return user;
    } else {
      if (kDebugMode) {
        print("No user logged in in this device.");
      }
      return null;
    }
  }
}
