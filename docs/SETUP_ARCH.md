# Flutter Development Environment on Arch Linux
 
A complete, battle-tested guide to setting up Flutter on Arch Linux — including every real-world problem you'll likely hit along the way and exactly how to fix them.
 
> Written from a real setup experience on Arch Linux 6.19 + Xfce. No steps were skipped, no problems were hidden.
 
---
 
## Table of Contents
 
- [Prerequisites](#prerequisites)
- [Why pacman alone is not enough](#why-pacman-alone-is-not-enough)
- [Step 1 — Installing yay (AUR helper)](#step-1--installing-yay-aur-helper)
- [Step 2 — Installing Flutter](#step-2--installing-flutter)
- [Step 3 — Fixing Flutter folder permissions](#step-3--fixing-flutter-folder-permissions)
- [Step 4 — Installing Android Studio](#step-4--installing-android-studio)
- [Step 5 — Running Android Studio for the first time](#step-5--running-android-studio-for-the-first-time)
- [Step 6 — Installing the cmdline-tools component](#step-6--installing-the-cmdline-tools-component)
- [Step 7 — Pointing Flutter to the Android SDK](#step-7--pointing-flutter-to-the-android-sdk)
- [Step 8 — Accepting Android licenses](#step-8--accepting-android-licenses)
- [Step 9 — Setting up Chrome / Chromium for web development](#step-9--setting-up-chrome--chromium-for-web-development)
- [Step 10 — Verifying everything with flutter doctor](#step-10--verifying-everything-with-flutter-doctor)
- [Setting up VS Code](#setting-up-vs-code)
- [Creating your first project](#creating-your-first-project)
- [Common problems and solutions](#common-problems-and-solutions)
- [Disk space warning](#disk-space-warning)
 
---
 
## Prerequisites
 
Before starting, make sure you have a working Arch Linux installation with:
 
- Internet connection
- A regular user account (not root)
- At least **7 GB of free disk space** — Flutter SDK + Android SDK together are large
 
---
 
## Why pacman alone is not enough
 
The official Arch repositories (`pacman`) only include packages that go through a strict review process by the Arch team. Flutter is updated very frequently by Google, so the Arch team can't keep pace with it — which is why Flutter lives in the **AUR (Arch User Repository)**, a community-maintained repository where anyone can publish a build script called a `PKGBUILD`.
 
`pacman` cannot access the AUR on its own. You need an **AUR helper** — a program that automates the process of downloading, compiling, and installing AUR packages. The most popular helpers are `yay` and `paru`.
 
> **yay vs paru:** Both work well. `paru` is written in Rust and is more modern — it asks for your sudo password once at the beginning and never again during the build, which is a big advantage when installing large packages like Android Studio that take a long time to compile. If you get frustrated with sudo timeouts during long installs, switch to `paru`.
 
---
 
## Step 1 — Installing yay (AUR helper)
 
`yay` itself is an AUR package, so you have to install it manually the first time. This is called **bootstrapping** and you only do it once.
 
First, install the tools needed to compile any AUR package:
 
```bash
sudo pacman -S --needed git base-devel
```
 
What each part means:
- `pacman -S` — the `-S` flag stands for "sync", which means install from the repositories
- `--needed` — skips packages that are already installed instead of reinstalling them
- `git` — needed to clone AUR repositories
- `base-devel` — a group of compilation tools (`gcc`, `make`, `fakeroot`, `binutils`, etc.) required to build packages from source
 
Now clone and install `yay`:
 
```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
 
What `makepkg -si` does:
- reads the `PKGBUILD` file in the current directory
- `-s` — automatically installs any missing dependencies before building
- `-i` — installs the resulting package with pacman after a successful build
 
After this, `yay` is available system-wide. You will never need to repeat this bootstrap process.
 
---
 
## Step 2 — Installing Flutter
 
There are two Flutter packages in the AUR:
 
| Package | What it does | Problem |
|---|---|---|
| `flutter` | Compiles Flutter from source on your machine | Takes hours, heavy CPU usage |
| `flutter-bin` | Downloads the pre-compiled official binary from Google | Fast, stable, recommended |
 
The `-bin` suffix in Arch always means "pre-compiled binary". Always prefer this for day-to-day use.
 
```bash
yay -S flutter-bin
```
 
`yay` works exactly like `pacman` (same flags), but before calling pacman it fetches the PKGBUILD from the AUR, compiles/packages the software, and hands it off to pacman for installation.
 
---
 
## Step 3 — Fixing Flutter folder permissions
 
Flutter is installed to `/opt/flutter/`. This directory belongs to **root** by default, which means your regular user cannot write to it. The problem is that Flutter **needs to write** to this folder to:
 
- Download the Dart SDK on first run
- Download build artifacts (binaries for Android, web, Linux)
- Update itself with `flutter upgrade`
 
The Arch package solves this by creating a **`flutter` group** during installation and granting write access to that group. You need to add your user to this group:
 
```bash
sudo usermod -aG flutter $USER
```
 
What each part means:
- `usermod` — modifies a system user
- `-a` — "append": adds the group without removing your existing groups. **Without `-a`, you would be removed from all other groups**, which would break your system
- `-G flutter` — specifies the group to add
- `$USER` — environment variable containing your current username
 
**You must log out and log back in after this.** Group membership is loaded at login time — adding a group does not take effect in your current session. The kernel still sees your session with the old groups until you start a new one.
 
---
 
## Step 4 — Installing Android Studio
 
```bash
yay -S android-studio
```
 
You might wonder: why install a full IDE just to use VS Code? Because Android Studio brings with it:
 
- **Android SDK** — the toolchain that compiles your Dart code into an APK that runs on Android
- **SDK Manager** — GUI tool to install Android API versions
- **AVD Manager** — tool to create and manage Android emulators
- **Android Emulator** — the emulator itself
 
You can install the Android SDK separately without Android Studio, but you would have to configure all the paths and environment variables manually. Letting Android Studio handle it is much more practical.
 
> **sudo timeout problem:** Android Studio is a large package and takes a long time to install. If your sudo session expires during the build, `yay` will fail and you'll have to start over. To prevent this, open a second terminal and run:
> ```bash
> sudo -v && watch -n 60 sudo -v
> ```
> This renews your sudo token every 60 seconds. Keep this terminal open until the installation finishes.
 
---
 
## Step 5 — Running Android Studio for the first time
 
**This step is mandatory.** The Android SDK is not installed together with Android Studio — it is downloaded the first time you open it through a setup wizard.
 
```bash
android-studio
```
 
When it opens, follow the wizard like this:
 
1. **"Do not import settings"** — click OK
2. **Welcome screen** — click Next
3. **Install Type** — select **Standard** and click Next. This option automatically downloads everything Flutter needs
4. **Select UI Theme** — choose whatever you prefer
5. **Verify Settings** — it will show what will be downloaded and where. The default path is `~/Android/Sdk` — **do not change this**
6. **License Agreement** — accept all licenses on each page
7. Click **Finish** and wait for the download to complete (around 1–2 GB)
 
Once the download finishes and the Android Studio home screen appears, you can close it.
 
---
 
## Step 6 — Installing the cmdline-tools component
 
After the first launch, the Android SDK is installed but one critical component is missing: **Android SDK Command-line Tools**. This package contains `sdkmanager` and `avdmanager`, which Flutter needs to manage the SDK from the terminal.
 
Open Android Studio again:
 
```bash
android-studio
```
 
In the toolbar: **More Actions → SDK Manager**
 
In the SDK Manager window:
1. Click the **"SDK Tools"** tab
2. Check **"Android SDK Command-line Tools (latest)"**
3. Click **Apply**, then **OK**
4. Wait for the installation to finish and close Android Studio
 
Without this step, `flutter doctor` will show:
```
✗ cmdline-tools component is missing.
```
even though the rest of the SDK is correctly installed.
 
---
 
## Step 7 — Pointing Flutter to the Android SDK
 
Flutter doesn't automatically know where Android Studio put the SDK. You need to tell it explicitly:
 
```bash
flutter config --android-sdk ~/Android/Sdk
```
 
This writes the SDK path to Flutter's configuration file so it persists across terminal sessions.
 
---
 
## Step 8 — Accepting Android licenses
 
Google requires you to formally accept the Android SDK license terms before using the build tools. Without this, `flutter doctor` will show a warning even with a correctly installed SDK.
 
```bash
flutter doctor --android-licenses
```
 
This command presents each license one by one. Type `y` and press Enter for each one. There are several of them — keep going until you see:
 
```
All SDK package licenses accepted.
```
 
The licenses cover:
- Android SDK License
- Android SDK Preview License
- Android SDK ARM EABI Toolchain License
- Google USB Driver License
- Intel Android Extra License
 
None of them are traps — they are standard developer usage terms.
 
---
 
## Step 9 — Setting up Chrome / Chromium for web development
 
Flutter's web development mode requires a **Chromium-based browser**. This is not an arbitrary preference — it's a technical requirement.
 
When you run `flutter run -d chrome`, Flutter communicates with the browser using the **Chrome DevTools Protocol (CDP)** to enable hot reload, debug overlays, and the Flutter DevTools inspector. Firefox uses its own DevTools protocol which is incompatible with CDP, so it cannot be used for Flutter web development.
 
> **Note:** Firefox works perfectly fine for viewing your app after `flutter build web`. The CDP requirement only applies to the development/hot reload workflow.
 
You do not need to replace Firefox as your default browser. Just install Chromium alongside it:
 
```bash
sudo pacman -S chromium
```
 
This is in the official Arch repository, so no AUR is needed.
 
Now tell Flutter to use Chromium instead of looking for `google-chrome`:
 
```bash
echo 'export CHROME_EXECUTABLE=/usr/bin/chromium' >> ~/.bashrc
source ~/.bashrc
```
 
What this does:
- `echo '...' >> ~/.bashrc` — appends the export line to your bash config file. The `>>` operator appends without overwriting. Using `>` instead would erase the entire file
- `source ~/.bashrc` — reloads the config file in the current terminal session immediately, without needing to close and reopen the terminal
- `CHROME_EXECUTABLE` — the environment variable Flutter reads to locate the browser executable
 
If you use **zsh** instead of bash, replace `.bashrc` with `.zshrc` in both commands.
 
---
 
## Step 10 — Verifying everything with flutter doctor
 
```bash
flutter doctor
```
 
You should see something like this:
 
```
[✓] Flutter (Channel stable, 3.x.x, on Arch Linux x.x.x, locale en_US.UTF-8)
[✓] Android toolchain - develop for Android devices (Android SDK version 36.x.x)
[✓] Chrome - develop for the web
[✓] Linux toolchain - develop for Linux desktop
[✓] Connected device (2 available)
[✓] Network resources
```
 
### About the eglinfo warning
 
You may see this under Linux toolchain even with a green `[✓]`:
 
```
! Unable to access driver information using 'eglinfo'.
  It is likely available from your distribution (e.g.: apt install mesa-utils)
```
 
Flutter's message says `apt install` because it was written for Ubuntu/Debian. On Arch, the package name is the same but the command is different:
 
```bash
sudo pacman -S mesa-utils
```
 
This is a **cosmetic warning only** — it does not affect building or running apps in any way. Flutter just uses `eglinfo` for diagnostic display. Your Linux desktop target already works with the green checkmark.
 
---
 
## Setting up VS Code
 
Install the Flutter extension from the Extensions panel (`Ctrl+Shift+X`):
 
- Search for **Flutter** (by Dart Code)
- Install it — the Dart extension is pulled in automatically
 
Open your project folder:
 
```bash
cd my_app
code .
```
 
To run the app, press **F5**. VS Code internally calls `flutter run` and opens a debug panel at the bottom.
 
To switch between devices (Android emulator, Chromium, Linux desktop), click the device name in the **bottom right status bar** of VS Code.
 
### Hot reload
 
This is Flutter's equivalent of a browser's live reload — but faster:
 
| Action | How to trigger |
|---|---|
| Hot reload | Save the file (`Ctrl+S`) or press `r` in the terminal |
| Hot restart | `Ctrl+Shift+F5` in VS Code, or press `R` in the terminal |
| Stop | `Ctrl+F5` in VS Code, or press `q` in the terminal |
 
**Hot reload** recompiles only what changed and injects it into the running app without losing the current state. **Hot restart** restarts the app from scratch — needed for structural changes like adding a new `StatefulWidget`.
 
---
 
## Creating your first project
 
```bash
# Create the project (use snake_case for the name)
flutter create my_app
 
# Enter the project folder
cd my_app
 
# Run on Linux desktop (fastest, no emulator needed)
flutter run -d linux
 
# Run on Chromium
flutter run -d chrome
 
# Run on Android emulator (must have one created in Android Studio AVD Manager)
flutter run -d emulator-5554
```
 
### Project structure
 
```
my_app/
├── android/        # Native Android code — don't touch this at the start
├── ios/            # Native iOS code — don't touch this at the start
├── linux/          # Native Linux desktop code
├── web/            # Web entry point
├── lib/            # Your code lives here
│   └── main.dart   # App entry point
├── test/           # Automated tests
└── pubspec.yaml    # Dependencies and assets configuration
```
 
The only files you'll work with daily are inside `lib/` and `pubspec.yaml`.
 
To add a dependency, edit `pubspec.yaml` and run:
 
```bash
flutter pub get
```
 
Or add it directly from the terminal:
 
```bash
flutter pub add package_name
```
 
---
 
## Common problems and solutions
 
### sudo expires during yay installation
 
Large packages like Android Studio take a long time to build. If sudo expires mid-install, yay fails and you have to start over.
 
**Fix:** Open a second terminal and run:
```bash
sudo -v && watch -n 60 sudo -v
```
Keep it open for the duration of the installation.
 
**Alternative:** Switch to `paru` which handles this better:
```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```
Then use `paru -S` instead of `yay -S`.
 
### flutter doctor shows "Unable to locate Android SDK"
 
This means either Android Studio was never opened (SDK was never downloaded), or Flutter doesn't know the SDK path.
 
**Fix:**
```bash
# Open Android Studio and complete the setup wizard first, then:
flutter config --android-sdk ~/Android/Sdk
```
 
### cmdline-tools component is missing
 
The SDK was installed but the command-line tools component was not.
 
**Fix:** Open Android Studio → More Actions → SDK Manager → SDK Tools tab → check "Android SDK Command-line Tools (latest)" → Apply.
 
### Chrome executable not found
 
Flutter looks for `google-chrome` but you have Chromium installed.
 
**Fix:**
```bash
echo 'export CHROME_EXECUTABLE=/usr/bin/chromium' >> ~/.bashrc
source ~/.bashrc
```
 
### Permission denied in /opt/flutter
 
Your user is not in the `flutter` group, or you haven't logged out since being added.
 
**Fix:**
```bash
sudo usermod -aG flutter $USER
# Log out and log back in
```
 
### flutter upgrade fails with permission error
 
Same root cause as above — missing group membership.
 
---
 
## Disk space warning
 
Before starting, make sure you have enough free space:
 
| Component | Approximate size |
|---|---|
| Flutter SDK | ~1.5 GB |
| Android SDK | ~3.5 GB |
| Android Studio | ~1.5 GB |
| Chromium | ~300 MB |
| **Total** | **~7 GB** |
 
Check available space with:
```bash
df -h ~
```
 
---
 
*Guide written based on a real Arch Linux setup experience. All problems documented here were encountered and solved during actual installation.*
