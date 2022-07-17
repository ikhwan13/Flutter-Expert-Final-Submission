import 'dart:convert';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  late TvSeriesRemoteDataSourceImpl dataSourceImpl;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSourceImpl = TvSeriesRemoteDataSourceImpl(client: mockIOClient);
  });

  group('get Now Playing Tv', () {
    final tTvList = TvResponse.fromJson(json.decode(
            readJson('dummy_data/tv_series/now_playing_tv.json')))
        .tvSeriesList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/now_playing_tv.json'),
              200));
      // act
      final result = await dataSourceImpl.getNowPlaying();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getNowPlaying();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv', () {
    final tTvList = TvResponse.fromJson(json
            .decode(readJson('dummy_data/tv_series/popular_tv.json')))
        .tvSeriesList;

    test('should return list of tv when response is success (200)', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/popular_tv.json'), 200));
      // act
      final result = await dataSourceImpl.getPopularTvSeries();
      // assert
      expect(result, tTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv', () {
    final tTvList = TvResponse.fromJson(json
            .decode(readJson('dummy_data/tv_series/top_rated_tv.json')))
        .tvSeriesList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/top_rated_tv.json'), 200));
      // act
      final result = await dataSourceImpl.getTopRatedTvSeries();
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getTopRatedTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    const tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/tv_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey'))).thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data/tv_series/tv_detail.json'), 200));
      // act
      final result = await dataSourceImpl.getDetailTvSeries(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getDetailTvSeries(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvList = TvResponse.fromJson(json.decode(
            readJson('dummy_data/tv_series/tv_recommendations.json')))
        .tvSeriesList;
    const tId = 1;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_recommendations.json'),
              200));
      // act
      final result = await dataSourceImpl.getRecommendedTvSeries(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getRecommendedTvSeries(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/search_tv.json')))
        .tvSeriesList;
    const tQuery = 'Game Of Thrones';

    test('should return list of tv when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/search_tv.json'), 200));
      // act
      final result = await dataSourceImpl.getSearchTv(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getSearchTv(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
