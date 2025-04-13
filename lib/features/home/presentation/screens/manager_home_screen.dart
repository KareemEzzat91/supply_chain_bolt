import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:supply_chain_bolt/features/profile/presentation/screens/profile_screen.dart';
import 'package:supply_chain_bolt/features/distributors/data/models/distributor_model.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/cubit/distributor_cubit.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_list_screen.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_performance_screen.dart';
import 'package:supply_chain_bolt/features/orders/presentation/screens/new_order_screen.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_management_screen.dart';
import 'package:supply_chain_bolt/features/reports/presentation/screens/reports_screen.dart';
import 'package:supply_chain_bolt/features/products/presentation/screens/product_list_screen.dart';

import '../../../distributors/presentation/cubit/distributor_state.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DistributorCubit()..loadDistributors(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.primaryBlue,
          title: const Text(
            'Manager Dashboard',
            style: TextStyle(
              fontSize: AppTheme.headingFontSize,
              fontWeight: AppTheme.boldWeight,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
            ).animate().fadeIn(duration: 300.ms, delay: 100.ms).moveX(begin: 10, end: 0),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ).animate().fadeIn(duration: 300.ms, delay: 200.ms).moveX(begin: 10, end: 0),
          ],
        ),
        body: BlocBuilder<DistributorCubit, DistributorState>(
          builder: (context, state) {
            if (state is DistributorLoading) {
              return Center(
                child: const CircularProgressIndicator(
                  color: AppTheme.primaryBlue,
                ).animate()
                    .fadeIn(duration: 400.ms)
                    .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
              );
            }
            if (state is DistributorError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: AppTheme.errorColor, size: 48)
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .scale(),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: TextStyle(
                        color: AppTheme.errorColor,
                        fontSize: AppTheme.subheadingFontSize,
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
                  ],
                ),
              );
            }
            if (state is DistributorLoaded) {
              return _buildHomeContent(context, state.distributors);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildHomeContent(
      BuildContext context, List<DistributorModel> distributors) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(
              left: AppTheme.defaultPadding,
              right: AppTheme.defaultPadding,
              top: AppTheme.defaultPadding,
              bottom: AppTheme.defaultPadding * 2,
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: AppTheme.defaultFontSize,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ).animate().fadeIn(duration: 500.ms),
                const SizedBox(height: 8),
                const Text(
                  'Supply Chain Overview',
                  style: TextStyle(
                    fontSize: AppTheme.headingFontSize,
                    fontWeight: AppTheme.boldWeight,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
                const SizedBox(height: 20),
                _buildStatsGrid(context, distributors),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(AppTheme.defaultPadding),
          sliver: SliverToBoxAdapter(
            child: _buildQuickActions(context),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding),
          sliver: SliverToBoxAdapter(
            child: _buildDistributorList(context, distributors),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: AppTheme.defaultPadding * 2),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(
      BuildContext context, List<DistributorModel> distributors) {
    final activeDistributors =
        distributors.where((d) => d.status == 'Active').length;
    final totalRevenue = distributors.fold<double>(
        0, (sum, d) => sum + (d.completedOrders * 100));
    final averageRating = distributors.isEmpty
        ? 0.0
        : distributors.fold<double>(0, (sum, d) => sum + d.rating) /
        distributors.length;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppTheme.defaultPadding,
      crossAxisSpacing: AppTheme.defaultPadding,
      childAspectRatio: 1.3,
      children: [
        _buildStatCard(
          'Active Distributors',
          activeDistributors.toString(),
          Icons.people,
          AppTheme.successColor,
          Colors.white,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DistributorListScreen(),
            ),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
        _buildStatCard(
          'Total Revenue',
          '\$${totalRevenue.toStringAsFixed(2)}',
          Icons.attach_money,
          AppTheme.primaryBlue,
          Colors.white,
        ).animate().fadeIn(duration: 600.ms, delay: 300.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
        _buildStatCard(
          'Product Management',
          'Manage',
          Icons.inventory,
          AppTheme.secondaryBlue,
          Colors.white,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductListScreen(),
            ),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
        _buildStatCard(
          'Average Rating',
          averageRating.toStringAsFixed(1),
          Icons.star,
          AppTheme.warningColor,
          Colors.white,
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
      ],
    );
  }

  Widget _buildStatCard(
      String title,
      String value,
      IconData icon,
      Color color,
      Color textColor,
      {VoidCallback? onTap}
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(AppTheme.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 24, color: color),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value,
                          style: const TextStyle(
                            fontSize: AppTheme.subheadingFontSize,
                            fontWeight: AppTheme.boldWeight,
                            color: AppTheme.textColor,
                          ),
                        ),
                        SizedBox(height: AppTheme.defaultPadding / 4),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: AppTheme.captionFontSize,
                            color: AppTheme.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
          .shimmer(duration: 1000.ms, color: color.withOpacity(0.2))
          .then(delay: 1000.ms),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: AppTheme.subheadingFontSize,
              fontWeight: AppTheme.boldWeight,
              color: AppTheme.textColor,
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
        ),
        Container(
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.defaultPadding),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: AppTheme.defaultPadding,
              crossAxisSpacing: AppTheme.defaultPadding,
              childAspectRatio: 1.0,
              children: [
                _buildActionButton(
                  context,
                  'Products',
                  Icons.inventory,
                  AppTheme.primaryBlue,
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductListScreen(),
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 400.ms)
                    .slideY(begin: 0.2, end: 0),
                _buildActionButton(
                  context,
                  'New Order',
                  Icons.shopping_cart,
                  AppTheme.successColor,
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewOrderScreen(),
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 500.ms)
                    .slideY(begin: 0.2, end: 0),
                _buildActionButton(
                  context,
                  'Distributors',
                  Icons.people,
                  AppTheme.warningColor,
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DistributorManagementScreen(),
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 600.ms)
                    .slideY(begin: 0.2, end: 0),
                _buildActionButton(
                  context,
                  'Reports',
                  Icons.assessment,
                  AppTheme.secondaryBlue,
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportsScreen(),
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 700.ms)
                    .slideY(begin: 0.2, end: 0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context,
      String label,
      IconData icon,
      Color color,
      VoidCallback onPressed,
      ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Icon(icon, size: 30, color: color),
            ).animate(onPlay: (controller) => controller.forward(from: 0.0))
                .scaleXY(begin: 1, end: 0.9, duration: 100.ms)
                .then(duration: 100.ms)
                .scaleXY(begin: 0.9, end: 1),
            SizedBox(height: AppTheme.defaultPadding),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppTheme.defaultFontSize,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistributorList(
      BuildContext context, List<DistributorModel> distributors) {
    final displayDistributors = distributors.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Distributors',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
                color: AppTheme.textColor,
              ),
            ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
            TextButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DistributorListScreen(),
                ),
              ),
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: const Text('View All'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primaryBlue,
              ),
            ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayDistributors.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.2),
              indent: 70,
            ),
            itemBuilder: (context, index) {
              final distributor = displayDistributors[index];
              return _buildDistributorTile(context, distributor, index);
            },
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
      ],
    );
  }

  Widget _buildDistributorTile(BuildContext context, DistributorModel distributor, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.defaultPadding,
        vertical: AppTheme.defaultPadding / 2,
      ),
      leading: Hero(
        tag: 'distributor-${distributor.id}',
        child: CircleAvatar(
          backgroundColor: _getStatusColor(distributor.status),
          radius: 24,
          child: Text(
            distributor.fullName[0],
            style: const TextStyle(
               fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: Text(
        distributor.fullName,
        style: TextStyle(
          fontSize: AppTheme.defaultFontSize,
          fontWeight: AppTheme.boldWeight,
         ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppTheme.defaultPadding / 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(distributor.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  distributor.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor(distributor.status),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.defaultPadding / 2),
              Expanded(
                child: Text(
                  'Area: ${distributor.area}',
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: AppTheme.captionFontSize,
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.warningColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star,
              color: AppTheme.warningColor,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              distributor.rating.toString(),
              style: const TextStyle(
                fontSize: AppTheme.captionFontSize,
                fontWeight: FontWeight.bold,
                color: AppTheme.warningColor,
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              DistributorPerformanceScreen(distributor: distributor),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 300.ms + (index * 100).ms)
        .slideX(begin: 0.1, end: 0);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppTheme.successColor;
      case 'blocked':
        return AppTheme.errorColor;
      default:
        return AppTheme.secondaryTextColor;
    }
  }
}