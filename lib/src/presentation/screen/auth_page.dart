import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gia_pha_so/app/util/bloc_util.dart';
import 'package:gia_pha_so/route/routes.dart';
import 'package:gia_pha_so/src/data/datasource/auth_datasrc.dart';
import 'package:gia_pha_so/src/data/model/user_model.dart';
import 'package:gia_pha_so/src/data/repository/auth_repository_impl.dart';
import 'package:gia_pha_so/src/domain/entity/user_entity.dart';
import 'package:gia_pha_so/src/presentation/widget/auth/w_sign_in.dart';
import 'package:gia_pha_so/src/presentation/widget/auth/w_sign_up.dart';
import 'package:gia_pha_so/src/presentation/widget/notification/w_snack_bar.dart';
import 'package:gia_pha_so/src/presentation/widget/w_theme_switch.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignIn = true; // Mặc định hiển thị Sign In
  late AuthRepositoryImpl authRepositoryImpl;

  void _toggleAuthMode() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }

  Future<void> _onSubmitSignIn(String phoneOrEmail, String password) async {
    final result = await authRepositoryImpl.login(
      UserLoginDataModel(password: password, phoneOrEmail: phoneOrEmail),
    );
  
    final body = jsonDecode(result.body);

    if (body['error'] != null) {
      showErrorSnackBar(
        context,
        "Đăng nhập không thành công: ${body['error']}",
      );
      return;
    }
    final data = body["data"];
    BlocUtil.handleUpdateAppData(
      context,
      UserEntity.fromJson(data?["user"] ?? {}),
      token: data?["token"] ?? "",
      refreshToken: data?["refreshToken"] ?? "",
    );
    showSuccessSnackBar(context, "Đăng nhập thành công");
    Navigator.pushReplacementNamed(context, RouteNames.home);
  }

  Future<void> _onSubmitSignUp(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    print("_onSubmitSignUp call");
    final result = await authRepositoryImpl.register(
      UserRegisterDataModel(
        username: name,
        phone: phone,
        email: email,
        password: password,
      ),
    );
    final resultBody = jsonDecode(result?.body);
    if (resultBody?["error"] != null) {
      showErrorSnackBar(context, resultBody["error"]);
      return;
    }
    if (resultBody?["success"] != null) {
      showSuccessSnackBar(context, "Đăng ký thành công");
      _toggleAuthMode();
      return;
    }
  }

  @override
  void initState() {
    authRepositoryImpl = AuthRepositoryImpl(authDataSource: AuthDataSource());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: WThemeSwitch(
                    value: BlocUtil.getThemeBloc(context).state,
                    onChanged: (mode) {
                      BlocUtil.setThemeByMode(context, mode);
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    _buildHeader(),
                    const SizedBox(height: 40),

                    // Auth Form
                    _isSignIn
                        ? SignInForm(onSubmit: _onSubmitSignIn)
                        : SignUpForm(onSubmit: _onSubmitSignUp),
                    const SizedBox(height: 24),

                    // Toggle Auth Mode
                    _buildToggleAuthMode(),
                    const SizedBox(height: 32),

                    // Social Login (chỉ hiển thị khi Sign In)
                    if (_isSignIn) _buildSocialLogin(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App Logo
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.family_restroom,
            size: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),

        // Title
        Text(
          _isSignIn ? 'Chào mừng trở lại!' : 'Tạo tài khoản mới',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Subtitle
        Text(
          _isSignIn
              ? 'Đăng nhập để tiếp tục với gia phả của bạn'
              : 'Đăng ký để bắt đầu xây dựng gia phả',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildToggleAuthMode() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            _isSignIn ? 'Chưa có tài khoản? ' : 'Đã có tài khoản? ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          TextButton(
            onPressed: _toggleAuthMode,
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              _isSignIn ? 'Đăng ký ngay' : 'Đăng nhập',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        // Divider
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Hoặc đăng nhập với',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Social buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google
            SocialLoginButton(
              icon: 'assets/icons/icon_google.png',
              onPressed: () => _socialLogin('Google'),
            ),
            const SizedBox(width: 16),

            // Facebook
            SocialLoginButton(
              icon: Icons.facebook,
              isIcon: true,
              backgroundColor: const Color(0xFF1877F2),
              onPressed: () => _socialLogin('Facebook'),
            ),
          ],
        ),
      ],
    );
  }

  void _socialLogin(String provider) {
    // TODO: Implement social login
    print('Đăng nhập với $provider');
  }
}

class SocialLoginButton extends StatelessWidget {
  final dynamic icon;
  final bool isIcon;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.icon,
    this.isIcon = false,
    this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: backgroundColor == null
              ? BorderSide(color: Theme.of(context).colorScheme.outlineVariant)
              : BorderSide.none,
        ),
        padding: const EdgeInsets.all(16),
      ),
      icon: isIcon
          ? Icon(icon as IconData, color: Colors.white, size: 24)
          : Image.asset(icon as String, width: 24, height: 24),
    );
  }
}
