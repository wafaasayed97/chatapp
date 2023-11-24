part of 'get_data_cubit.dart';

abstract class GetDataState {}

///Get Data
class GetDataInitial extends GetDataState {}

class GetDataLoadingState extends GetDataState {}

class GetDataLoadedState extends GetDataState {}

class GetDataErrorState extends GetDataState {
  final String error;

  GetDataErrorState(this.error);
}
///Pick Profile Image

class GetDataProfilePickerLoadedState extends GetDataState {}

class GetDataProfilePickerErrorState extends GetDataState {}

///Upload Profile image
class GetDataUploadProfileLoadingState extends GetDataState {}
class GetDataUploadProfileLoadedState extends GetDataState {}

class GetDataUploadProfileErrorState extends GetDataState {}

/// All User
class GetDataAllUsersLoadingState extends GetDataState {}


class GetDataAllUsersLoadedState extends GetDataState {}

class GetDataAllUsersErrorState extends GetDataState {
  final String error;

  GetDataAllUsersErrorState(this.error);
}

///Chat Message
///Sent Message
class GetDataSentMessageLoadedState extends GetDataState {}

class GetDataSentMessageErrorState extends GetDataState {}

///Get Message
class GetDataGetMessageLoadedState extends GetDataState {}

class GetDataGetMessageErrorState extends GetDataState {}