import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluxo/data/repositories/article_repository.dart';
import 'package:fluxo/data/services/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<ApiService>()])
import 'article_repository_test.mocks.dart';

void main() {
  test("Can handle empty responses", () async {
    final container = ProviderContainer.test(
      overrides: [
        apiServiceProvider.overrideWith((ref) {
          return MockApiService();
        }),
      ],
    );

    final apiServiceMock = container.read(apiServiceProvider);
    final category = "general";

    when(apiServiceMock.getArticlesWithinCategory(category))
      .thenAnswer((_) async => []);

    final result = await container.read(articleRepositoryProvider).getArticlesWithinCategory(category);

    expect(result, isA<List>());
    expect(result, isEmpty);
  });
}