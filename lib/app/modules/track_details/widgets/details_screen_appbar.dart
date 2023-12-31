import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';
import 'package:tune_pulse/app/modules/shared/custom_appbar.dart';
import 'package:tune_pulse/app/modules/shared/search_button.dart';
import 'package:tune_pulse/app/modules/tracklist_view/domain/providers/tracklist_providers.dart';

class TrackDetailesScreenAppBar extends StatelessWidget {
  const TrackDetailesScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: Consumer(builder: (_, ref, __) {
        final musicController = ref.read(playMusicNotifierProvider.notifier);

        return CustomAppBar(
          appBarTitle: context.translate.nowPlaying,
          leadingTrue: true,
          leadingCallBack: () {
            musicController.onStop();
            context.pop(true);
          },
          backgroundColor: Colors.transparent,
          centerTitle: true,
          actions: const [SearchButton()],
        );
      }),
    );
  }
}
