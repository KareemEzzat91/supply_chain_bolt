import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supply_chain_bolt/core/routing/routes.dart';

class DistributorLoginScreen extends StatelessWidget {
  const DistributorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distributor Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Sign in to track and deliver orders',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32.h),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.h),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () =>  Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.main,
                      (Route<dynamic> route) => false,
                  arguments: {'isManager': false },

                ),


                  child: const Text('Sign In'),
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.distributorSignupScreen,
                ),
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
