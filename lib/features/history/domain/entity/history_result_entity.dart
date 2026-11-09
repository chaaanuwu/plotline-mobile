import 'package:plotline_mobile/features/history/domain/entity/history_entity.dart';

class HistoryResultEntity {
  final List<HistoryEntity> items;
  final bool hasMore;

  HistoryResultEntity({required this.items, required this.hasMore});
}
