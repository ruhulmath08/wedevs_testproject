part of 'home_tab_bloc.dart';

class HomeTabState extends Equatable {
  const HomeTabState({
    this.productList = const [],
    this.productFilterOptions = const [],
    this.fetchJsonDataState = FetchJsonDataState.initialState,
  });

  final List<ProductModel> productList;
  final List<ProductFilterModel> productFilterOptions;
  final FetchJsonDataState fetchJsonDataState;

  HomeTabState copyWith({
    List<ProductModel>? productList,
    List<ProductFilterModel>? productFilterOptions,
    FetchJsonDataState? fetchJsonDataState,
  }) {
    return HomeTabState(
      productList: productList ?? this.productList,
      productFilterOptions: productFilterOptions ?? this.productFilterOptions,
      fetchJsonDataState: fetchJsonDataState ?? this.fetchJsonDataState,
    );
  }

  @override
  List<Object?> get props => [productList, productFilterOptions, fetchJsonDataState];
}
