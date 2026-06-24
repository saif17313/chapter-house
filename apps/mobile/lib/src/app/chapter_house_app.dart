import 'package:chapter_house/src/routing/app_router.dart';
import 'package:flutter/material.dart';

class ChapterHouseApp extends StatelessWidget {
  const ChapterHouseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chapter House',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF245C5A)),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
