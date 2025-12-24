// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipeState {

 List<Recipe> get recipes; Map<String, Product?> get nutritionInfo; bool get isLoading; String? get error;
/// Create a copy of RecipeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeStateCopyWith<RecipeState> get copyWith => _$RecipeStateCopyWithImpl<RecipeState>(this as RecipeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeState&&const DeepCollectionEquality().equals(other.recipes, recipes)&&const DeepCollectionEquality().equals(other.nutritionInfo, nutritionInfo)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(recipes),const DeepCollectionEquality().hash(nutritionInfo),isLoading,error);

@override
String toString() {
  return 'RecipeState(recipes: $recipes, nutritionInfo: $nutritionInfo, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $RecipeStateCopyWith<$Res>  {
  factory $RecipeStateCopyWith(RecipeState value, $Res Function(RecipeState) _then) = _$RecipeStateCopyWithImpl;
@useResult
$Res call({
 List<Recipe> recipes, Map<String, Product?> nutritionInfo, bool isLoading, String? error
});




}
/// @nodoc
class _$RecipeStateCopyWithImpl<$Res>
    implements $RecipeStateCopyWith<$Res> {
  _$RecipeStateCopyWithImpl(this._self, this._then);

  final RecipeState _self;
  final $Res Function(RecipeState) _then;

/// Create a copy of RecipeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recipes = null,Object? nutritionInfo = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
recipes: null == recipes ? _self.recipes : recipes // ignore: cast_nullable_to_non_nullable
as List<Recipe>,nutritionInfo: null == nutritionInfo ? _self.nutritionInfo : nutritionInfo // ignore: cast_nullable_to_non_nullable
as Map<String, Product?>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeState].
extension RecipeStatePatterns on RecipeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeState value)  $default,){
final _that = this;
switch (_that) {
case _RecipeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeState value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Recipe> recipes,  Map<String, Product?> nutritionInfo,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeState() when $default != null:
return $default(_that.recipes,_that.nutritionInfo,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Recipe> recipes,  Map<String, Product?> nutritionInfo,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _RecipeState():
return $default(_that.recipes,_that.nutritionInfo,_that.isLoading,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Recipe> recipes,  Map<String, Product?> nutritionInfo,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _RecipeState() when $default != null:
return $default(_that.recipes,_that.nutritionInfo,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _RecipeState implements RecipeState {
  const _RecipeState({final  List<Recipe> recipes = const [], final  Map<String, Product?> nutritionInfo = const {}, this.isLoading = false, this.error}): _recipes = recipes,_nutritionInfo = nutritionInfo;
  

 final  List<Recipe> _recipes;
@override@JsonKey() List<Recipe> get recipes {
  if (_recipes is EqualUnmodifiableListView) return _recipes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recipes);
}

 final  Map<String, Product?> _nutritionInfo;
@override@JsonKey() Map<String, Product?> get nutritionInfo {
  if (_nutritionInfo is EqualUnmodifiableMapView) return _nutritionInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_nutritionInfo);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of RecipeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeStateCopyWith<_RecipeState> get copyWith => __$RecipeStateCopyWithImpl<_RecipeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeState&&const DeepCollectionEquality().equals(other._recipes, _recipes)&&const DeepCollectionEquality().equals(other._nutritionInfo, _nutritionInfo)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_recipes),const DeepCollectionEquality().hash(_nutritionInfo),isLoading,error);

@override
String toString() {
  return 'RecipeState(recipes: $recipes, nutritionInfo: $nutritionInfo, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$RecipeStateCopyWith<$Res> implements $RecipeStateCopyWith<$Res> {
  factory _$RecipeStateCopyWith(_RecipeState value, $Res Function(_RecipeState) _then) = __$RecipeStateCopyWithImpl;
@override @useResult
$Res call({
 List<Recipe> recipes, Map<String, Product?> nutritionInfo, bool isLoading, String? error
});




}
/// @nodoc
class __$RecipeStateCopyWithImpl<$Res>
    implements _$RecipeStateCopyWith<$Res> {
  __$RecipeStateCopyWithImpl(this._self, this._then);

  final _RecipeState _self;
  final $Res Function(_RecipeState) _then;

/// Create a copy of RecipeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recipes = null,Object? nutritionInfo = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_RecipeState(
recipes: null == recipes ? _self._recipes : recipes // ignore: cast_nullable_to_non_nullable
as List<Recipe>,nutritionInfo: null == nutritionInfo ? _self._nutritionInfo : nutritionInfo // ignore: cast_nullable_to_non_nullable
as Map<String, Product?>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
