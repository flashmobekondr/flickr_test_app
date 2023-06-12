import 'package:flickr_test_app/core/network/network_info.dart';
import 'package:flickr_test_app/features/search_page/data/datasources/search_page_remote_data_source.dart';
import 'package:flickr_test_app/features/search_page/data/repositories/search_page_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async{
  runApp(const MyApp());
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
    var nestedRequest = SearchPageRepositoryImpl(
        remoteDataSource: SearchPageRemoteDataSourceImpl(client: http.Client()) ,
        networkInfo:NetworkInfoImpl(connectionChecker:  InternetConnectionChecker())
    );
    return  Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
      body: FutureBuilder(
        future: nestedRequest.getRemotePhotos('New York', 10),
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1/1
                ),
                itemCount: snapshot.data!.photos!.perpage,
                itemBuilder: (context,index){
                  return Material(
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                snapshot.data!.photos!.photo[index].photoUrl
                            )
                          )
                        ),
                      )
                    ),
                  );
                }
            );
          } else {return const Text("ooooooops"); }
        },
      ),
    );
  }
}

/*
FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: snapshot.data!.photos!.photo[index].photoUrl
                        )
 */