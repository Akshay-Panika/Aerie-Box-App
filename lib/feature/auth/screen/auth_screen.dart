import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/app_color.dart';
import '../../room/dashboard/screen/room_dashboard_screen.dart';

// ============================================================
// AUTH SCREEN (Phone input)
// ============================================================
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _agreedToTerms = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _continue() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please accept the Terms & Privacy Policy',
            style: TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpScreen(phone: _phoneController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = AppColor.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ==================== GRADIENT TOP (only 30% height) ====================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.primary,
                    AppColor.secondary,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // ==================== CONTENT ====================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // ─── Back Button (White icon on gradient) ───
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ─── Title (White text on gradient) ───
                    const Text(
                      'Enter your\nphone number',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ─── Subtitle (White70 on gradient) ───
                    Text(
                      'We will send you a verification code.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // ─── Phone Input (on white area) ───
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: Color(0xFF1E293B),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          child: Text(
                            '+91',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length < 10) {
                          return 'Enter a valid 10-digit number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.length == 10) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                    ),

                    const SizedBox(height: 30),

                    // ─── Terms Checkbox ───
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _agreedToTerms,
                            onChanged: (value) {
                              setState(() =>
                              _agreedToTerms = value ?? false);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            activeColor: primaryColor,
                            checkColor: Colors.white,
                            side: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() =>
                              _agreedToTerms = !_agreedToTerms);
                            },
                            child: Text.rich(
                              TextSpan(
                                text: 'I agree to the ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: '.'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // ─── Continue Button ───
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: _continue,
                        child: Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// OTP SCREEN
// ============================================================
class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const int _length = 6;

  final List<TextEditingController> _controllers =
  List.generate(_length, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(_length, (_) => FocusNode());

  int _secondsLeft = 30;
  Timer? _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNodes.first.requestFocus();
    });
  }

  void _startTimer() {
    _secondsLeft = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            msg,
            style: const TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColor.primary,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  Future<void> _verify() async {
    if (_isVerifying) return;
    final otp = _controllers.map((c) => c.text).join();

    FocusScope.of(context).unfocus();

    if (otp.length != _length) {
      _showSnack('Please enter the complete OTP');
      return;
    }

    setState(() => _isVerifying = true);

    // ✅ Save login state here:
    // await AuthService.login(widget.phone);

    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const RoomDashboardScreen()),
          (route) => false,
    );
  }

  void _resend() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
    _startTimer();
    _showSnack('OTP resent successfully');
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = AppColor.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ==================== GRADIENT TOP (only 35% height) ====================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.primary,
                    AppColor.secondary,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // ==================== CONTENT ====================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // ─── Back Button ───
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ─── Title (White) ───
                  const Text(
                    'Verification\ncode',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ─── Subtitle + Change ───
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'Sent to ',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            children: [
                              TextSpan(
                                text: '+91 ${widget.phone}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Change',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),

                  // ─── OTP Boxes ───
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_length, (i) {
                      return SizedBox(
                        width: 48,
                        height: 58,
                        child: TextFormField(
                          controller: _controllers[i],
                          focusNode: _focusNodes[i],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: primaryColor.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: primaryColor.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && i < _length - 1) {
                              _focusNodes[i + 1].requestFocus();
                            } else if (value.isEmpty && i > 0) {
                              _focusNodes[i - 1].requestFocus();
                            }

                            if (i == _length - 1 && value.isNotEmpty) {
                              _verify();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  // ─── Resend / Timer ───
                  Center(
                    child: _secondsLeft > 0
                        ? Text(
                      "Didn't receive the code? Resend in ${_secondsLeft}s",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    )
                        : GestureDetector(
                      onTap: _resend,
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // ─── Verify Button ───
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _isVerifying ? null : _verify,
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color: _isVerifying
                              ? primaryColor.withOpacity(0.6)
                              : primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: _isVerifying
                            ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                            : const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}