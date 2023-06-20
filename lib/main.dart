import 'package:flickr_test_app/features/detail_page/presentation/bloc/detail_page_bloc.dart';
import 'package:flickr_test_app/features/favorite_page/presentation/bloc/favorite_page_bloc.dart';
import 'package:flickr_test_app/features/search_page/presentation/bloc/search_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/favorite_page/presentation/bloc/favorite_page_event.dart';
import 'features/search_page/presentation/pages/search_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const FlickerApp());
}

class FlickerApp extends StatelessWidget {
  const FlickerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FavoritePageBloc>(
            create: (context) =>
                di.sl<FavoritePageBloc>()..add(LoadFavoriteEvent()),
          ),
          BlocProvider<SearchPageBloc>(
            create: (context) => di.sl<SearchPageBloc>(),
          ),
          BlocProvider<DetailPageBloc>(
            create: (context) => di.sl<DetailPageBloc>(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flicker_test',
          home: SearchPage(),
        ));
  }
}
