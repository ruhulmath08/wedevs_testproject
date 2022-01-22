import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedevs_testproject/constants/colores.dart';
import 'package:wedevs_testproject/constants/strings.dart';
import 'package:wedevs_testproject/constants/style.dart';
import 'package:wedevs_testproject/constants/text_style.dart';

class MyAccountTab extends StatefulWidget {
  @override
  State<MyAccountTab> createState() => _MyAccountTabState();
}

class _MyAccountTabState extends State<MyAccountTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: homeScreenAllTabPadding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                myAccount,
                style: homeScreenTabTitleStyle,
              ),
            ],
          ),
          SizedBox(height: 40.h),
          DottedBorder(
            borderType: BorderType.Circle,
            //radius: Radius.circular(52),
            padding: const EdgeInsets.all(6),
            color: profileImageDottedCircleColor,
            child: Container(
              width: 128,
              height: 128,
              //color: Colors.blue,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/profile_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'John Smith',
                style: homeScreenTabTitleStyle,
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'John Smith',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: myAccountEmailColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ExpansionPanelList.radio(
              dividerColor: Colors.grey,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (index, isExpanded) {
                final tile = myAccountContentModelData[index];
                setState(() => tile.isExpanded = isExpanded);
              },
              children: myAccountContentModelData
                  .map(
                    (tile) => ExpansionPanelRadio(
                      value: tile.title,
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          minLeadingWidth: 0,
                          visualDensity: const VisualDensity(vertical: -4),
                          leading: Icon(tile.iconData),
                          title: Text(
                            tile.title,
                          ),
                        );
                      },
                      body: const Text('Have to write expanded code'),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

final myAccountContentModelData = <MyAccountContentModel>[
  MyAccountContentModel(title: account, iconData: Icons.person),
  MyAccountContentModel(title: password, iconData: Icons.lock_outline_rounded),
  MyAccountContentModel(title: notification, iconData: Icons.notifications_none_outlined),
  MyAccountContentModel(title: wishlist, iconData: Icons.favorite_border_rounded),
];

class MyAccountContentModel {
  final String title;
  final IconData iconData;
  final List<MyAccountContentModel> titles;
  bool isExpanded;

  MyAccountContentModel({
    required this.title,
    required this.iconData,
    this.titles = const [],
    this.isExpanded = false,
  });
}
