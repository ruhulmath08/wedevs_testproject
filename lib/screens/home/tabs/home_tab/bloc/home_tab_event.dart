part of 'home_tab_bloc.dart';

class HomeTabEvent extends Equatable {
  const HomeTabEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllProducts extends HomeTabEvent {}

class FetchFilterOptions extends HomeTabEvent {
  final List<ProductFilterModel> productFilterOptions;

  const FetchFilterOptions({required this.productFilterOptions});

  @override
  List<Object> get props => [productFilterOptions];
}


class FetchApplyButton extends HomeTabEvent {}
