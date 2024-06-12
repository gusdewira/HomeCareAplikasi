import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  final StateNotifierProviderRef
      ref; // if you want to use ref inside this provider
  AppStateNotifier(this.ref) : super(AppState());

  List<int> visited = [];

  void navigateTo(int index) {
    state = state.copyWith(page: index);

    if (!visited.contains(index)) {}
  }
}

class AppState {
  final int page;

  AppState({this.page = 2});

  AppState copyWith({int? page}) {
    return AppState(
      page: page ?? this.page,
    );
  }
}

final appStateProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier(ref);
});
