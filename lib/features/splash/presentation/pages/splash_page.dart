import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dart:ui';
import 'package:recipe_genie/core/theme/app_theme.dart';
import 'package:recipe_genie/features/vision/presentation/pages/vision_page.dart';
import 'package:recipe_genie/l10n/app_localizations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final List<String> _loadingMessages = [
    "Sharpening the knives...",
    "Preheating the oven...",
    "Gathering fresh inspiration...",
    "Waking up the Genie...",
  ];
  int _messageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Simulate loading progress alongside animations
    _cycleMessages();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _navigateToHome();
      }
    });
  }

  void _cycleMessages() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _loadingMessages.length;
        });
      }
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const VisionPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image + Blur
          Image.asset(
            'assets/images/kitchen_bg.png',
            fit: BoxFit.cover,
          ).animate().fadeIn(duration: 800.ms),

          // 2. Apricot Crush Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.apricotCrush.withOpacity(0.3),
                  AppColors.apricotCrush.withOpacity(0.8),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 800.ms),

          // 3. Center Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glassmorphic Square with Logo
                GlassmorphicContainer(
                  width: 200,
                  height: 200,
                  borderRadius: 30,
                  blur: 20,
                  alignment: Alignment.center,
                  border: 2,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Logo
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      // Pulsing Glow (Lightbulb effect simulation)
                      Positioned(
                        top: 40,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.0),
                            boxShadow: [
                                BoxShadow(color: Colors.white.withOpacity(0.8), blurRadius: 30, spreadRadius: 10)
                            ]
                          ),
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                         .fadeIn(duration: 1.seconds)
                         .then().fadeOut(duration: 1.seconds),
                      )
                    ],
                  ),
                )
                .animate()  
                .scale(duration: 600.ms, curve: Curves.easeOutBack, delay: 500.ms) // Pop in
                .then()
                .moveY(end: -20, duration: 2.seconds, curve: Curves.easeInOutSine) // Floating
                .then()
                .moveY(end: 0, duration: 2.seconds, curve: Curves.easeInOutSine), // Floating down

                const SizedBox(height: 30),

                // App Title
                Text(
                  AppLocalizations.of(context)!.appTitle.toUpperCase(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ).animate().fadeIn(duration: 800.ms, delay: 1200.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: 50),

                // Scanning Line / Progress
                SizedBox(
                  width: 200,
                  height: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.limeGreen),
                    ),
                  ),
                ).animate().fadeIn(delay: 1500.ms),

                const SizedBox(height: 16),

                // Loading Status Text
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _loadingMessages[_messageIndex],
                    key: ValueKey<int>(_messageIndex),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ).animate().fadeIn(delay: 1500.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
