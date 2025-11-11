import 'package:flutter/material.dart';
import 'package:gaspi_app/core/theme/app_theme.dart';

/// Example page showing how to use Nunito Sans font and color palette
class ThemeExamplePage extends StatelessWidget {
  const ThemeExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor, // #099FE4
        title: Text(
          'Theme Example',
          // Font otomatis Nunito Sans dari theme
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Style
            Text(
              'Display Large',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 8),
            
            // Headline with Primary Color
            Text(
              'Headline Primary Color',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.primaryColor, // #099FE4
                  ),
            ),
            const SizedBox(height: 8),
            
            // Title with Secondary Color
            Text(
              'Title Secondary Color',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.secondaryColor, // #5CBA4B
                  ),
            ),
            const SizedBox(height: 8),
            
            // Body text
            Text(
              'Body text menggunakan Nunito Sans Regular. Font ini otomatis di-apply ke seluruh aplikasi.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            
            // Color Palette Demo
            Text(
              'Color Palette',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: _ColorBox(
                    color: AppTheme.primaryColor,
                    label: 'Primary\n#099FE4',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ColorBox(
                    color: AppTheme.secondaryColor,
                    label: 'Secondary\n#5CBA4B',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ColorBox(
                    color: AppTheme.tertiaryColor,
                    label: 'Tertiary\n#007EFF',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Buttons Demo
            Text(
              'Buttons',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            
            // Primary Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Primary Button'),
              ),
            ),
            const SizedBox(height: 8),
            
            // Secondary Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryColor,
                ),
                onPressed: () {},
                child: const Text('Secondary Button'),
              ),
            ),
            const SizedBox(height: 8),
            
            // Outlined Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Outlined Button'),
              ),
            ),
            const SizedBox(height: 8),
            
            // Text Button with Tertiary Color
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.tertiaryColor,
              ),
              onPressed: () {},
              child: const Text('Text Button Tertiary'),
            ),
            const SizedBox(height: 16),
            
            // Font Weights Demo
            Text(
              'Font Weights',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            
            _FontWeightDemo(),
            const SizedBox(height: 16),
            
            // Card Demo
            Text(
              'Card Example',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.delivery_dining,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery Order #DO-001',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Status: Delivered',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.successColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Ini adalah contoh card dengan menggunakan Nunito Sans font dan color palette yang sudah di-set.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorBox({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}

class _FontWeightDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Regular (400)',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          'Medium (500)',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'SemiBold (600)',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Bold (700)',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'ExtraBold (800)',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
