import 'package:flutter/material.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/distributors/data/models/distributor_model.dart';

class DistributorDetailsScreen extends StatelessWidget {
  final DistributorModel distributor;

  const DistributorDetailsScreen({
    super.key,
    required this.distributor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Distributor Details',
          style: TextStyle(
            fontSize: AppTheme.headingFontSize,
            fontWeight: AppTheme.boldWeight,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'block') {
                // TODO: Implement block functionality
              } else if (value == 'delete') {
                // TODO: Implement delete functionality
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'block',
                child: Text('Block Distributor'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete Account'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: AppTheme.defaultPadding),
            _buildContactInfo(),
            SizedBox(height: AppTheme.defaultPadding),
            _buildPerformanceMetrics(),
            SizedBox(height: AppTheme.defaultPadding),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: _getStatusColor(distributor.status),
              child: Text(
                distributor.fullName[0],
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: AppTheme.defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    distributor.fullName,
                    style: TextStyle(
                      fontSize: AppTheme.subheadingFontSize,
                      fontWeight: AppTheme.boldWeight,
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultPadding / 2),
                  Text(
                    'Status: ${distributor.status}',
                    style: TextStyle(
                      fontSize: AppTheme.defaultFontSize,
                      color: _getStatusColor(distributor.status),
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultPadding / 2),
                  Text(
                    'Member since: ${_formatDate(distributor.joinDate)}',
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
      ),
    );
  }

  Widget _buildContactInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            _buildInfoRow(Icons.phone, distributor.phoneNumber),
            if (distributor.email != null)
              _buildInfoRow(Icons.email, distributor.email!),
            _buildInfoRow(Icons.location_on, distributor.area),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            _buildMetricRow(
              'Completed Orders',
              distributor.completedOrders.toString(),
              Icons.shopping_cart,
            ),
            _buildMetricRow(
              'Average Delivery Time',
              '${distributor.averageDeliveryTime} minutes',
              Icons.timer,
            ),
            _buildMetricRow(
              'Rating',
              distributor.rating.toString(),
              Icons.star,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: distributor.assignedOrders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.local_shipping),
                  title: Text(
                    'Order #${distributor.assignedOrders[index]}',
                    style: TextStyle(
                      fontSize: AppTheme.defaultFontSize,
                      fontWeight: AppTheme.mediumWeight,
                    ),
                  ),
                  subtitle: Text(
                    'In Progress',
                    style: TextStyle(
                      fontSize: AppTheme.captionFontSize,
                      color: AppTheme.secondaryTextColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppTheme.defaultPadding / 2),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppTheme.defaultIconSize,
            color: AppTheme.secondaryTextColor,
          ),
          SizedBox(width: AppTheme.defaultPadding),
          Text(
            text,
            style: TextStyle(
              fontSize: AppTheme.defaultFontSize,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppTheme.defaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: AppTheme.defaultIconSize,
                color: AppTheme.secondaryTextColor,
              ),
              SizedBox(width: AppTheme.defaultPadding),
              Text(
                label,
                style: TextStyle(
                  fontSize: AppTheme.defaultFontSize,
                  color: AppTheme.secondaryTextColor,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: AppTheme.defaultFontSize,
              fontWeight: AppTheme.boldWeight,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
