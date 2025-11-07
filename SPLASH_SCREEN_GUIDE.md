# 🎬 Splash Screen Implementation

## Overview
Animated splash screen dengan SVG logo menggunakan Flutter animations dan flutter_svg package.

## File Locations
- **Main File**: `lib/features/auth/presentation/pages/splash_page.dart`
- **SVG Asset**: `assets/logos/splash.svg`
- **Route**: `/splash` (Initial location)

## Features

### 1. Animations ✨
- **Fade Animation**: Logo fade-in effect (0.0 → 1.0)
- **Scale Animation**: Logo scale effect (0.8 → 1.0)
- **Duration**: 1500ms dengan Curves.easeInOut

### 2. Layout
```
┌─────────────────────────────┐
│                             │
│       Animated Logo         │ ← SVG splash.svg
│       (FadeIn + Scale)      │
│                             │
│    Gaspi Mobile             │ ← Theme.titleLarge
│    Solusi Manajemen...      │ ← Theme.bodyLarge
│                             │
│  ⟳ Loading Indicator       │ ← Primary Color
│                             │
└─────────────────────────────┘
```

### 3. Colors Applied 🎨
- **Background**: `AppTheme.backgroundColor` (#F5F5F5)
- **App Name**: `AppTheme.primaryColor` (#099FE4)
- **Tagline**: `AppTheme.textSecondaryColor` (#757575)
- **Loading**: `AppTheme.primaryColor` (#099FE4)

### 4. Fonts Applied 📝
- **App Name**: Nunito Sans Bold
- **Tagline**: Nunito Sans Regular
- Uses `Theme.of(context).textTheme`

## Navigation Flow

```
App Start
   ↓
Splash (/splash) - 3 detik
   ↓
Auto-navigate to Login (/login)
   ↓
Post-login → Home (/home)
```

## Code Structure

```dart
class SplashPage extends StatefulWidget
  ├── _SplashPageState
      ├── _setupAnimation() - Setup fade & scale animations
      ├── _navigateToLogin() - Auto-navigate setelah 3 detik
      ├── dispose() - Clean up AnimationController
      └── build() - UI dengan AnimatedBuilder
```

## Dependencies Added
```yaml
flutter_svg: ^2.0.0  # For SVG rendering
```

## Usage Example

```dart
// Automatic routing on app start
GoRouter(
  initialLocation: '/splash',  // Start di splash screen
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    // ... other routes
  ],
)
```

## Animation Flow

```
Timeline (1500ms):
0ms    → Logo: opacity=0.0, scale=0.8
500ms  → Logo: opacity=0.5, scale=0.85
1000ms → Logo: opacity=0.8, scale=0.95
1500ms → Logo: opacity=1.0, scale=1.0 ✓
3000ms → Auto-navigate to /login
```

## SVG Asset Structure

```
assets/
└── logos/
    ├── logo.svg (Main app logo)
    ├── splash.svg (Splash screen logo) ✅
    └── README.md
```

## Customization Options

### Change Duration
```dart
_animationController = AnimationController(
  duration: const Duration(milliseconds: 2000), // Change from 1500
  vsync: this,
);
```

### Change Navigation Delay
```dart
Future.delayed(const Duration(seconds: 4), () { // Change from 3
  if (mounted) {
    context.go('/login');
  }
});
```

### Modify Animations
```dart
// Fade animation curve
Tween<double>(begin: 0.0, end: 1.0).animate(
  CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
)

// Scale animation range
Tween<double>(begin: 0.7, end: 1.1).animate(...)
```

## Theme Integration ✅

| Element | Theme Color | Hex |
|---------|-------------|-----|
| Background | backgroundColor | #F5F5F5 |
| App Name | primaryColor | #099FE4 |
| Tagline | textSecondaryColor | #757575 |
| Loading | primaryColor | #099FE4 |

## Testing

### On Emulator/Simulator
```bash
flutter run
# App will show splash for 3 seconds, then navigate to login
```

### On Device
```bash
flutter run -d <device-id>
```

### Verify SVG Loads
Check LogCat/Console:
```
✓ SVG splash.svg loaded successfully
✓ Animations working smoothly
✓ Navigation working at 3 seconds
```

## Performance Considerations

- ✅ Lightweight SVG asset
- ✅ Single AnimationController (efficient)
- ✅ Auto-navigation prevents manual intervention
- ✅ Proper cleanup in dispose()

## Related Files

- Theme Definition: `lib/core/theme/app_theme.dart`
- Router Config: `lib/core/router/app_router.dart`
- Generated Assets: `lib/core/gen/assets.gen.dart`

## Status

✅ **Implementation**: Complete
✅ **Theme Integration**: Complete
✅ **SVG Support**: Complete
✅ **Animation**: Complete
✅ **Routing**: Complete
✅ **Git**: Committed & Pushed

---

**Created**: November 7, 2025
**Package**: flutter_svg ^2.0.0
