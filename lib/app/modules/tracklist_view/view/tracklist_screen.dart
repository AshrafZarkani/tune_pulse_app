import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/core/extensions/build_context_x.dart';
import 'package:tune_pulse/app/modules/shared/search_button.dart';
import 'package:tune_pulse/app/modules/tracklist_view/widgets/playlist_body.dart';
import 'package:tune_pulse/app/modules/shared/custom_appbar.dart';


class PLayListScreen extends StatelessWidget {
  const PLayListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        appBarTitle: context.translate.allSongs,
        actions: const [SearchButton()],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: const PlaylistBody(),
      ),
    );
  }
}


