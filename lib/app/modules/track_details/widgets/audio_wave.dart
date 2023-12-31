import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AudioWave extends StatefulWidget {
  const AudioWave({Key? key}) : super(key: key);

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  late final RecorderController recorderController;

  void _initialiseController() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;
  }

  @override
  void initState() {
    super.initState();
    _initialiseController();
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AudioWaveforms(
        enableGesture: true,
        size: Size(100.w, 50),
        recorderController: recorderController,
        waveStyle: const WaveStyle(
          waveColor: Colors.white,
          extendWaveform: true,
          showMiddleLine: false,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
