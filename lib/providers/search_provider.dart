import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../services/search_service.dart';

enum SearchState {
  initial,
  loading,
  success,
  error,
  empty,
}

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService;
  final BehaviorSubject<String> _querySubject = BehaviorSubject<String>();
  late final StreamSubscription<List<String>> _subscription;

  SearchState _state = SearchState.initial;
  SearchState get state => _state;

  List<String> _results = [];
  List<String> get results => _results;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  SearchProvider({SearchService? searchService})
      : _searchService = searchService ?? SearchService() {
    _subscription = _querySubject
        .debounceTime(const Duration(milliseconds: 300))
        .distinct()
        .switchMap<List<String>>((query) {
      if (query.isEmpty) {
        _updateState(SearchState.initial);
        return Stream.value([]);
      }

      _updateState(SearchState.loading);
      return Stream.fromFuture(_searchService.searchProducts(query))
          .doOnError((e, _) => _updateState(SearchState.error))
          .onErrorReturn(<String>[])
          .cast<List<String>>();
    }).listen((data) {
      if (_state != SearchState.error) {
        if (data.isEmpty) {
          _updateState(SearchState.empty);
        } else {
          _results = data;
          _updateState(SearchState.success);
        }
      }

      notifyListeners();
    });
  }

  void search(String query) {
    _querySubject.add(query);
  }

  void _updateState(SearchState newState) {
    _state = newState;
    if (newState == SearchState.error) {
      _errorMessage = "An error occurred while searching.";
    } else {
      _errorMessage = null;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _querySubject.close();
    _subscription.cancel();
    super.dispose();
  }
}
