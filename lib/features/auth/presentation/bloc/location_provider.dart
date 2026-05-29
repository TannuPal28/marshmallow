import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marshmallow/features/auth/data/datasources/location_remote_datasource.dart';
import 'package:marshmallow/features/auth/data/repositories/location_repository.dart';

class LocationProvider extends ChangeNotifier {
  final repository = LocationRepository(LocationRemoteDatasource());

  //controllers

  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();

  final cityController = TextEditingController();

  final stateController = TextEditingController();

  final pincodeController = TextEditingController();

  final countryController = TextEditingController(text: "India");

  final latitudeController = TextEditingController();

  final longitudeController = TextEditingController();

  bool isLoading = false;

  String errorMessage = "";

  //Get coordinates

  Future<void> getCoordinatesFromAddress() async {
    try {
      isLoading = true;
      notifyListeners();
      final address =
          "${address1Controller.text}, "
          "${address2Controller.text}, "
          "${cityController.text}, "
          "${stateController.text}, "
          "${pincodeController.text}, India";

      final result = await repository.getCoordinates(address);
      if (result != null) {
        latitudeController.text = result.latitude;
        longitudeController.text = result.longitude;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //Current location
  Future<void> getCurrentLocation() async {
    try {
      isLoading = true;
      notifyListeners();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        errorMessage = "Location service disabled";

        notifyListeners();
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition();
      latitudeController.text = position.latitude.toString();
      longitudeController.text = position.longitude.toString();

      final result = await repository.reverseGeocode(
        position.latitude,
        position.longitude,
      );

      if (result != null) {
        cityController.text = result.city;
        stateController.text = result.state;
        pincodeController.text = result.pincode;
        countryController.text = result.country;

        address2Controller.text = result.area;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
