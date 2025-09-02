import 'package:eduwise/configs/core/app_theme.dart';
import 'package:eduwise/configs/routes/routes_name.dart';
import 'package:eduwise/provider/sign_in_provider.dart';
import 'package:eduwise/configs/widgets/bottom_border_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Sign In Screen
/// Sections: Top (logo + texts), Middle (inputs/actions), Bottom (signup)
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),

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

                // 1.1.2 Text (center align) - "Sign In for getting Information about study abroad"
                const Text(
                  'Sign In for getting Information about study abroad',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                const SizedBox(height: 12),

                // 1.1.3 Text (center align) - Styled <h4> equivalent
                // <h4 class="w-100 text-black text-center fw-bold mb-3">Sign In</h4>
                const Text(
                  'Sign In',
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
                // 2.1 Email input (bottom border only, 1px black)
                BottomBorderTextField(
                  controller: _emailCtrl,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: context.read<SignInProvider>().setEmail,
                ),
                const SizedBox(height: 16),

                // 2.2 Password input (bottom border, eye icon on right to toggle)
                BottomBorderTextField(
                  controller: _passwordCtrl,
                  hintText: 'Password',
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
                      color: Colors.black, // Black icon per spec
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // 2.3 Remember Me (left) & Forget Password? (right)
                Row(
                  children: [
                    // Left aligned Remember Me
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: sp.rememberMe,
                            onChanged: context
                                .read<SignInProvider>()
                                .toggleRememberMe,
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Remember Me',
                            style: TextStyle(color: AppTheme.textGreyA6),
                          ),
                        ],
                      ),
                    ),
                    // Right aligned Forgot Password?
                    const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: AppTheme.textGreyA6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 2.4 Sign In button with required pressed-state colors
                // Normal: background #2b4b83, text white
                // Pressed: background white, text #2b4b83, with outline
                ElevatedButton(
                  onPressed: () async {
                    await context.read<SignInProvider>().pressSignInButton();
                    // No auth action (per spec). You can navigate or show a snackbar if needed.
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sign In tapped (UI only)')),
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
                  child: const Text('Sign In'),
                ),

                const SizedBox(height: 24),

                // =========================
                // 3. BOTTOM SECTION
                // =========================
                // "Don't have an account? SignUP" (center aligned, SignUP bold)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        // ✅ UPDATED: replaced snackbar with Navigator.pushNamed
                        Navigator.pushNamed(
                          context,
                          RoutesName.signUpScreen, // <-- updated this line
                        );
                      },
                      child: const Text(
                        'SignUP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700, // bold "SignUP"
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
