import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supply_chain_bolt/core/routing/routes.dart';
import 'package:supply_chain_bolt/features/auth/logic/manager_auth_state.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../logic/manager_auth_cubit.dart';

class ManagerSignupScreen extends StatelessWidget {
   ManagerSignupScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<ManagerAuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manager Sign Up'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Sign up to start managing your supply chain',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 32.h),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 16.h),
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
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(height: 24.h),
                BlocBuilder<ManagerAuthCubit, ManagerAuthState>(
                  builder: (context, state) {
                    if (state is ManagerAuthLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ManagerAuthError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.toString())));});
                        return ElevatedButton(
                        onPressed: () => context.read<ManagerAuthCubit>().managerSignUp(nameController.text.trim(),emailController.text.trim(),passwordController.text.trim(), "Manager"),
                        child: const Text('Try Again'),
                      );
                    }
                    if (state is ManagerAuthSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {

                        Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.main,
                            (Route<dynamic> route) => false,
                        arguments: {'isManager': true},

                      );});
                    }
                    return ElevatedButton(
                      onPressed: () => context.read<ManagerAuthCubit>().managerSignUp(nameController.text.trim(),emailController.text.trim(),passwordController.text.trim(), "Manager"),
                      child: const Text('Sign Up'),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Already have an account? Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
