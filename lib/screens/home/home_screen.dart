import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use Scaffold for proper screen layout
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // Gradient background for modern look
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF9FAFB), Color(0xFFE3F2FD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Row with Search Icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons/search.png", // search icon from assets
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 10),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                        children: const [
                          TextSpan(text: "Find "),
                          TextSpan(
                            text: "Your Ideal\nUniversity Abroad",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Subtitle text
                Text(
                  "Get matched with the right universities, programs, and scholarships based on your academic profile and budget — all in one place.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),

                // Avatars + Rating Row
                Row(
                  children: [
                    // Overlapping user avatars
                    SizedBox(
                      width: 120, // give width so Stack doesn't overflow
                      height: 36,
                      child: Stack(
                        children: List.generate(4, (index) {
                          return Positioned(
                            left: index * 25,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage(
                                "assets/images/home/hero/1${index + 1}.jpg",
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const Spacer(),

                    // Rating stars
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Reviews
                Align(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    "From 120+ Reviews",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Call-to-action button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
