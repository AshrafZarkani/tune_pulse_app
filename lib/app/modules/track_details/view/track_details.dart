import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';
import 'package:tune_pulse/app/modules/shared/custom_appbar.dart';
import 'package:tune_pulse/app/modules/shared/search_button.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/audio_wave.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/details_control_buttons.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/song_artist_name.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/track_details_button_bar.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/track_slder_timer.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Consumer(builder: (_, ref, __) {
                      final musicController =
                          ref.read(playMusicNotifierProvider.notifier);

                      return CustomAppBar(
                        appBarTitle: context.translate.nowPlaying,
                        leadingTrue: true,
                        leadingCallBack: () {
                          musicController.onStop();
                          context.pop();
                        },
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        actions: const [SearchButton()],
                      );
                    }),
                  ),
                  const Spacer(),
                  Container(
                    width: 100.w,
                    height: 31.h,
                    child: Stack(
                      children: [
                        const AudioWave(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.h),
                          child: ClipOval(
                            child: SizedBox(
                              height: 30.h,
                              width: 30.h,
                              child: Image.network(
                                track.artist.pictureMedium,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
