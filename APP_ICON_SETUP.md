# App Icon Setup Guide

## Using Your Custom App Icon

Your app icon (logo.png) has been configured to replace the default Flutter icons.

## Setup Steps

1. **Install the flutter_launcher_icons package** (already added to pubspec.yaml):
   ```bash
   flutter pub get
   ```

2. **Generate app icons**:
   ```bash
   flutter pub run flutter_launcher_icons
   ```

This will automatically:
- Generate all required icon sizes for Android (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)
- Generate all required icon sizes for iOS (all @1x, @2x, @3x variants)
- Replace the default Flutter icons with your logo.png

## Icon Requirements

- **Source Image**: `assets/static/App/logo.png`
- **Recommended Size**: 1024x1024 pixels (square)
- **Format**: PNG with transparency support

## Manual Setup (Alternative)

If you prefer to set icons manually:

### Android
Replace icons in:
- `android/app/src/main/res/mipmap-*/ic_launcher.png`
- Sizes needed:
  - mdpi: 48x48
  - hdpi: 72x72
  - xhdpi: 96x96
  - xxhdpi: 144x144
  - xxxhdpi: 192x192

### iOS
Replace icons in:
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- Multiple sizes required (see Contents.json for details)

## After Setup

1. Clean the build:
   ```bash
   flutter clean
   ```

2. Rebuild the app:
   ```bash
   flutter run
   ```

Your custom app icon will now appear on the device home screen!

