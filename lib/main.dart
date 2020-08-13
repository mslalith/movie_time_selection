import 'package:flutter/material.dart';
import 'package:movie_time_selection/providers/day_time_provider.dart';
import 'package:movie_time_selection/providers/scroll_provider.dart';
import 'package:movie_time_selection/themes/app_theme.dart';
import 'package:movie_time_selection/widgets/home_content.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Time Selection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.appBarColor,
        fontFamily: 'Lato',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DayTimeProvider()),
          ChangeNotifierProvider(create: (_) => ScrollProvider()),
        ],
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24.0),
      child: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Scaffold(
            body: HomeContent(),
          ),
        ),
      ),
    );
  }
}
