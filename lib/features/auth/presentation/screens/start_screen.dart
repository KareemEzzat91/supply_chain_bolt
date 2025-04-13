import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import "package:provider/provider.dart";
import 'package:supply_chain_bolt/core/routing/routes.dart';
import 'package:supply_chain_bolt/core/theme/theme_provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),

          // Animated background elements
          Positioned(
            top: size.height * 0.1,
            right: -20,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryBlue.withAlpha(40),
              ),
            ).animate().fadeIn(duration: 1500.ms).slideX(begin: 0.5, end: 0),
          ),

          Positioned(
            bottom: size.height * 0.2,
            left: -30,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.distributorAccent.withAlpha(30),
              ),
            )
                .animate()
                .fadeIn(duration: 1500.ms, delay: 500.ms)
                .slideX(begin: -0.5, end: 0),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App bar with logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            color: AppTheme.primaryBlue,
                            size: 24.sp,
                          )
                              .animate()
                              .scale(delay: 300.ms, duration: 500.ms)
                              .then(delay: 200.ms)
                              .shake(hz: 4, curve: Curves.easeInOut),
                          SizedBox(width: 8.w),
                          Text(
                            "Supply Chain Bolt",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryBlue,
                            ),
                          )
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .slideX(begin: -0.5, duration: 500.ms),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              themeProvider.toggleTheme();
                            },
                            icon: Icon(
                              isDarkMode ? Icons.light_mode : Icons.dark_mode,
                              color: AppTheme.primaryBlue,
                            ),
                          ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.05),

                  // Welcome illustration
                  Center(
                    child: Container(
                      height: size.height * 0.25,
                      width: size.height * 0.25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor,
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.inventory_2_outlined,
                        size: 80.sp,
                        color: AppTheme.primaryBlue,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .scale(
                          delay: 200.ms,
                          duration: 700.ms,
                          curve: Curves.elasticOut,
                        )
                        .then(delay: 1.seconds)
                        .shimmer(duration: 1.seconds),
                  ),

                  SizedBox(height: size.height * 0.03),

                  // Header
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        'Select Your Role',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ).animate().scale(
                          delay: 300.ms,
                          duration: 400.ms,
                          curve: Curves.bounceOut,
                        ),
                  ),

                  SizedBox(height: size.height * 0.05),

                  // Manager role card
                  _buildAnimatedOptionCard(
                    context,
                    icon: Icons.manage_accounts_outlined,
                    label: 'Manager',
                    description: 'Manage your supply chain operations',
                    gradientColors: isDarkMode
                        ? [const Color(0xFF00BCD4), const Color(0xFF2196F3)]
                        : [const Color(0xFFB2EBF2), const Color(0xFF00BCD4)],
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.managerLoginScreen),
                  ).animate().slideX(begin: -0.5, duration: 1000.ms),

                  SizedBox(height: 20.h),

                  // Distributor role card
                  _buildAnimatedOptionCard(
                    context,
                    icon: Icons.local_shipping_outlined,
                    label: 'Distributor',
                    description: 'Track and deliver orders efficiently',
                    gradientColors: isDarkMode
                        ? [const Color(0xFF9C27B0), const Color(0xFF673AB7)]
                        : [const Color(0xFFE1BEE7), const Color(0xFF9C27B0)],
                    onTap: () => Navigator.pushNamed(
                        context, Routes.distributorLoginScreen),
                  ).animate().slideX(begin: 0.5, duration: 1000.ms),

                  const Spacer(),

                  // Footer
                  Center(
                    child: Text(
                      "© 2024 Supply Chain Bolt",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: 12.sp,
                      ),
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 1200.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedOptionCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String description,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withAlpha(150),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24.r),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Container(
                    height: 64.h,
                    width: 64.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      icon,
                      size: 34.sp,
                      color: Colors.white,
                    ).animate().fade(duration: 300.ms).scale(delay: 200.ms),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 36.h,
                    width: 36.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shake(delay: 2.seconds, duration: 700.ms, hz: 3)
                      .then(delay: 3.seconds),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .scale(
          begin: const Offset(0.97, 0.97),
          end: const Offset(1, 1),
          duration: 2.seconds,
          curve: Curves.easeInOut,
        )
        .then()
        .shimmer(delay: 1.seconds, duration: 1.seconds);
  }
}
