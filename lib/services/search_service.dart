// TODO: Implement a mock search service
// Requirements:
// - Create a class that simulates fetching data with a delay
// - Implement a searchProducts method that returns a Future<List<String>>
// - Return an empty list for empty queries
// - Simulate a short delay (500ms)

import 'dart:async';

class SearchService {

  Future<List<String>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (query.toLowerCase() == "error") {
      throw Exception("Simulated search error.");
    }

    final results = List<String>.generate(
      10,
          (index) => 'Result for "$query" #$index',
    );

    return results.isEmpty ? [] : results;
  }
}
