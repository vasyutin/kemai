# Kemai Developer Guide

## Quick Start

### Build Commands

```powershell
# Windows (with preset)
cmake --preset release-win
cmake --build cmake-build-release-win --config Release

# macOS
cmake --preset release-macos
cmake --build cmake-build-release-macos --config Release

# Debug builds use `debug-win` or `debug` presets
```

### Prerequisites
- **CMake 3.21+** required (per `CMakePresets.json`)
- **Qt 6.7.2** (or Qt 5 fallback)
- **OpenSSL** on Windows (bundled by installer)
- MSVC 2019 64-bit on Windows

### Platform-Specific Notes

| Platform | Build Preset | Notes |
|----------|-------------|-------|
| Windows | `release-win` | Auto-bundles Qt, OpenSSL, generates WiX installer |
| macOS | `release-macos` | Creates DMG; disable updates with `release-macos-noupdate` |
| Linux | Manual | Installs `.desktop` file and icon to system paths |

## Architecture

### Entry Point
- **Main**: `src/main.cpp:43` - Initializes Qt app, logging (spdlog), translations, and shows `MainWindow`

### Key Components
- `client/` - Kimai API communication (`kimaiClient`, `kimaiAPI`)
- `context/` - `KemaiSession` manages active session + events monitor
- `gui/` - QtWidgets UI (main window, dialogs, widgets)
- `models/` - Data models for QML/View binding
- `monitor/` - OS-specific desktop event handling (Windows/macOS/Linux)
- `settings/` - Profile management (host, credentials, session)
- `updater/` - GitHub release update checking

### Dependencies (auto-fetched by CMake)
- **fmt 10.2.1** - Formatting
- **magic_enum v0.9.5** - Reflection
- **spdlog v1.14.0** - Logging
- **range-v3 0.12.0** - Range utilities

## Workflow Conventions

### Branch Strategy
- **Always develop on `develop`** - PRs merge to `develop`, not `master`
- **Changelog**: See `CHANGELOG.md` for release notes format

### Code Style
- **C++20** standard required
- **Clang-Format**: Apply with root `.clang-format` before PR
  - 160 char line limit, 4-space indent, no tabs
  - Custom brace wrapping rules (see `.clang-format`)
- **Class naming**: `PascalCase` (e.g., `KimaiCache`, `KemaiSession`)

### Localization
- **Translation files**: `src/resources/l10n/*.ts`
- **Update translations**: `cmake --build . --target kemai-update-ts`
- **Weblate**: https://hosted.weblate.org/engage/kemai/

## Build Artifacts & Paths
- **Log location**: `%APPDATA%/Kemai` on Windows (via `QStandardPaths::AppDataLocation`)
- **Log file**: `kemai.log` (rotating: 3 × 5MB)
- **Version file**: Generated at `build/version.txt`

## API Authentication
Users configure API credentials in **Settings**:
- Kimai API token (separate from login credentials)
- Multiple profiles supported
- TLS trust store configurable for self-signed certs

## Testing
No automated test suite in this repository. Manual QA required for:
- Cross-platform (Windows/macOS/Linux)
- Update checks (disable with `KEMAI_ENABLE_UPDATE_CHECK=OFF`)
- Desktop event monitoring (idle/lock detection)
