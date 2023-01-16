import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_test_base/core/enum/view_state.dart';

final viewStateProvider = StateProvider<ViewState>((ref) => ViewState.failure);
