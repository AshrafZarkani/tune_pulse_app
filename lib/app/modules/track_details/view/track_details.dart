import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/details_control_buttons.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/details_screen_appbar.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/details_screen_image_wave.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/song_artist_name.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/track_details_button_bar.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/track_slder_timer.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

class TrackDetails extends ConsumerStatefulWidget {
  const TrackDetails({Key? key, required this.track}) : super(key: key);

  final Track track;

  @override
  ConsumerState<TrackDetails> createState() => _TrackDetailsState();
}

class _TrackDetailsState extends ConsumerState<TrackDetails> {
  @override
  void initState() {
    super.initState();

    // Initialize music player after first frame for smoother rendering
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final url = widget.track.preview;
      if (url.isNotEmpty) {
        if (context.mounted) {
          if (ref.watch(playMusicNotifierProvider.notifier).isLoaded == false) {
            ref
                .read(playMusicNotifierProvider.notifier)
                .init(url, ref); // Load music if not already loaded
          }
        }
      }
    });
  }

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
                  widget.track.artist.pictureMedium,
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
                  TrackDetailsImageWaveAnimation(track: widget.track),
                  const Spacer(
                    flex: 1,
                  ),
                  const TrackDetailsButtonBar(),
                  const Spacer(
                    flex: 2,
                  ),
                  SDetailsSongAndArtistName(track: widget.track),
                  const Spacer(
                    flex: 4,
                  ),
                  TrackTimerSlider(track: widget.track),
                  const Spacer(
                    flex: 3,
                  ),
                  SDetailsControlButtons(track: widget.track),
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
