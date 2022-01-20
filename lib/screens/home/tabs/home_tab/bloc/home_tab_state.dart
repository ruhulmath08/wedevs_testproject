part of 'home_tab_bloc.dart';

class HomeTabState extends Equatable {
  const HomeTabState({
    this.productList = const [],
    this.productFilterOptions = const [],
  });

  final List<ProductList> productList;
  final List<ProductFilterModel> productFilterOptions;

  HomeTabState copyWith({
    List<ProductList>? productList,
    List<ProductFilterModel>? productFilterOptions,
  }) {
    return HomeTabState(
      productList: productList ?? this.productList,
      productFilterOptions: productFilterOptions ?? this.productFilterOptions,
    );
  }

  @override
  List<Object?> get props => [productList, productFilterOptions];
}
