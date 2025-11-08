import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/utils/dialog_helper.dart';

/// Reset Password Page dengan Figma Design (Simplified)
class ResetPasswordPage extends StatefulWidget {
  final String? email;

  const ResetPasswordPage({super.key, this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.email != null && widget.email!.isNotEmpty) {
      _emailController.text = widget.email!;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Show loading
      if (mounted) {
        DialogHelper.showLoading(context, message: 'Sending reset link...');
      }

      // TODO: Call reset password API
      await Future.delayed(const Duration(seconds: 2));

      // Hide loading
      if (mounted) {
        DialogHelper.hideLoading(context);
      }

      // Show success
      if (mounted) {
        SnackBarHelper.showSuccess(
          context,
          'Reset link sent to ${_emailController.text}',
        );

        // Wait 2 seconds then pop
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      // Hide loading
      if (mounted) {
        DialogHelper.hideLoading(context);
      }

      // Show error
      if (mounted) {
        SnackBarHelper.showError(context, e.toString());
      }
    }
  }

  /// Build decorative graphics pattern dari Figma design
  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Color(0xFF393D4E)),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  kToolbarHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo SVG
                  SizedBox(
                 
                    child: SvgPicture.asset(
                      Assets.logos.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),

                  // Form Fields
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email Label
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: const Color(0xFF393D4E),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 12),

                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            color: Color(0xCC777985),
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: 'gaspintar@gmail.com',
                            hintStyle: const TextStyle(
                              color: Color(0xCC777985),
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Color(0xFFDCDBDB),
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Color(0xFFDCDBDB),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Color(0xFF0286F8),
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email harus diisi';
                            }
                            if (!value.contains('@')) {
                              return 'Email tidak valid';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenHeight * 0.04),

                        // Send Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleResetPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0286F8),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Send Reset Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.08),

                  // Footer
                  Text(
                    'Gaspi Waralaba Apps v1.0',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xCC777985),
                          fontSize: 10,
                          letterSpacing: 0.02,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
