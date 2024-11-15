import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatelessWidget {

  static const String name = 'search_screen';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Search'),
        
      ),

      body: const Center(
        child: Text('Search Screen'),
      ),
    );
  }
}