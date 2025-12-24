// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vision_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VisionState {

 XFile? get selectedImage; Uint8List? get selectedImageBytes; List<String> get identifiedIngredients; bool get isLoading; String? get error;
/// Create a copy of VisionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisionStateCopyWith<VisionState> get copyWith => _$VisionStateCopyWithImpl<VisionState>(this as VisionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisionState&&(identical(other.selectedImage, selectedImage) || other.selectedImage == selectedImage)&&const DeepCollectionEquality().equals(other.selectedImageBytes, selectedImageBytes)&&const DeepCollectionEquality().equals(other.identifiedIngredients, identifiedIngredients)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,selectedImage,const DeepCollectionEquality().hash(selectedImageBytes),const DeepCollectionEquality().hash(identifiedIngredients),isLoading,error);

@override
String toString() {
  return 'VisionState(selectedImage: $selectedImage, selectedImageBytes: $selectedImageBytes, identifiedIngredients: $identifiedIngredients, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $VisionStateCopyWith<$Res>  {
  factory $VisionStateCopyWith(VisionState value, $Res Function(VisionState) _then) = _$VisionStateCopyWithImpl;
@useResult
$Res call({
 XFile? selectedImage, Uint8List? selectedImageBytes, List<String> identifiedIngredients, bool isLoading, String? error
});




}
/// @nodoc
class _$VisionStateCopyWithImpl<$Res>
    implements $VisionStateCopyWith<$Res> {
  _$VisionStateCopyWithImpl(this._self, this._then);

  final VisionState _self;
  final $Res Function(VisionState) _then;

/// Create a copy of VisionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedImage = freezed,Object? selectedImageBytes = freezed,Object? identifiedIngredients = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
selectedImage: freezed == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as XFile?,selectedImageBytes: freezed == selectedImageBytes ? _self.selectedImageBytes : selectedImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,identifiedIngredients: null == identifiedIngredients ? _self.identifiedIngredients : identifiedIngredients // ignore: cast_nullable_to_non_nullable
as List<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VisionState].
extension VisionStatePatterns on VisionState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisionState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisionState value)  $default,){
final _that = this;
switch (_that) {
case _VisionState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisionState value)?  $default,){
final _that = this;
switch (_that) {
case _VisionState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( XFile? selectedImage,  Uint8List? selectedImageBytes,  List<String> identifiedIngredients,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisionState() when $default != null:
return $default(_that.selectedImage,_that.selectedImageBytes,_that.identifiedIngredients,_that.isLoading,_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( XFile? selectedImage,  Uint8List? selectedImageBytes,  List<String> identifiedIngredients,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VisionState():
return $default(_that.selectedImage,_that.selectedImageBytes,_that.identifiedIngredients,_that.isLoading,_that.error);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( XFile? selectedImage,  Uint8List? selectedImageBytes,  List<String> identifiedIngredients,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VisionState() when $default != null:
return $default(_that.selectedImage,_that.selectedImageBytes,_that.identifiedIngredients,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VisionState implements VisionState {
  const _VisionState({this.selectedImage, this.selectedImageBytes, final  List<String> identifiedIngredients = const [], this.isLoading = false, this.error}): _identifiedIngredients = identifiedIngredients;
  

@override final  XFile? selectedImage;
@override final  Uint8List? selectedImageBytes;
 final  List<String> _identifiedIngredients;
@override@JsonKey() List<String> get identifiedIngredients {
  if (_identifiedIngredients is EqualUnmodifiableListView) return _identifiedIngredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_identifiedIngredients);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of VisionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisionStateCopyWith<_VisionState> get copyWith => __$VisionStateCopyWithImpl<_VisionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisionState&&(identical(other.selectedImage, selectedImage) || other.selectedImage == selectedImage)&&const DeepCollectionEquality().equals(other.selectedImageBytes, selectedImageBytes)&&const DeepCollectionEquality().equals(other._identifiedIngredients, _identifiedIngredients)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,selectedImage,const DeepCollectionEquality().hash(selectedImageBytes),const DeepCollectionEquality().hash(_identifiedIngredients),isLoading,error);

@override
String toString() {
  return 'VisionState(selectedImage: $selectedImage, selectedImageBytes: $selectedImageBytes, identifiedIngredients: $identifiedIngredients, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VisionStateCopyWith<$Res> implements $VisionStateCopyWith<$Res> {
  factory _$VisionStateCopyWith(_VisionState value, $Res Function(_VisionState) _then) = __$VisionStateCopyWithImpl;
@override @useResult
$Res call({
 XFile? selectedImage, Uint8List? selectedImageBytes, List<String> identifiedIngredients, bool isLoading, String? error
});




}
/// @nodoc
class __$VisionStateCopyWithImpl<$Res>
    implements _$VisionStateCopyWith<$Res> {
  __$VisionStateCopyWithImpl(this._self, this._then);

  final _VisionState _self;
  final $Res Function(_VisionState) _then;

/// Create a copy of VisionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedImage = freezed,Object? selectedImageBytes = freezed,Object? identifiedIngredients = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_VisionState(
selectedImage: freezed == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as XFile?,selectedImageBytes: freezed == selectedImageBytes ? _self.selectedImageBytes : selectedImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,identifiedIngredients: null == identifiedIngredients ? _self._identifiedIngredients : identifiedIngredients // ignore: cast_nullable_to_non_nullable
as List<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
