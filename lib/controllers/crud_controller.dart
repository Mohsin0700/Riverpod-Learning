import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learning/services/remote_service.dart';

class CrudController extends StateNotifier<List> {
  CrudController() : super([]);

  void getCrud() async {
    state = await RemoteService.getData();
  }

  void postCrud(String unicornName) async {
    try {
      final response = await RemoteService.postData({
        "name": unicornName,
        "age": '4',
        "color": 'red',
      });
      if (response != null) {
        state = [...state, response];
      }
    } catch (e) {
      print('postCrud error: $e');
      rethrow;
    }
  }
}

final crudControllerProvider = StateNotifierProvider<CrudController, List>((
  ref,
) {
  return CrudController();
});
