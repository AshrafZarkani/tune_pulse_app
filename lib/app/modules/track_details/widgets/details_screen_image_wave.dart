
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/modules/track_details/widgets/audio_wave.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/models/track_model.dart';

class TrackDetailsImageWaveAnimation extends StatelessWidget {
  const TrackDetailsImageWaveAnimation({
    super.key,
    required this.track,
  });

  final Track track;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 31.h,
      child: Stack(
        children: [
          const AudioWaveAnimation(),
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
    );
  }
}