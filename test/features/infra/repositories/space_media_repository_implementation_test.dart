import 'package:clean_architecture/features/infra/datasources/space_media_datasource.dart';
import 'package:clean_architecture/features/infra/models/space_media_model.dart';
import 'package:clean_architecture/features/infra/repositories/space_media_repository_implementation.dart';
import 'package:clean_architecture/shared/errors/exceptions.dart';
import 'package:clean_architecture/shared/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    title: 'Teste',
    description: 'Teste',
    mediaType: 'image',
    mediaUrl: 'http://test.com',
  );

  final tDate = DateTime(2021, 02, 02);

  test('should return space media model when calls the datasource', () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);

    final result = await repository.getSpaceMediaFromDate(tDate);

    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate));
    // verify(() => datasource)
    //     .called(#getSpaceMediaFromDate)
    //     .withArgs(positional: [tDate]).once();
  });

  test(
      'should return a server failure when the call to datasource is unsuccessful',
      () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());

    final result = await repository.getSpaceMediaFromDate(tDate);

    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate));
    // verify(() => datasource)
    //     .called(#getSpaceMediaFromDate)
    //     .withArgs(positional: [tDate]).once();
  });
}
