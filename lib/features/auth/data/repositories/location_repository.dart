import 'package:marshmallow/features/auth/data/datasources/location_remote_datasource.dart';
import 'package:marshmallow/features/auth/data/models/location_response_model.dart';

class LocationRepository {
  final LocationRemoteDatasource datasource;

  LocationRepository(this.datasource);

  Future<LocationResponseModel?> getCoordinates(String address) async {
    return await datasource.getCoordinatesFromAddress(address);
  }

  Future<LocationResponseModel?> reverseGeocode(double lat, double lng) async {
    return await datasource.reverseGeocode(lat, lng);
  }
}
