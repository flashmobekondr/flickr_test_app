import 'package:flickr_test_app/core/network/network_info.dart';
import 'package:flickr_test_app/features/search_page/data/datasources/search_page_remote_data_source.dart';
import 'package:flickr_test_app/features/search_page/data/repositories/search_page_repository_impl.dart';
import 'package:flickr_test_app/features/search_page/domain/usecases/search_page_usecase_get_photos.dart';
import 'package:flickr_test_app/features/search_page/presentation/bloc/search_page_bloc.dart';
import 'package:flickr_test_app/features/search_page/presentation/bloc/search_page_bloc_event.dart';
import 'package:flickr_test_app/features/search_page/presentation/bloc/search_page_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';


void main() async{
  runApp(const EntryPage());
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
      home: const MyHomePage(title: 'Pictures',)
    );
  }
}

var nestedRequest = SearchPageRepositoryImpl(
    remoteDataSource: SearchPageRemoteDataSourceImpl(client: http.Client()) ,
    networkInfo:NetworkInfoImpl(connectionChecker:  InternetConnectionChecker())
);

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider<SearchPageBloc>(
              create: (context) => SearchPageBloc(
                  fetchPhotos: FetchPhotos(
                      searchPageRepository: nestedRequest
                  ),
              ),
          ),
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'title',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
        ),
        home: const SearchPage(),
        )
    );
  }
}


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController..removeListener(_onScroll)..dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: TextField(
          controller: _textController,
          autocorrect: true,
          //autofocus: true,
          onChanged: (text) {
                BlocProvider.of<SearchPageBloc>(context).add(SearchPageTextChanged(text: _textController.text));
          },
          decoration: InputDecoration(
            //border: InputBorder.none,
            //prefix: Icon(Icons.search),
            suffix: GestureDetector(
              onTap: _onTapClear,
              child: const Icon(Icons.clear),
            ),
            hintText: 'Search movie...',
          ),
        ),
      ),
      body: BlocBuilder<SearchPageBloc,SearchPageState>(
        builder:(context,state) {
          switch(state.status) {
            case PhotoStatus.failure :
              return const Center(child: Text('failed to fetch photos'));
            case PhotoStatus.initial :
              return const Center(child: Text('Explore pictures you want'));
            case PhotoStatus.success :
              if (state.photos.isEmpty) {
                return const Center(child: Text('no posts'));
              }
              return GridView.builder(
                  controller: _scrollController,
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1/1
                  ),
                  itemCount: state.hasReachedMax
                      ? state.photos.length
                      : state.photos.length + 1,
                  itemBuilder: (context,index){
                    return index >= state.photos.length
                    ? const BottomLoader()
                    : Material(
                      child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        state.photos[index].photoUrl
                                    )
                                )
                            ),
                          )
                      ),
                    );
                  }
              );
          }
        } ,
      ),
    );
  }

  void _onTapClear() {
    _textController.clear();
  }
  void _onScroll() {
    if (_isBottom) BlocProvider.of<SearchPageBloc>(context).add(SearchPageLoadNewPage(text: _textController.text));
    //context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}










class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,required this.title}) ;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int axisCount = 2;
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _featureRet()async {
    //String text = _textController.text ?? '';
    return;
  }

  @override
  Widget build(BuildContext context) {

    var nestedRequest = SearchPageRepositoryImpl(
        remoteDataSource: SearchPageRemoteDataSourceImpl(client: http.Client()) ,
        networkInfo:NetworkInfoImpl(connectionChecker:  InternetConnectionChecker())
    );
    void changeGrid(){
      setState(() {
        axisCount = 4;
      });
    }

    return  Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: changeGrid,
            child:  const Icon(Icons.photo),
          )
        ],
        title: const Text('AppBar'),
      ),
      body: RefreshIndicator(
        onRefresh: _featureRet,
        child: FutureBuilder(
          future: nestedRequest.getRemotePhotos('New York', 10),
          builder: (BuildContext context, snapshot){
            if(snapshot.hasData) {
              return GridView.builder(
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: axisCount,
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