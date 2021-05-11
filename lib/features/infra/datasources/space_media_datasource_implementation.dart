import 'dart:convert';
import 'dart:developer';

import 'package:clean_architecture/features/infra/datasources/endpoints/nasa_endpoints.dart';
import 'package:clean_architecture/features/infra/datasources/space_media_datasource.dart';
import 'package:clean_architecture/features/infra/models/space_media_model.dart';
import 'package:clean_architecture/shared/errors/exceptions.dart';
import 'package:clean_architecture/shared/http_client/http_client.dart';
import 'package:clean_architecture/shared/utils/converters/date_to_string_converter.dart';
import 'package:clean_architecture/shared/utils/keys/nasa_api_keys.dart';

class NasaDatasourceImplementation implements ISpaceMediaDatasource {
  final HttpClient client;

  NasaDatasourceImplementation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(
      NasaEndpoints.apod(
        NasaApiKeys.apiKey,
        DateToStringConverter.convert(date),
      ),
    );
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
