import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/locator.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/setup/edit_favorites_view.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';

class ConfigViewModel extends BaseModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();

  navigateToFavoritesPlaces() async {
    _navigationService.navigateTo(AddFavoritesViewRoute);
  }

  navigateToChangePassword() async {
    _navigationService.navigateTo(ChangePasswordViewRoute);
  }

  navigateToEditFavorites() async {
    _navigationService.navigateTo(EditFavoritesViewRoute);
  }

  navigateToEditProfile() async {
    _navigationService.navigateTo(EditProfileViewRoute, arguments: currentUser);
  }
}
