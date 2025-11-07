import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/utils/dialog_helper.dart';

/// Reset Password Page
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
    if (widget.email != null) {
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
      DialogHelper.showLoading(context, message: 'Sending reset link...');

      // TODO: Call reset password API
      await Future.delayed(const Duration(seconds: 2));

      // Hide loading
      if (mounted) DialogHelper.hideLoading(context);

      // Show success
      if (mounted) {
        SnackBarHelper.showSuccess(
          context,
          'Reset link sent to ${_emailController.text}',
        );
        // Navigate back to login after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) context.pop();
        });
      }
    } catch (e) {
      // Hide loading
      if (mounted) DialogHelper.hideLoading(context);

      // Show error
      if (mounted) {
        SnackBarHelper.showError(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF393D4E)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Color(0xFF393D4E)),
        ),
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
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.08),

                  // Logo SVG
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: SvgPicture.asset(
                      Assets.logos.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),

                  // Title & Description
                  Text(
                    'Enter your email',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: const Color(0xFF393D4E),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'We\'ll send you a link to reset your password',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xCC777985),
                        ),
                  ),
                  SizedBox(height: screenHeight * 0.08),

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
                        SizedBox(height: screenHeight * 0.06),

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
                  SizedBox(height: screenHeight * 0.12),

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
