import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rent_hub/feature/dashboard/screen/dashboard_screen.dart';
import '../../../core/utils/app_color.dart';

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
    // Close keyboard before validating
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept the Terms & Privacy Policy',
            style: TextStyle(color: AppColor.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColor.primary,
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
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 60,
                  ),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          // Title
                          Text(
                            'Enter your phone\nnumber',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                              height: 1.3,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Subtitle
                          Text(
                            'We will send you a verification code to confirm your number.',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: AppColor.subtitleBlack,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Phone input
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
                              color: AppColor.primary,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              labelStyle: TextStyle(
                                color: AppColor.subtitleBlack,
                                fontSize: 14,
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.w600,
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                child: Text(
                                  '+91',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 0,
                                minHeight: 0,
                              ),
                              filled: true,
                              fillColor: AppColor.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: AppColor.primary.withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: AppColor.primary.withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColor.primary,
                                  width: 1.5,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColor.primary,
                                  width: 1.5,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColor.primary,
                                  width: 1.5,
                                ),
                              ),
                              errorStyle: const TextStyle(
                                color: AppColor.red,
                                fontWeight: FontWeight.w500,
                              ),
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 18),
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
                              // ✅ Auto-close keyboard when 10 digits entered
                              if (value.length == 10) {
                                FocusScope.of(context).unfocus();
                              }
                            },
                          ),

                          const SizedBox(height: 30),

                          // ✅ Terms checkbox
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
                                  activeColor: AppColor.primary,
                                  checkColor: AppColor.white,
                                  side: BorderSide(
                                    color: AppColor.subtitleBlack,
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
                                        color: AppColor.subtitleBlack,
                                        height: 1.4,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: TextStyle(
                                            color: AppColor.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            color: AppColor.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(text: '.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          const SizedBox(height: 40),

                          // Circular continue button
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: _continue,
                              child: Container(
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      AppColor.primary.withOpacity(0.25),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: AppColor.white,
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
              );
            },
          ),
        ),
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
  bool _isFilled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Auto-focus first box after first frame
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

  void _checkFilled() {
    final allFilled = _controllers.every((c) => c.text.isNotEmpty);
    if (allFilled != _isFilled) {
      setState(() => _isFilled = allFilled);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            msg,
            style: const TextStyle(color: AppColor.white),
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

  void _verify() {
    final otp = _controllers.map((c) => c.text).join();

    // ✅ Close keyboard first
    FocusScope.of(context).unfocus();

    if (otp.length == _length) {
      // Small delay so the keyboard-close animation completes nicely
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      });
    } else {
      _showSnack('Please enter the complete OTP');
    }
  }

  void _resend() {
    for (final c in _controllers) {
      c.clear();
    }
    setState(() => _isFilled = false);
    _focusNodes.first.requestFocus();
    _startTimer();
    _showSnack('OTP resent successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // ─── Back button ───
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.primary,
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColor.primary,
                      size: 18,
                    ),
                  ),
                ),
              ),

              // ─── Main content ───
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight - 20,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),

                                // ─── Title ───
                                Text(
                                  'Verification code',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primary,
                                    height: 1.3,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // ─── Subtitle + Change number on same row ───
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          text: 'We have sent the code to ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1.5,
                                            color: AppColor.subtitleBlack,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '+91 ${widget.phone}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.titleBlack,
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
                                        padding:
                                        const EdgeInsets.only(top: 1),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text(
                                              'Change',
                                              style: TextStyle(
                                                color: AppColor.primary,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 3),
                                            Icon(
                                              Icons.edit_outlined,
                                              color: AppColor.primary,
                                              size: 14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 32),

                                // ─── OTP boxes ───
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: '',
                                          filled: true,
                                          fillColor: AppColor.white,
                                          contentPadding: EdgeInsets.zero,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: AppColor.primary
                                                  .withOpacity(0.2),
                                              width: 1.5,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: AppColor.primary
                                                  .withOpacity(0.2),
                                              width: 1.5,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: AppColor.primary,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty &&
                                              i < _length - 1) {
                                            _focusNodes[i + 1].requestFocus();
                                          } else if (value.isEmpty && i > 0) {
                                            _focusNodes[i - 1].requestFocus();
                                          }
                                          _checkFilled();

                                          // ✅ Auto-verify when last digit is entered
                                          if (i == _length - 1 &&
                                              value.isNotEmpty) {
                                            _verify();
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ),

                                const SizedBox(height: 20),

                                // ─── Resend / timer ───
                                Center(
                                  child: _secondsLeft > 0
                                      ? Text(
                                    "Didn't receive the code? Resend in ${_secondsLeft}s",
                                    style: TextStyle(
                                      color: AppColor.subtitleBlack,
                                      fontSize: 13,
                                    ),
                                  )
                                      : TextButton(
                                    onPressed: _resend,
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                      MaterialTapTargetSize
                                          .shrinkWrap,
                                    ),
                                    child: const Text(
                                      'Resend Code',
                                      style: TextStyle(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),

                                const Spacer(),

                                const SizedBox(height: 40),

                                // ─── Verify button ───
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: _verify,
                                    child: Container(
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                        color: AppColor.primary,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.primary
                                                .withOpacity(0.25),
                                            blurRadius: 12,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}