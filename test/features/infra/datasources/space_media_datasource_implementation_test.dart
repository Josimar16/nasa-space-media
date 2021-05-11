import 'dart:io';

import 'package:clean_architecture/features/infra/datasources/space_media_datasource.dart';
import 'package:clean_architecture/features/infra/datasources/space_media_datasource_implementation.dart';
import 'package:clean_architecture/features/infra/models/space_media_model.dart';
import 'package:clean_architecture/shared/errors/exceptions.dart';
import 'package:clean_architecture/shared/http_client/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = NasaDatasourceImplementation(client);
  });

  final tDate = DateTime(2021, 02, 02);
  final urlExpected =
      "https://api.nasa.gov/planetary/apod?hd=true&api_key=DEMO_KEY&date=2021-02-02";

  void successMock() {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  test('should call the get method with correct url', () async {
    successMock();

    await datasource.getSpaceMediaFromDate(tDate);

    verify(() => client.get(urlExpected)).called(1);
  });

  test('should return a SpaceMediaModel when is successful', () async {
    successMock();

    final tSpaceMediaModelExpected = SpaceMediaModel(
      description:
          "Meteors can be colorful. While the human eye usually cannot discern many colors, cameras often can. Pictured is a Quadrantids meteor captured by camera over Missouri, USA, early this month that was not only impressively bright, but colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a path across Earth's atmosphere.  Colors in meteors usually originate from ionized elements released as the meteor disintegrates, with blue-green typically originating from magnesium, calcium radiating violet, and nickel glowing green. Red, however, typically originates from energized nitrogen and oxygen in the Earth's atmosphere.  This bright meteoric fireball was gone in a flash -- less than a second -- but it left a wind-blown ionization trail that remained visible for several minutes.   APOD is available via Facebook: in English, Catalan and Portuguese",
      mediaType: "image",
      title: "A Colorful Quadrantid Meteor",
      mediaUrl:
          "https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg",
    );

    final result = await datasource.getSpaceMediaFromDate(tDate);

    expect(result, tSpaceMediaModelExpected);
  });

  test('should throw a ServerException when the call is unccessful', () async {
    when(() => client.get(any())).thenAnswer((_) async =>
        HttpResponse(data: 'something went wrong', statusCode: 400));

    final result = datasource.getSpaceMediaFromDate(tDate);

    expect(() => result, throwsA(ServerException()));
  });
}
