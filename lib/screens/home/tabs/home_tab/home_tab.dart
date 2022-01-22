import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as image;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedevs_testproject/constants/colores.dart';
import 'package:wedevs_testproject/constants/strings.dart';
import 'package:wedevs_testproject/constants/style.dart';
import 'package:wedevs_testproject/constants/text_style.dart';
import 'package:wedevs_testproject/models/product_filter_model.dart';
import 'package:wedevs_testproject/models/product_model.dart';
import 'package:wedevs_testproject/screens/home/tabs/home_tab/bloc/home_tab_bloc.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: homeScreenAllTabPadding,
      child: Column(
        children: [
          _ProductListWithSearch(),
          SizedBox(height: 30.h),
          _SortAndFilterBar(),
          SizedBox(height: 30.h),
          const Expanded(
            child: ProductCartContainer(),
          ),
        ],
      ),
    );
  }
}

class ProductCartContainer extends StatelessWidget {
  const ProductCartContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeTabBloc>().add(FetchAllProducts());
    return BlocBuilder<HomeTabBloc, HomeTabState>(
      buildWhen: (previous, current) => previous.fetchJsonDataState != current.fetchJsonDataState,
      builder: (context, state) {
        final List<ProductModel> productLists = state.productList;
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return GridView.builder(
              itemCount: productLists.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 14.h,
                mainAxisExtent: productDetailsContainerHeight,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    log('Clicked on: ${productLists[index].name}');
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 177,
                          width: 160.42.w,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: image.Image.network(
                              productLists[index].images![0].src!,
                              height: 122.h,
                              width: 120,
                              fit: BoxFit.cover,

                              //color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productLists[index].name!,
                                  style: GoogleFonts.lato(fontSize: 16.sp, fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Text(
                                      '\$ ${productLists[index].regularPrice!}',
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w400,
                                        color: homeTabRegularPriceColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      '\$ ${productLists[index].salePrice!}',
                                      style: GoogleFonts.lato(fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '${productLists[index].totalSales!.toString()} sold',
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 8.h),
                                RatingBarIndicator(
                                  rating: double.tryParse(productLists[index].averageRating!) ?? 0,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemSize: 20.r,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _ProductListWithSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            productListText,
            textAlign: TextAlign.center,
            style: homeScreenTabTitleStyle,
          ),
        ),
        Expanded(
          flex: 0,
          child: Icon(
            Icons.search_outlined,
            color: productListTextAndSearchIconColor,
            size: 22.r,
          ),
        ),
      ],
    );
  }
}

class _SortAndFilterBar extends StatefulWidget {
  @override
  State<_SortAndFilterBar> createState() => _SortAndFilterBarState();
}

class _SortAndFilterBarState extends State<_SortAndFilterBar> {
  @override
  void initState() {
    super.initState();
    context.read<HomeTabBloc>().add(FetchFilterModels());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      width: 334.w,
      height: 60.h,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 11),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _modalBottomSheetMenu(context: context),
                child: Row(
                  children: [
                    Icon(
                      Icons.list,
                      size: 16.r,
                    ),
                    SizedBox(width: 11.w),
                    Text(
                      filterText,
                      style: GoogleFonts.lato(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: filterTextColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  Text(
                    sortByText,
                    style: GoogleFonts.lato(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: filterTextColor,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 16.r,
                  ),
                  SizedBox(width: 20.w),
                  Icon(Icons.list, color: productListTextAndSearchIconColor)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenu({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: homeBottomSheetHeight,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: Container(
            padding: homeBottomSheetPadding,
            decoration: BoxDecoration(
              color: bottomSheetBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: homeBottomSheetTopLineWidth,
                      height: homeBottomSheetTopLineHeight,
                      color: homeBottomSheetTopLineColor,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      filterText,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
                BlocBuilder<HomeTabBloc, HomeTabState>(
                  buildWhen: (previous, current) => previous.productFilterOptions != current.productFilterOptions,
                  builder: (context, state) {
                    final List<ProductFilterModel> filterOptionList = state.productFilterOptions;
                    return Column(
                      children: filterOptionList
                          .map(
                            (element) => Row(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      //onChanged: (value) => context.read<HomeTabBloc>().add(FetchFilterOptionsChange(value)),
                                      //   setState(() {
                                      //     element.isChecked = value!;
                                      //   });

                                      onChanged: (value) {
                                        //we will take all the filter models
                                        List<ProductFilterModel> modelList = state.productFilterOptions;
                                        //find the required model which we check or uncheck and remove it
                                        ProductFilterModel model = element;
                                        modelList.remove(element);
                                        //change the value of check or uncheck and add the modelList
                                        model.isChecked = value!;
                                        modelList.add(model);
                                        context.read<HomeTabBloc>().add(FetchFilterOptionsChange(productFilterOptions: modelList));
                                        setState(() {});
                                      },
                                      value: element.isChecked,
                                      activeColor: bottomSheetCheckBoxColor,
                                      side: BorderSide(
                                        color: bottomSheetCheckBoxColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(element.title),
                              ],
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 90),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: const Size(155, 61),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'cancel',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 17.sp,
                            color: bottomSheetCancelButtonTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: bottomSheetApplyButtonBackgroundColor,
                          minimumSize: const Size(155, 61),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Apply',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 17.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
