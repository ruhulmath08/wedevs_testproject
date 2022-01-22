part of 'home_tab_bloc.dart';

class HomeTabEvent extends Equatable {
  const HomeTabEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllProducts extends HomeTabEvent {}

class FetchFilterModels extends HomeTabEvent {}

class FetchFilterOptionsChange extends HomeTabEvent {
  final List<ProductFilterModel> productFilterOptions;

  const FetchFilterOptionsChange({required this.productFilterOptions});

  @override
  List<Object> get props => [productFilterOptions];
}

class FetchApplyButton extends HomeTabEvent {}
