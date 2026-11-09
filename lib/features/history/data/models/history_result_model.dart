import 'package:plotline_mobile/features/history/data/models/history_model.dart';
import 'package:plotline_mobile/features/history/domain/entity/history_result_entity.dart';

class HistoryResultModel extends HistoryResultEntity {
  HistoryResultModel({required super.items, required super.hasMore});

  factory HistoryResultModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>;

    return HistoryResultModel(
      items: data
          .map(
            (item) =>
                HistoryModel.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList(),
      hasMore: json['hasMore'] as bool,
    );
  }
}
