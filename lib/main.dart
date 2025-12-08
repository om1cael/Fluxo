import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxo/data/repositories/article_repository.dart';
import 'package:fluxo/data/services/api_service.dart';
import 'package:fluxo/ui/home/view/home_screen.dart';
import 'package:fluxo/ui/home/view_model/home_screen_view_model.dart';

Future main() async {
  await dotenv.load();
  
  runApp(
    ProviderScope(
      child: const Fluxo(),
    ),
  );
}

class Fluxo extends StatelessWidget {
  const Fluxo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(
        viewModel: HomeScreenViewModel(
          articleRepository: ArticleRepository(
            apiService: ApiService()
          )
        ),
      ),
    );
  }
}