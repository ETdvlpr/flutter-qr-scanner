import 'package:get_storage/get_storage.dart';
import 'package:scanner/core/adapters/repository_adapter.dart';
import 'package:scanner/core/models/freezed_models.dart';
import 'package:scanner/core/services/api/api_client.dart';
import 'package:scanner/utils/constants.dart';

/*
  Implementation for Home api requests
*/
class HomeRepository implements IHomeRepository {
  HomeRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<void> addScannedItem(ScannedItem item) async {
    final box = GetStorage();
    List<ScannedItem> items = box.read(kScannedItemBoxName) ?? [];
    items.add(item);
    box.write(kScannedItemBoxName, items);
  }

  @override
  Future<List<ScannedItem>> getScannedItems() async {
    final box = GetStorage();
    List<ScannedItem> items = box.read(kScannedItemBoxName) ?? [];
    return items;
  }
}
