import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flickr_test_app/core/api_constants/api_constants.dart';
import 'package:flickr_test_app/core/error/failures.dart';
import 'package:flickr_test_app/features/search_page/data/model/search_page_photos_model.dart';

abstract interface class SearchPageRemoteDataSource {
  Future<({PhotosModel? photos, Failure? error})> fetchRemotePhotos(
      String textQueue, int pageNumber);
}

class SearchPageRemoteDataSourceImpl extends SearchPageRemoteDataSource {
  SearchPageRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<({Failure? error, PhotosModel? photos})> fetchRemotePhotos(
      String textQueue, int pageNumber) async {
    final rawUrl = Uri.https('www.flickr.com', 'services/rest/');
    var requestBody = {
      'method': ApiConstants.photoSearchMethod,
      'api_key': ApiConstants.apiKey,
      'text': textQueue,
      'per_page': ApiConstants.perPage,
      'page': pageNumber.toString(),
      'format': ApiConstants.format,
      'nojsoncallback': '1'
    };
    try {
      final response = await client.post(rawUrl, body: requestBody);
      if (response.statusCode == 200) {
        final decodedResponse =
            (json.decode(response.body))['photos'] as Map<String, dynamic>;
        final photosObject = PhotosModel.fromJson(decodedResponse);
        final ({Failure? error, PhotosModel? photos}) result =
            (error: null, photos: photosObject);
        return result;
      } else {
        final ({Failure? error, PhotosModel? photos}) failureResult =
            (error: ServerFailure(), photos: null);
        return failureResult;
      }
    } catch (e) {
      final ({Failure? error, PhotosModel? photos}) failureResult =
          (error: ServerFailure(), photos: null);
      return failureResult;
    }
  }
}
