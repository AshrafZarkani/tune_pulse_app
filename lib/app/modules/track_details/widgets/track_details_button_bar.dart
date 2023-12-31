import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/barrel_constants.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';

import 'package:tune_pulse/app/modules/shared/custom_button.dart';

class TrackDetailsButtonBar extends StatelessWidget {
  const TrackDetailsButtonBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              width: 40.w,
              child: CustomButton(
                context.translate.follow,
                height: 4.8.h,
                textIcon: const Icon(
                  Icons.favorite_border,
                  color: MyColors.othersWhite,
                ),
                buttonColor: Colors.transparent,
              )),
          SizedBox(
              width: 40.w,
              child: CustomButton(
                context.translate.shuffle,
                height: 4.8.h,
                textIcon: const Icon(
                  Icons.shuffle,
                  color: MyColors.othersWhite,
                ),
                buttonColor: MyColors.secondary_500,
                borderColor: Colors.transparent,
              )),
        ],
      ),
    );
  }
}
