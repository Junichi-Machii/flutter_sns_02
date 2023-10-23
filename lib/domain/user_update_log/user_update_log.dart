import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_update_log.freezed.dart';
part 'user_update_log.g.dart';

@freezed
abstract class UserUpDateLog with _$UserUpDateLog {
  const factory UserUpDateLog({
    required dynamic updatedAt,
    required String userName,
    required String userImageURL,
  }) = _UserUpDateLog;
  factory UserUpDateLog.fromJson(Map<String, dynamic> json) =>
      _$UserUpDateLogFromJson(json);
}
