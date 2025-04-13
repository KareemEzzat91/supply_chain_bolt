import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  final String title;
  final IconData? icon;
  final List<Widget> children;

  const SettingsPage({
    super.key,
    required this.title,
    this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widgets for different settings item types
class SettingsSwitchTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final IconData? leadingIcon;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.initialValue,
    this.onChanged,
    this.leadingIcon,
  });

  @override
  State<SettingsSwitchTile> createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends State<SettingsSwitchTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        widget.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        widget.subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      secondary: widget.leadingIcon != null
          ? Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          widget.leadingIcon,
          color: Theme.of(context).primaryColor,
        ),
      )
          : null,
      value: _value,
      onChanged: (bool newValue) {
        setState(() {
          _value = newValue;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
    );
  }
}

class SettingsActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;

  const SettingsActionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
          ),
      onTap: onTap,
    );
  }
}

class SettingsCategoryHeader extends StatelessWidget {
  final String title;

  const SettingsCategoryHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// Example implementations of the settings pages using the improved components

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Notifications',
      icon: Icons.notifications,
      children: [
        const SettingsCategoryHeader(title: 'Order Notifications'),
        SettingsSwitchTile(
          title: 'Order Updates',
          subtitle: 'Get notified about order status changes',
          initialValue: true,
          leadingIcon: Icons.local_shipping,
          onChanged: (value) {
            // TODO: Implement setting change
          },
        ),
        const Divider(),
        SettingsSwitchTile(
          title: 'New Orders',
          subtitle: 'Get notified when new orders are received',
          initialValue: true,
          leadingIcon: Icons.shopping_bag,
          onChanged: (value) {
            // TODO: Implement setting change
          },
        ),
        const SettingsCategoryHeader(title: 'General Notifications'),
        SettingsSwitchTile(
          title: 'Promotions',
          subtitle: 'Receive promotional offers and discounts',
          initialValue: false,
          leadingIcon: Icons.discount,
          onChanged: (value) {
            // TODO: Implement setting change
          },
        ),
        const Divider(),
        SettingsSwitchTile(
          title: 'System Updates',
          subtitle: 'Get notified about app updates and maintenance',
          initialValue: true,
          leadingIcon: Icons.system_update,
          onChanged: (value) {
            // TODO: Implement setting change
          },
        ),
      ],
    );
  }
}

class SecuritySettingsPage extends StatelessWidget {
  const SecuritySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Security',
      icon: Icons.lock,
      children: [
        const SettingsCategoryHeader(title: 'Account Security'),
        SettingsActionTile(
          title: 'Change Password',
          subtitle: 'Update your account password',
          icon: Icons.lock_outline,
          onTap: () {
            // TODO: Implement password change
          },
        ),
        const Divider(),
        SettingsActionTile(
          title: 'Two-Factor Authentication',
          subtitle: 'Add an extra layer of security',
          icon: Icons.security,
          onTap: () {
            // TODO: Implement 2FA setup
          },
        ),
        const SettingsCategoryHeader(title: 'Activity'),
        SettingsActionTile(
          title: 'Login History',
          subtitle: 'View your recent login activity',
          icon: Icons.history,
          onTap: () {
            // TODO: Implement login history
          },
        ),
        const Divider(),
        SettingsActionTile(
          title: 'Connected Devices',
          subtitle: 'Manage devices connected to your account',
          icon: Icons.devices,
          onTap: () {
            // TODO: Implement device management
          },
        ),
      ],
    );
  }
}

class PaymentSettingsPage extends StatelessWidget {
  const PaymentSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Payment Methods',
      icon: Icons.payment,
      children: [
        const SettingsCategoryHeader(title: 'Saved Methods'),
        _buildPaymentMethod(
          context,
          'Credit Card',
          '•••• •••• •••• 4242',
          Icons.credit_card,
          true,
        ),
        const Divider(),
        _buildPaymentMethod(
          context,
          'PayPal',
          'john.doe@example.com',
          Icons.payment,
          false,
        ),
        const Divider(),
        _buildPaymentMethod(
          context,
          'Bank Transfer',
          'Account ending in 1234',
          Icons.account_balance,
          false,
        ),
        const SettingsCategoryHeader(title: 'Actions'),
        SettingsActionTile(
          title: 'Add Payment Method',
          subtitle: 'Connect a new payment option',
          icon: Icons.add_circle_outline,
          onTap: () {
            // TODO: Implement add payment method
          },
        ),
      ],
    );
  }

  Widget _buildPaymentMethod(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      bool isDefault,
      ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isDefault) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Default',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
      ),
      onTap: () {
        // TODO: Implement payment method details
      },
    );
  }
}

// Main Settings Dashboard Page
class SettingsDashboard extends StatelessWidget {
  const SettingsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: 'Settings',
      children: [
        const SettingsCategoryHeader(title: 'Account'),
        SettingsActionTile(
          title: 'Profile',
          subtitle: 'Manage your personal information',
          icon: Icons.person,
          onTap: () {
            // Navigate to profile settings
          },
        ),
        const Divider(),
        SettingsActionTile(
          title: 'Notifications',
          subtitle: 'Configure notification preferences',
          icon: Icons.notifications,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationSettingsPage(),
              ),
            );
          },
        ),
        const Divider(),
        SettingsActionTile(
          title: 'Security',
          subtitle: 'Password and account protection',
          icon: Icons.lock,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecuritySettingsPage(),
              ),
            );
          },
        ),
        const Divider(),
        SettingsActionTile(
          title: 'Payment Methods',
          subtitle: 'Manage your payment options',
          icon: Icons.payment,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentSettingsPage(),
              ),
            );
          },
        ),

        const SettingsCategoryHeader(title: 'Preferences'),
        SettingsSwitchTile(
          title: 'Dark Mode',
          subtitle: 'Toggle between light and dark themes',
          initialValue: false,
          leadingIcon: Icons.dark_mode,
          onChanged: (value) {
           context.read<ThemeProvider>().toggleTheme();
            // TODO: Implement theme change
          },
        ),
        const Divider(),
        SettingsActionTile(
          title: 'Language',
          subtitle: 'Select your preferred language',
          icon: Icons.language,
          onTap: () {
            // Navigate to language settings
          },
        ),

        const SettingsCategoryHeader(title: 'Support'),
        SettingsActionTile(
          title: 'Help Center',
          subtitle: 'Get help with using the app',
          icon: Icons.help,
          onTap: () {
            // Navigate to help center
          },
        ),
        const Divider(),
        SettingsActionTile(
          title: 'About',
          subtitle: 'App information and legal details',
          icon: Icons.info,
          onTap: () {
            // Navigate to about page
          },
        ),
        const Divider(),
        SettingsActionTile(
          title: 'Log Out',
          subtitle: 'Sign out from your account',
          icon: Icons.logout,
          onTap: () {
            // Handle logout
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Log Out'),
                content: const Text('Are you sure you want to log out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement logout
                      Navigator.pop(context);
                    },
                    child: const Text('Log Out'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}