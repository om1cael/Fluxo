import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final categories = <String>[
    "General",
    "Technology",
    "Science",
    "Entertainment",
    "Sports",
    "Health",
    "Business",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fluxo",
          style: TextStyle(
            fontWeight: .bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16,),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (_, item) {
                            return FilterChip(
                              label: Text(categories[item]), 
                              onSelected: (value) {}
                            );
                          }, 
                          separatorBuilder: (_, _) => SizedBox(width: 8,), 
                          itemCount: categories.length
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}