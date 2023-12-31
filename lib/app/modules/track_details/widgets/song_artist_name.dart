
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/constants/barrel_constants.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';


class SDetailsSongAndArtistName extends StatelessWidget {
  const SDetailsSongAndArtistName({
    super.key,
    required this.track,
  });

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          track.titleShort,
          style: context.textTheme.titleMedium?.copyWith(
            color: MyColors.othersWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          track.artist.name,
          style: context.textTheme.bodySmall?.copyWith(
            color: MyColors.othersWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
