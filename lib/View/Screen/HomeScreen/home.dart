import 'package:flutter/material.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      bottomNavigationBar:NavBar(currentIndex:0),

    );
  }
}
