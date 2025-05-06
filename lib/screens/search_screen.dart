import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: provider.search,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Builder(
                builder: (_) {
                  switch (provider.state) {
                    case SearchState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case SearchState.error:
                      return Center(child: Text(provider.errorMessage ?? 'Error occurred'));
                    case SearchState.empty:
                      return const Center(child: Text('No results found.'));
                    case SearchState.success:
                      return ListView.separated(
                        itemCount: provider.results.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (_, index) {
                          return ListTile(
                            title: Text(provider.results[index]),
                          );
                        },
                      );
                    case SearchState.initial:
                    return const Center(child: Text('Start typing to search.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
