import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider()..fetchUser(userId),
      child: Scaffold(
        appBar: AppBar(title: const Text('User Profile')),
        body: Consumer<UserProvider>(
          builder: (context, provider, child) {
            switch (provider.state) {
              case UserState.loading:
                return const Center(child: CircularProgressIndicator());
              case UserState.error:
                return Center(
                  child: Text(
                    'Error: ${provider.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              case UserState.success:
                final user = provider.user!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${user.name}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text('Email: ${user.email}'),
                      const SizedBox(height: 8),
                      Text('Phone: ${user.phone}'),
                      const SizedBox(height: 8),
                      Text('Website: ${user.website}'),
                    ],
                  ),
                );
              default:
                return const Center(child: Text('Please wait...'));
            }
          },
        ),
        floatingActionButton: Consumer<UserProvider>(
          builder: (context, provider, child) => FloatingActionButton(
            onPressed: () => provider.fetchUser(userId),
            tooltip: 'Refresh',
            child: const Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
