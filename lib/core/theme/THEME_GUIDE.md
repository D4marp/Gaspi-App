# Gaspi App - Color Palette & Typography

## 🎨 Color Palette

### Brand Colors
```dart
// Primary Blue
AppTheme.primaryColor      // #099FE4
Color(0xFF099FE4)

// Secondary Green  
AppTheme.secondaryColor    // #5CBA4B
Color(0xFF5CBA4B)

// Tertiary Blue
AppTheme.tertiaryColor     // #007EFF
Color(0xFF007EFF)
```

### Usage Examples

#### Menggunakan dari Theme
```dart
// AppBar
AppBar(
  backgroundColor: Theme.of(context).colorScheme.primary, // #099FE4
)

// Button
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.secondary, // #5CBA4B
  ),
  child: Text('Submit'),
)

// Text dengan tertiary color
Text(
  'Link Text',
  style: TextStyle(
    color: Theme.of(context).colorScheme.tertiary, // #007EFF
  ),
)
```

#### Menggunakan dari AppTheme Constants
```dart
Container(
  color: AppTheme.primaryColor,      // #099FE4
  child: Text('Primary'),
)

Container(
  color: AppTheme.secondaryColor,    // #5CBA4B
  child: Text('Secondary'),
)

Container(
  color: AppTheme.tertiaryColor,     // #007EFF
  child: Text('Tertiary'),
)
```

### Status Colors
```dart
AppTheme.errorColor        // #D32F2F (Red)
AppTheme.warningColor      // #FFA000 (Amber)
AppTheme.successColor      // #5CBA4B (Green - same as secondary)
AppTheme.infoColor         // #099FE4 (Blue - same as primary)
```

### Background & Surface Colors
```dart
AppTheme.backgroundColor   // #F5F5F5 (Light Gray)
AppTheme.surfaceColor      // #FFFFFF (White)
AppTheme.cardColor         // #FFFFFF (White)
```

### Text Colors
```dart
AppTheme.textPrimaryColor   // #212121 (Dark Gray)
AppTheme.textSecondaryColor // #757575 (Medium Gray)
AppTheme.textHintColor      // #BDBDBD (Light Gray)
```

---

## 🔤 Typography - Nunito Sans

Font global aplikasi adalah **Nunito Sans** yang sudah dikonfigurasi di `AppTheme`.

### Font Family
```dart
// Global font family constant
AppTheme.fontFamily // 'NunitoSans'

// Access from Assets
Assets.fonts.nunitoSans // 'NunitoSans'
```

### Font Weights
```dart
FontWeight.w400  // Regular (NunitoSans-Regular.ttf)
FontWeight.w500  // Medium (NunitoSans-Medium.ttf)
FontWeight.w600  // SemiBold (NunitoSans-SemiBold.ttf)
FontWeight.w700  // Bold (NunitoSans-Bold.ttf)
FontWeight.w800  // ExtraBold (NunitoSans-ExtraBold.ttf)
```

### Text Styles

#### Display Styles (Headlines Besar)
```dart
// Display Large - 57px, Bold
Text('Title', style: Theme.of(context).textTheme.displayLarge)

// Display Medium - 45px, Bold
Text('Title', style: Theme.of(context).textTheme.displayMedium)

// Display Small - 36px, SemiBold
Text('Title', style: Theme.of(context).textTheme.displaySmall)
```

#### Headline Styles (Headers)
```dart
// Headline Large - 32px, SemiBold
Text('Header', style: Theme.of(context).textTheme.headlineLarge)

// Headline Medium - 28px, SemiBold
Text('Header', style: Theme.of(context).textTheme.headlineMedium)

// Headline Small - 24px, SemiBold
Text('Header', style: Theme.of(context).textTheme.headlineSmall)
```

#### Title Styles (Section Titles)
```dart
// Title Large - 22px, SemiBold
Text('Section', style: Theme.of(context).textTheme.titleLarge)

// Title Medium - 16px, SemiBold
Text('Section', style: Theme.of(context).textTheme.titleMedium)

// Title Small - 14px, SemiBold
Text('Section', style: Theme.of(context).textTheme.titleSmall)
```

#### Body Styles (Content Text)
```dart
// Body Large - 16px, Regular
Text('Content', style: Theme.of(context).textTheme.bodyLarge)

// Body Medium - 14px, Regular
Text('Content', style: Theme.of(context).textTheme.bodyMedium)

// Body Small - 12px, Regular
Text('Content', style: Theme.of(context).textTheme.bodySmall)
```

#### Label Styles (Buttons, Tags)
```dart
// Label Large - 14px, SemiBold
Text('Button', style: Theme.of(context).textTheme.labelLarge)

// Label Medium - 12px, SemiBold
Text('Tag', style: Theme.of(context).textTheme.labelMedium)

// Label Small - 11px, Medium
Text('Caption', style: Theme.of(context).textTheme.labelSmall)
```

### Custom Text Styles
```dart
// Custom dengan Nunito Sans
Text(
  'Custom Text',
  style: TextStyle(
    fontFamily: AppTheme.fontFamily, // atau 'NunitoSans'
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppTheme.primaryColor,
  ),
)
```

---

## 📖 Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:gaspi_app/core/theme/app_theme.dart';
import 'package:gaspi_app/core/gen/assets.gen.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor, // #099FE4
        title: Text(
          'Gaspi App',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontFamily: Assets.fonts.nunitoSans,
          ),
        ),
      ),
      body: Column(
        children: [
          // Headline dengan primary color
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
          
          // Body text dengan secondary color
          Text(
            'This app uses Nunito Sans font globally',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
          
          // Button dengan secondary color
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryColor, // #5CBA4B
            ),
            onPressed: () {},
            child: Text('Success Button'),
          ),
          
          // Text button dengan tertiary color
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.tertiaryColor, // #007EFF
            ),
            onPressed: () {},
            child: Text('Learn More'),
          ),
        ],
      ),
    );
  }
}
```

---

## 🚀 Quick Reference

### Import yang Diperlukan
```dart
import 'package:gaspi_app/core/theme/app_theme.dart';
import 'package:gaspi_app/core/gen/assets.gen.dart';
```

### Colors Shortcut
- Primary: `AppTheme.primaryColor` (#099FE4)
- Secondary: `AppTheme.secondaryColor` (#5CBA4B)
- Tertiary: `AppTheme.tertiaryColor` (#007EFF)

### Font Shortcut
- Font Family: `AppTheme.fontFamily` atau `Assets.fonts.nunitoSans`
- Semua text otomatis menggunakan Nunito Sans karena sudah set di theme

### Text Style Shortcut
```dart
// Dari theme (recommended)
Theme.of(context).textTheme.titleLarge
Theme.of(context).textTheme.bodyMedium
Theme.of(context).textTheme.labelSmall

// Dari color scheme
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.secondary
Theme.of(context).colorScheme.tertiary
```
