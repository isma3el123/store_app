abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class ChangeBottomNavIndexState extends LayoutState {}

class GetUserDataSuccessState extends LayoutState {}

class LoadingGetUserDataState extends LayoutState {}

class FaildGetUserDataState extends LayoutState {
  String erMassage;
  FaildGetUserDataState({required this.erMassage});
}

class GetBunnersLoadingState extends LayoutState {}

class GetBunnersSuccessState extends LayoutState {}

class FaildGetBunnersState extends LayoutState {}

class GetCategoriesLoadingState extends LayoutState {}

class GetCategoriesSuccessState extends LayoutState {}

class FaildGetCategoriesState extends LayoutState {}

class GetHomeProductLoadingState extends LayoutState {}

class GetHomeProductSuccessState extends LayoutState {}

class FaildGetHomeProductState extends LayoutState {}

class FilterProductSuccessState extends LayoutState {}

class FaildGetFavoritesState extends LayoutState {}

class GetFavoritesLoadingState extends LayoutState {}

class GetFavoritesSuccessState extends LayoutState {}

class FaildAddOrRemoveFavoritesFavoritesState extends LayoutState {}

class AddOrRemoveFavoritesLoadingState extends LayoutState {}

class AddOrRemoveFavoritesSuccessState extends LayoutState {}

class FaildGetCartsState extends LayoutState {}

class GetCartsLoadingState extends LayoutState {}

class GetCartsSuccessState extends LayoutState {}

class FaildAddOrRemoveCartState extends LayoutState {}

class AddOrRemoveCartLoadingState extends LayoutState {}

class AddOrRemoveCartSuccessState extends LayoutState {}

class FaildChangePasswordState extends LayoutState {
  String error;
  FaildChangePasswordState(this.error);
}

class ChangePasswordLoadingState extends LayoutState {}

class ChangePasswordSuccessState extends LayoutState {}

class FaildUpdateUserProfileState extends LayoutState {
  String error;
  FaildUpdateUserProfileState(this.error);
}

class UpdateUserProfileLoadingState extends LayoutState {}

class UpdateUserProfileSuccessState extends LayoutState {}
