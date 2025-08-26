import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterController extends StateNotifier<int> {
  CounterController() : super(0);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}
