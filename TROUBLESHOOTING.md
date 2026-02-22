# Troubleshooting Guide

## Flutter Local Network Permission Error

### Error Message
```
Flutter could not access the local network.
SocketException: Send failed (OS Error: No route to host, errno = 65)
```

### Solution 1: Grant Local Network Permission (Recommended)

1. **Open System Settings**
   - Click the Apple menu → System Settings (or System Preferences on older macOS)

2. **Navigate to Privacy & Security**
   - Go to **Privacy & Security** → **Local Network**

3. **Grant Permission**
   - Find your IDE (Cursor, VS Code, Android Studio, etc.)
   - Toggle the switch to **ON** (green)
   - Also enable for **Terminal** if you're using command line

4. **Restart Your IDE**
   - Close and reopen Cursor/VS Code/Android Studio
   - Try running Flutter again

### Solution 2: Grant Permission via Terminal

If the above doesn't work, you can also grant permission via Terminal:

```bash
# Check current permissions
tccutil reset LocalNetwork

# Then grant permission through System Settings as described above
```

### Solution 3: Run Flutter with Network Permission

If you're running from terminal, you might need to:

```bash
# Make sure you're in the project directory
cd /Users/apple/StudioProjects/hotel_app

# Try running with explicit permissions
flutter run
```

### Solution 4: Check Firewall Settings

1. Go to **System Settings** → **Network** → **Firewall**
2. Make sure firewall isn't blocking Flutter
3. If needed, add Flutter/Dart to allowed apps

### Solution 5: Reset Flutter

If permissions are granted but still not working:

```bash
# Clean Flutter
flutter clean

# Get dependencies
flutter pub get

# Try running again
flutter run
```

### Solution 6: Use Physical Device Instead

If you're trying to run on a simulator/emulator, try:
- Using a physical device via USB
- Or ensure the simulator has proper network access

### Common Causes

1. **First time running Flutter** - macOS requires explicit permission
2. **IDE not granted permission** - Cursor/VS Code needs local network access
3. **Terminal not granted permission** - If running from terminal
4. **Firewall blocking** - macOS firewall might be blocking connections

### Verification

After granting permissions, verify with:

```bash
flutter doctor -v
```

This will show if Flutter can properly connect to devices.

### Still Having Issues?

1. **Restart your Mac** - Sometimes permissions need a full restart
2. **Check Flutter installation**: `flutter doctor`
3. **Update Flutter**: `flutter upgrade`
4. **Check for macOS updates** - Sometimes system updates fix permission issues

