import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedevs_testproject/constants/enum.dart';
import 'package:wedevs_testproject/models/product_filter_model.dart';
import 'package:wedevs_testproject/models/product_list.dart';

part 'home_tab_event.dart';
part 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc() : super(const HomeTabState());

  @override
  Stream<HomeTabState> mapEventToState(HomeTabEvent event) async* {
    if (event is FetchAllProducts) {
      yield* _mapFetchAllProductsToState(event, state);
    } else if (event is FetchFilterOptions) {
      yield* _mapFetchFilterOptionsToState(event, state);
    } else if (event is FetchApplyButton) {
      yield* _mapFetchApplyButtonToState(event, state);
    }
  }

  Stream<HomeTabState> _mapFetchAllProductsToState(FetchAllProducts event, HomeTabState state) async* {
    yield state.copyWith(fetchJsonDataState: FetchJsonDataState.fetchJsonData);
    try {
      //load json data from JSON file
      final String response = await rootBundle.loadString('assets/json/product_list_json.json');
      final List<dynamic> jsonData = json.decode(response) as List<dynamic>;
      final List<ProductList> productLists = [];
      for (int i = 0; i <= jsonData.length - 1; i++) {
        productLists.add(ProductList.fromJson(jsonData[i] as Map<String, dynamic>));
      }

      yield state.copyWith(fetchJsonDataState: FetchJsonDataState.fetchJsonDataSuccess, productList: productLists);
    } catch (e) {
      log('Error  from: $runtimeType -> _mapFetchAllProductsToState() : ${e.toString()}');
      yield state.copyWith(fetchJsonDataState: FetchJsonDataState.fetchJsonDataFailed);
    }
  }

  Stream<HomeTabState> _mapFetchFilterOptionsToState(FetchFilterOptions event, HomeTabState state) async* {
    state.copyWith(productFilterOptions: event.productFilterOptions);
  }

  Stream<HomeTabState> _mapFetchApplyButtonToState(FetchApplyButton event, HomeTabState state) async* {}
}
