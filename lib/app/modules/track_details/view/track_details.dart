import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/details_control_buttons.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/details_screen_appbar.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/details_screen_image_wave.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/song_artist_name.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/track_details_button_bar.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/track_slder_timer.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';

class TrackDetails extends StatelessWidget {
  const TrackDetails({Key? key, required this.track}) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.h,
        child: Stack(
          fit: StackFit.loose,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.3), BlendMode.dstATop),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Image.network(
                  track.artist.pictureMedium,
                  height: 100.h,
                  width: 100.h,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const TrackDetailesScreenAppBar(),
                  const Spacer(),
                  TrackDetailsImageWaveAnimation(track: track),
                  const Spacer(
                    flex: 1,
                  ),
                  const TrackDetailsButtonBar(),
                  const Spacer(
                    flex: 2,
                  ),
                  SDetailsSongAndArtistName(track: track),
                  const Spacer(
                    flex: 4,
                  ),
                  TrackTimerSlider(track: track),
                  const Spacer(
                    flex: 3,
                  ),
                  SDetailsControlButtons(track: track),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


