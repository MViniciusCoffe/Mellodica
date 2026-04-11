# Development Environment Setup
 
This document covers how to set up the Mellodica development environment from scratch.
 
---
 
## Platform-specific guides
 
Setup instructions vary significantly between operating systems. Follow the guide for your platform:
 
- [Arch Linux](SETUP_ARCH.md) — complete guide including AUR helper installation, Android Studio setup, Chromium configuration, and all real-world problems encountered during setup.
- Other platforms — coming soon.
 
---
 
## After setup
 
Once your environment is ready, clone the repository and install dependencies:
 
```bash
git clone https://github.com/your-username/Mellodica.git
cd Mellodica
flutter pub get
```
 
Then run the app:
 
```bash
# On Linux desktop (fastest for development, no emulator needed)
flutter run -d linux
 
# On Chromium (for web layout testing)
flutter run -d chrome
 
# On Android emulator
flutter run -d emulator-5554
```
 
---
 
## Verifying your setup
 
Before running the app, confirm that your Flutter environment is healthy:
 
```bash
flutter doctor
```
 
All items should show `[✓]`. If anything shows `[✗]` or `[!]`, refer to the platform-specific setup guide above.