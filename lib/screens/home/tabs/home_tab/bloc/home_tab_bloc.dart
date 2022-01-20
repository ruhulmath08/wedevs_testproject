import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedevs_testproject/models/product_filter_model.dart';
import 'package:wedevs_testproject/models/product_list.dart';

part 'home_tab_event.dart';
part 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc() : super(HomeTabState());

  @override
  Stream<HomeTabState> mapEventToState(HomeTabEvent event) async* {}
}
