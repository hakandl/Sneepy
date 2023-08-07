import 'package:sneepy/product/constants/endpoints.dart';
import 'package:sneepy/product/models/countries_model.dart';
import 'package:sneepy/product/services/service_manager.dart';

class CountriesService {
  Future<List<CountriesModel>> getAllCountries() async {
    final response = await ServiceManager.makeRequest(
      endpoint: ApiEndpoints.countries,
      method: RequestMethod.GET,
    );
    final List jsonResponse = response.data;
    final countries =
        jsonResponse.map((e) => CountriesModel.fromJson(e)).toList();
    return countries;
  }
}
