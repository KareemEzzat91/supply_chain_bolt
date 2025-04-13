import 'package:flutter/material.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/add_distributor_screen.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_list_screen.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_notification_screen.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_tracking_screen.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_performance_screen.dart';

import '../../data/models/distributor_model.dart';

class DistributorManagementScreen extends StatelessWidget {
  const DistributorManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Distributor Management',
          style: TextStyle(
            fontSize: AppTheme.headingFontSize,
            fontWeight: AppTheme.boldWeight,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Manage Distributors'),
            _buildActionGrid(context),
            SizedBox(height: AppTheme.defaultPadding * 2),
            _buildSectionTitle('Monitoring & Analytics'),
            _buildAnalyticsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.defaultPadding),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppTheme.subheadingFontSize,
          fontWeight: AppTheme.boldWeight,
        ),
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppTheme.defaultPadding,
      crossAxisSpacing: AppTheme.defaultPadding,
      children: [
        _buildManagementCard(
          context,
          'View All Distributors',
          Icons.people,
          AppTheme.primaryBlue,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DistributorListScreen(),
            ),
          ),
        ),
        _buildManagementCard(
          context,
          'Add New Distributor',
          Icons.person_add,
          AppTheme.successColor,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddDistributorScreen(),
            ),
          ),
        ),
        _buildManagementCard(
          context,
          'Block/Remove',
          Icons.block,
          AppTheme.errorColor,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DistributorListScreen(),
            ),
          ),
        ),
        _buildManagementCard(
          context,
          'Send Notifications',
          Icons.notifications,
          AppTheme.warningColor,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DistributorNotificationScreen(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppTheme.defaultPadding,
      crossAxisSpacing: AppTheme.defaultPadding,
      children: [
        _buildManagementCard(
          context,
          'Track Locations',
          Icons.location_on,
          AppTheme.secondaryBlue,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DistributorTrackingScreen(),
            ),
          ),
        ),
        _buildManagementCard(
          context,
          'Performance',
          Icons.analytics,
          AppTheme.accentColor,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DistributorPerformanceScreen(
                distributor:DistributorModel (id: '', fullName: 'Kareem Ezzat', phoneNumber: '01004092979', area: '33 Idress Saeed ', joinDate: DateTime.now(),rating: 2,email: "kareemezzat1222@gmail.com",assignedOrders: ["w","2"],averageDeliveryTime: 2.5 ,completedOrders: 6)  ,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildManagementCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppTheme.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              SizedBox(height: AppTheme.defaultPadding),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppTheme.defaultFontSize,
                  fontWeight: AppTheme.mediumWeight,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
