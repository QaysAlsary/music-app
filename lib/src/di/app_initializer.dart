import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'services_locator.dart';

abstract class AppInitializer {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// dependency injection
    await ServicesLocator.setup();
    /// audio background service initialization
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );

  }
}
