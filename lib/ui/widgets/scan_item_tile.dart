import 'package:flutter/material.dart';
import 'package:scanner/core/models/freezed_models.dart';

class ScannedItemListItem extends StatelessWidget {
  final ScannedItem item;
  final bool isHighlighted;
  final void Function()? onTap;

  const ScannedItemListItem({
    super.key,
    required this.item,
    this.isHighlighted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isHighlighted ? Colors.yellow[100] : Colors.white,
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          item.gtin!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          'Scanned on: ${_formatScanTime(item.scanTime!)}',
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        trailing: item.description?.isNotEmpty ?? false
            ? const Icon(Icons.info)
            : null,
      ),
    );
  }

  String _formatScanTime(DateTime scanTime) {
    return '${scanTime.year}-${scanTime.month}-${scanTime.day} ${scanTime.hour}:${scanTime.minute}';
  }
}
