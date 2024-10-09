# Flutter Music Player App

## Overview

This Flutter-based music player application offers a sleek, responsive interface for browsing and playing music. It utilizes the BLoC pattern for state management, providing a smooth user experience across various devices.

## Features

- Browse and search through a music library
- Play, pause, skip, and seek within tracks
- Dynamic background color based on album art
- Responsive design for various screen sizes
- Mini player for quick access while browsing
- Background audio playback

## Tech Stack

- Flutter
- Dart
- flutter_bloc for state management
- just_audio for audio playback
- just_audio_background for background playback
- palette_generator for extracting colors from album art
- get_it for dependency injection

## Project Structure
lib/
├── bloc/
│ ├── tracks_bloc.dart
│ ├── tracks_event.dart
│ └── tracks_state.dart
├── model/
│ ├── position_info.dart
│ └── tracks_model.dart
├── presentation/
│ ├── components/
│ │ ├── additional_controls.dart
│ │ ├── controls.dart
│ │ ├── main_progress_bar.dart
│ │ ├── media_meta_data.dart
│ │ ├── mini_player.dart
│ │ ├── play_pause_button.dart
│ │ ├── progress_bar.dart
│ │ ├── track_info.dart
│ │ ├── track_list.dart
│ │ └── track_list_tile.dart
│ └── screens/
│ ├── search_screen.dart
│ ├── track_player_screen.dart
│ └── tracks_list_screen.dart
├── src/
│ ├── di/
│ │ ├── app_initializer.dart
│ │ └── services_locator.dart
│ ├── routing/
│ │ └── routes.dart
│ ├── themes/
│ │ └── app_colors.dart
│ └── util/
│ ├── app_messages.dart
│ ├── app_sizes.dart
│ └── app_toasts.dart
└── main.dart

## Setup and Installation

1. Ensure you have Flutter installed on your machine.
2. Clone the repository:
   ```
   git clone https://github.com/QaysAlsary/music-app.git
   ```
3. Navigate to the project directory:
   ```
   cd flutter-music-player
   ```
4. Install dependencies:
   ```
   flutter pub get
   ```
5. Run the app:
   ```
   flutter run
   ```

## Key Components

### TracksBloc

The central component for managing the app's state. It handles:
- Loading the music library from a JSON file
- Playing, pausing, and skipping tracks
- Updating the background color based on album art
- Searching and filtering tracks

### TrackPlayerScreen

The main screen for playing music. It displays:
- Album art
- Track information
- Playback controls
- Progress bar

### TracksListScreen

Displays the list of available tracks and includes the mini player for continuous playback while browsing.

## Initialization

The app initializes its dependencies and sets up background audio playback in the `AppInitializer` class:
