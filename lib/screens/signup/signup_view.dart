import 'package:eduwise/configs/core/app_theme.dart';
import 'package:eduwise/configs/routes/routes_name.dart';
import 'package:eduwise/provider/sign_in_provider.dart';
import 'package:eduwise/configs/widgets/bottom_border_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Sign UP Screen
/// Sections: Top (logo + texts), Middle (inputs/actions), Bottom (signup)
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers for the text fields (kept local to widget; values mirrored via provider).
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    final width = MediaQuery.of(context).size.width;

    // Keep controllers in sync with provider for clarity in this UI-only example.
    // (In a real-world app, consider TextEditingController.text directly.)
    _emailCtrl.value = _emailCtrl.value.copyWith(
      text: sp.email,
      selection: TextSelection.collapsed(offset: sp.email.length),
    );
    _passwordCtrl.value = _passwordCtrl.value.copyWith(
      text: sp.password,
      selection: TextSelection.collapsed(offset: sp.password.length),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),

          // ✅ ADDED Center widget to align content vertically and horizontally
          child: Center(
            // <-- added this line
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment:
                  MainAxisAlignment.center, // <-- added this line
              children: [
                // =========================
                // 1. TOP SECTION
                // =========================
                // 1.1.1 Logo centered with 20% gap on both sides
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.20,
                  ), // 20% left & right gap
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo/logo-red.png',
                      fit: BoxFit.contain,
                      height: 96,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // 1.1.2 Text (center align) - Updated for Sign Up
                const Text(
                  'Sign Up to create your account', // <-- updated this line
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                const SizedBox(height: 12),

                // 1.1.3 Text (center align) - Styled <h4> equivalent
                const Text(
                  'Sign Up', // <-- updated this line
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20, // approximate h4 size in Flutter
                  ),
                ),
                const SizedBox(height: 16),

                // =========================
                // 2. MIDDLE SECTION
                // =========================

                // 2.1 Name input
                BottomBorderTextField(
                  controller: TextEditingController(), // <-- added this line
                  hintText: 'Enter Your Name', // <-- added this line
                  keyboardType: TextInputType.text, // <-- added this line
                  onChanged: (_) {}, // <-- added this line
                ),
                const SizedBox(height: 16), // <-- added this line
                // 2.2 Phone Number input
                BottomBorderTextField(
                  controller: TextEditingController(), // <-- added this line
                  hintText: 'Enter Your Number', // <-- added this line
                  keyboardType: TextInputType.phone, // <-- added this line
                  onChanged: (_) {}, // <-- added this line
                ),
                const SizedBox(height: 16), // <-- added this line
                // 2.3 Email input
                BottomBorderTextField(
                  controller: _emailCtrl,
                  hintText: 'Enter Your Email', // <-- updated this line
                  keyboardType: TextInputType.emailAddress,
                  onChanged: context.read<SignInProvider>().setEmail,
                ),
                const SizedBox(height: 16),

                // 2.4 Password input
                BottomBorderTextField(
                  controller: _passwordCtrl,
                  hintText: 'Enter Your Password', // <-- updated this line
                  obscureText: sp.obscurePassword,
                  onChanged: context.read<SignInProvider>().setPassword,
                  suffixIcon: IconButton(
                    onPressed: context
                        .read<SignInProvider>()
                        .toggleObscurePassword,
                    icon: Icon(
                      sp.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16), // <-- updated spacing
                // 2.5 Confirm Password input
                BottomBorderTextField(
                  controller: TextEditingController(), // <-- added this line
                  hintText: 'Enter Confirm Password', // <-- added this line
                  obscureText: true, // <-- added this line
                  onChanged: (_) {}, // <-- added this line
                  suffixIcon: IconButton(
                    onPressed: context
                        .read<SignInProvider>()
                        .toggleObscurePassword,
                    icon: Icon(
                      sp.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16), // <-- added this line
                // 2.6 Terms and Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: sp.rememberMe, // <-- reusing provider state
                      onChanged: context
                          .read<SignInProvider>()
                          .toggleRememberMe,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      side: const BorderSide(color: Colors.black, width: 1),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const SizedBox(width: 4),
                    const Text.rich(
                      TextSpan(
                        text: 'I accept ', // <-- added this line
                        style: TextStyle(color: AppTheme.textGreyA6),
                        children: [
                          TextSpan(
                            text: 'Terms And Condition', // <-- added this line
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold, // <-- added this line
                              color: AppTheme.textGreyA6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 2.4 Sign Up button with required pressed-state colors
                ElevatedButton(
                  onPressed: () async {
                    await context.read<SignInProvider>().pressSignInButton();
                    // No auth action (per spec). You can navigate or show a snackbar if needed.
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign Up tapped (UI only)'),
                      ), // <-- updated this line
                    );
                  },
                  style: ButtonStyle(
                    // Background color switches on pressed state
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.white; // pressed state
                      }
                      return AppTheme.primary; // normal
                    }),
                    // Text color switches on pressed
                    foregroundColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(MaterialState.pressed)) {
                        return AppTheme.primary; // pressed text
                      }
                      return Colors.white; // normal text
                    }),
                    // Add border when pressed (so white bg doesn’t "disappear")
                    side: MaterialStateProperty.resolveWith<BorderSide?>((
                      states,
                    ) {
                      if (states.contains(MaterialState.pressed)) {
                        return const BorderSide(
                          color: AppTheme.primary,
                          width: 1.5,
                        );
                      }
                      return const BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      );
                    }),
                  ),
                  child: const Text('Sign Up'), // <-- updated this line
                ),

                const SizedBox(height: 24),

                // =========================
                // 3. BOTTOM SECTION
                // =========================
                // "Already have an account? Sign In"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ", // <-- updated this line
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        // ✅ Navigate to Sign In screen
                        Navigator.pushNamed(
                          context,
                          RoutesName.signInScreen, // <-- confirmed correct here
                        );
                      },
                      child: const Text(
                        'Sign In', // <-- updated this line
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700, // bold "Sign In"
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ), // <-- closed Center
        ),
      ),
    );
  }
}
