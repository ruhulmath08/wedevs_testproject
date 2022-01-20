import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as image;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedevs_testproject/constants/colores.dart';
import 'package:wedevs_testproject/constants/strings.dart';
import 'package:wedevs_testproject/constants/style.dart';
import 'package:wedevs_testproject/models/product_filter_model.dart';
import 'package:wedevs_testproject/models/product_list.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(
          'assets/json/product_list_json.json',
        ),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<dynamic> jsonData = json.decode(snapshot.data!) as List<dynamic>;
          final List<ProductList> productLists = [];
          for (int i = 0; i <= jsonData.length - 1; i++) {
            productLists.add(ProductList.fromJson(jsonData[i] as Map<String, dynamic>));
          }
          return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return Column(
                children: [
                  SizedBox(height: 30.h),
                  _ProductListWithSearch(),
                  SizedBox(height: 30.h),
                  _SortAndFilterBar(),
                  SizedBox(height: 30.h),
                  Expanded(
                    child: GridView.builder(
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
                                Container(
                                  height: 177,
                                  width: 160.42.w,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: image.Image.network(
                                      productLists[index].images![0].src!,
                                      height: 122,
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
                                        Row(
                                          children: [
                                            Text('\$ ${productLists[index].regularPrice!}'),
                                            const SizedBox(width: 20),
                                            Text('\$ ${productLists[index].salePrice!}'),
                                          ],
                                        ),
                                        Text(
                                          '${productLists[index].totalSales!.toString()} sold',
                                          textAlign: TextAlign.left,
                                        ),
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
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
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
            style: GoogleFonts.roboto(
              fontSize: 23.sp,
              fontWeight: FontWeight.w700,
              color: productListTextAndSearchIconColor,
            ),
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
                onTap: () => _modalBottomSheetMenu(context),
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

  void _modalBottomSheetMenu(BuildContext context) {
    List<ProductFilterModel> productFilterCategory = ProductFilterModel.fetchAll();
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
                //SizedBox(height: 70.h),
                Column(
                  children: productFilterCategory
                      .map(
                        (element) => Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  onChanged: (value) {
                                    setState(() {
                                      element.isChecked = value!;
                                    });
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
                ),
                const SizedBox(height: 90),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(155, 61),
                        ),
                        onPressed: () {},
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
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: bottomSheetApplyButtonBackgroundColor,
                          minimumSize: Size(155, 61),
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

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
