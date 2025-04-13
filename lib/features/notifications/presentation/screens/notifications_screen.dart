import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notifications data
    final notifications = [
      {
        'title': 'New Order Received',
        'message': 'Order #12345 has been placed',
        'time': DateTime.now().subtract(const Duration(minutes: 5)),
        'read': false,
      },
      {
        'title': 'Order Delivered',
        'message': 'Order #12344 has been delivered successfully',
        'time': DateTime.now().subtract(const Duration(hours: 2)),
        'read': true,
      },
      {
        'title': 'System Update',
        'message': 'New features have been added to the app',
        'time': DateTime.now().subtract(const Duration(days: 1)),
        'read': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SafeArea(
        child: notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 64.sp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No notifications',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Card(
                    color: notification['read'] as bool
                        ? null
                        : Theme.of(context).primaryColor.withOpacity(0.1),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.w),
                      leading: Icon(
                        _getNotificationIcon(notification['title'] as String),
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        notification['title'] as String,
                        style: TextStyle(
                          fontWeight: notification['read'] as bool
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Text(notification['message'] as String),
                          SizedBox(height: 8.h),
                          Text(
                            "2022:20:9",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // TODO: Handle notification tap
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }

  IconData _getNotificationIcon(String title) {
    switch (title) {
      case 'New Order Received':
        return Icons.shopping_cart;
      case 'Order Delivered':
        return Icons.check_circle;
      case 'System Update':
        return Icons.system_update;
      default:
        return Icons.notifications;
    }
  }
}
