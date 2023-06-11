import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flickr_test_app/core/api_constants/api_constants.dart';

import 'core/error/failures.dart';
import 'features/search_page/data/model/search_page_photos_model.dart';

void main() async{
  runApp(const MyApp());
  var result = await fetchData();
  print(result.photos!.photo[1].title);
}

Future<({Failure? error,PhotosModel? photos})> fetchData() async{
  final http.Client client =http.Client();
  final rawUrl = Uri.https('www.flickr.com','services/rest/');
  var requestBody = {
    'method':ApiConstants.photoSearchMethod,
    'api_key':ApiConstants.apiKey,
    'text': 'waterfall',
    'per_page' : '20',
    'page': '1',
    'format' : ApiConstants.format,
    'nojsoncallback': '1'
  };
  try {
    final response = await client.post(rawUrl,body: requestBody);
    if (response.statusCode == 200) {
      print('status code 200 success');
      final decodedResponse = (json.decode(response.body))['photos'] as Map<String,dynamic>;
      final photosObject = PhotosModel.fromJson(decodedResponse);
  final ({Failure? error, PhotosModel? photos}) result = (error: null, photos: photosObject);
  return result;
  } else {
  final ({Failure? error, PhotosModel? photos}) failureResult = (error:ServerFailure(), photos: null);
  return failureResult;
  }
  } finally {
  client.close();
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'title',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
      ),
      home: const MyHomePage(title: 'rrr',)
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key,required this.title}) ;
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
    );
  }
}
