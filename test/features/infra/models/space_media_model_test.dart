import 'dart:convert';

import 'package:clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:clean_architecture/features/infra/models/space_media_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
    description:
        "Meteors can be colorful. While the human eye usually cannot discern many colors, cameras often can. Pictured is a Quadrantids meteor captured by camera over Missouri, USA, early this month that was not only impressively bright, but colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a path across Earth's atmosphere.  Colors in meteors usually originate from ionized elements released as the meteor disintegrates, with blue-green typically originating from magnesium, calcium radiating violet, and nickel glowing green. Red, however, typically originates from energized nitrogen and oxygen in the Earth's atmosphere.  This bright meteoric fireball was gone in a flash -- less than a second -- but it left a wind-blown ionization trail that remained visible for several minutes.   APOD is available via Facebook: in English, Catalan and Portuguese",
    mediaType: "image",
    title: "A Colorful Quadrantid Meteor",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg",
  );

  test('should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('should return a valid model', () {
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);
    final result = SpaceMediaModel.fromJson(jsonMap);
    expect(result, tSpaceMediaModel);
  });

  test('should return a json map containing the proper data', () {
    final expectedMap = {
      "explanation":
          "Meteors can be colorful. While the human eye usually cannot discern many colors, cameras often can. Pictured is a Quadrantids meteor captured by camera over Missouri, USA, early this month that was not only impressively bright, but colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a path across Earth's atmosphere.  Colors in meteors usually originate from ionized elements released as the meteor disintegrates, with blue-green typically originating from magnesium, calcium radiating violet, and nickel glowing green. Red, however, typically originates from energized nitrogen and oxygen in the Earth's atmosphere.  This bright meteoric fireball was gone in a flash -- less than a second -- but it left a wind-blown ionization trail that remained visible for several minutes.   APOD is available via Facebook: in English, Catalan and Portuguese",
      "media_type": "image",
      "title": "A Colorful Quadrantid Meteor",
      "url":
          "https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg"
    };

    final result = tSpaceMediaModel.toJson();

    expect(result, expectedMap);
  });
}
