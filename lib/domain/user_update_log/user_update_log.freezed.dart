// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_update_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserUpDateLog _$UserUpDateLogFromJson(Map<String, dynamic> json) {
  return _UserUpDateLog.fromJson(json);
}

/// @nodoc
mixin _$UserUpDateLog {
  dynamic get updatedAt => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userImageURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserUpDateLogCopyWith<UserUpDateLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserUpDateLogCopyWith<$Res> {
  factory $UserUpDateLogCopyWith(
          UserUpDateLog value, $Res Function(UserUpDateLog) then) =
      _$UserUpDateLogCopyWithImpl<$Res, UserUpDateLog>;
  @useResult
  $Res call({dynamic updatedAt, String userName, String userImageURL});
}

/// @nodoc
class _$UserUpDateLogCopyWithImpl<$Res, $Val extends UserUpDateLog>
    implements $UserUpDateLogCopyWith<$Res> {
  _$UserUpDateLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = freezed,
    Object? userName = null,
    Object? userImageURL = null,
  }) {
    return _then(_value.copyWith(
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserUpDateLogCopyWith<$Res>
    implements $UserUpDateLogCopyWith<$Res> {
  factory _$$_UserUpDateLogCopyWith(
          _$_UserUpDateLog value, $Res Function(_$_UserUpDateLog) then) =
      __$$_UserUpDateLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic updatedAt, String userName, String userImageURL});
}

/// @nodoc
class __$$_UserUpDateLogCopyWithImpl<$Res>
    extends _$UserUpDateLogCopyWithImpl<$Res, _$_UserUpDateLog>
    implements _$$_UserUpDateLogCopyWith<$Res> {
  __$$_UserUpDateLogCopyWithImpl(
      _$_UserUpDateLog _value, $Res Function(_$_UserUpDateLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = freezed,
    Object? userName = null,
    Object? userImageURL = null,
  }) {
    return _then(_$_UserUpDateLog(
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserUpDateLog implements _UserUpDateLog {
  const _$_UserUpDateLog(
      {required this.updatedAt,
      required this.userName,
      required this.userImageURL});

  factory _$_UserUpDateLog.fromJson(Map<String, dynamic> json) =>
      _$$_UserUpDateLogFromJson(json);

  @override
  final dynamic updatedAt;
  @override
  final String userName;
  @override
  final String userImageURL;

  @override
  String toString() {
    return 'UserUpDateLog(updatedAt: $updatedAt, userName: $userName, userImageURL: $userImageURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserUpDateLog &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImageURL, userImageURL) ||
                other.userImageURL == userImageURL));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(updatedAt), userName, userImageURL);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserUpDateLogCopyWith<_$_UserUpDateLog> get copyWith =>
      __$$_UserUpDateLogCopyWithImpl<_$_UserUpDateLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserUpDateLogToJson(
      this,
    );
  }
}

abstract class _UserUpDateLog implements UserUpDateLog {
  const factory _UserUpDateLog(
      {required final dynamic updatedAt,
      required final String userName,
      required final String userImageURL}) = _$_UserUpDateLog;

  factory _UserUpDateLog.fromJson(Map<String, dynamic> json) =
      _$_UserUpDateLog.fromJson;

  @override
  dynamic get updatedAt;
  @override
  String get userName;
  @override
  String get userImageURL;
  @override
  @JsonKey(ignore: true)
  _$$_UserUpDateLogCopyWith<_$_UserUpDateLog> get copyWith =>
      throw _privateConstructorUsedError;
}
