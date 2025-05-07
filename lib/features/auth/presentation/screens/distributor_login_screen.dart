import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supply_chain_bolt/core/di/dependency_injection.dart';
import 'package:supply_chain_bolt/core/routing/routes.dart';

import '../../logic/distributor_auth_cubit.dart';
import '../../logic/distributor_auth_state.dart';

class DistributorLoginScreen extends StatelessWidget {
  DistributorLoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<DistributorAuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Distributor Login'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: SingleChildScrollView(
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
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<DistributorAuthCubit, DistributorAuthState>(
                    builder: (context, state) {
                      if (state is DistributorAuthLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is DistributorAuthError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message.toString())));
                        });
                        return ElevatedButton(
                          onPressed: () => context
                              .read<DistributorAuthCubit>()
                              .distLogin(emailController.text.trim(),
                                  passwordController.text.trim()),
                          child: const Text('Try Again'),
                        );
                      }
                      if (state is DistributorAuthSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.main,
                            (Route<dynamic> route) => false,
                            arguments: {'isManager': false},
                          );
                        });
                      }

                      return ElevatedButton(
                        onPressed: () => context
                            .read<DistributorAuthCubit>()
                            .distLogin(emailController.text.trim(),
                                passwordController.text.trim()),
                        child: const Text('Sign In'),
                      );
                    },
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
        ),
      ),
    );
  }
}
