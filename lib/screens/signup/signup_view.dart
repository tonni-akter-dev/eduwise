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

    _emailCtrl.value = _emailCtrl.value.copyWith(
      text: sp.email,
      selection: TextSelection.collapsed(offset: sp.email.length),
    );
    _passwordCtrl.value = _passwordCtrl.value.copyWith(
      text: sp.password,
      selection: TextSelection.collapsed(offset: sp.password.length),
    );

    return Scaffold(
      // ✅ background for modern design
      backgroundColor: Colors.grey[100], // <-- updated
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ), // <-- updated spacing
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // =========================
                // 1. TOP SECTION
                // =========================
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.20),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo/logo-red.png',
                      fit: BoxFit.contain,
                      height: 96,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Sign Up to create your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ), // <-- softer black
                ),
                const SizedBox(height: 8),

                const Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 24, // <-- slightly larger for hierarchy
                  ),
                ),
                const SizedBox(height: 24),

                // =========================
                // 2. MIDDLE SECTION (inside Card)
                // =========================
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- rounded card
                  ),
                  elevation: 4, // <-- soft shadow
                  child: Padding(
                    padding: const EdgeInsets.all(20), // <-- internal padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Name input
                        // BottomBorderTextField(
                        //   controller: TextEditingController(),
                        //   hintText: 'Enter Your Name',
                        //   keyboardType: TextInputType.text,
                        //   onChanged: (_) {},
                        // ),
                        // const SizedBox(height: 20),

                        // // Phone Number input
                        // BottomBorderTextField(
                        //   controller: TextEditingController(),
                        //   hintText: 'Enter Your Number',
                        //   keyboardType: TextInputType.phone,
                        //   onChanged: (_) {},
                        // ),
                        // const SizedBox(height: 20),

                        // Email input
                        BottomBorderTextField(
                          controller: _emailCtrl,
                          hintText: 'Enter Your Email',
                          keyboardType: TextInputType.emailAddress,
                          onChanged: context.read<SignInProvider>().setEmail,
                        ),
                        const SizedBox(height: 20),

                        // Password input
                        BottomBorderTextField(
                          controller: _passwordCtrl,
                          hintText: 'Enter Your Password',
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
                              color: Colors.grey[700], // <-- softer icon color
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Confirm Password input
                        BottomBorderTextField(
                          controller: TextEditingController(),
                          hintText: 'Enter Confirm Password',
                          obscureText: true,
                          onChanged: (_) {},
                          suffixIcon: IconButton(
                            onPressed: context
                                .read<SignInProvider>()
                                .toggleObscurePassword,
                            icon: Icon(
                              sp.obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[700], // <-- softer icon color
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Terms and Conditions Checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: sp.rememberMe,
                              onChanged: context
                                  .read<SignInProvider>()
                                  .toggleRememberMe,
                              activeColor: AppTheme.primary, // <-- theme color
                              checkColor: Colors.white,
                              side: const BorderSide(
                                color: Colors.black54,
                                width: 1,
                              ), // <-- softer border
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            const SizedBox(width: 4),
                            const Flexible(
                              child: Text.rich(
                                TextSpan(
                                  text: 'I accept ',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ), // <-- softer
                                  children: [
                                    TextSpan(
                                      text: 'Terms And Condition',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme
                                            .primary, // <-- highlighted in theme color
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Modern Sign Up Button
                        ElevatedButton(
                          onPressed: () async {
                            await context
                                .read<SignInProvider>()
                                .pressSignInButton();
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sign Up tapped (UI only)'),
                              ),
                            );
                          },
                          style:
                              ElevatedButton.styleFrom(
                                minimumSize: const Size(
                                  double.infinity,
                                  50,
                                ), // <-- full width
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ), // <-- rounded button
                                ),
                                elevation: 2,
                                backgroundColor: AppTheme.primary,
                                foregroundColor: Colors.white,
                              ).copyWith(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>((
                                      states,
                                    ) {
                                      if (states.contains(
                                        MaterialState.pressed,
                                      )) {
                                        return Colors.white;
                                      }
                                      return AppTheme.primary;
                                    }),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>((
                                      states,
                                    ) {
                                      if (states.contains(
                                        MaterialState.pressed,
                                      )) {
                                        return AppTheme.primary;
                                      }
                                      return Colors.white;
                                    }),
                                side:
                                    MaterialStateProperty.resolveWith<
                                      BorderSide?
                                    >((states) {
                                      if (states.contains(
                                        MaterialState.pressed,
                                      )) {
                                        return const BorderSide(
                                          color: AppTheme.primary,
                                          width: 1.5,
                                        );
                                      }
                                      return BorderSide.none;
                                    }),
                              ),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // =========================
                // 3. BOTTOM SECTION
                // =========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black87,
                      ), // <-- softer text
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.signInScreen);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppTheme.primary, // <-- theme highlight
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
