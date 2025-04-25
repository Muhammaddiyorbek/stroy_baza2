import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/logic/bloc_auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/presentation/profile/pages/fullname_screen.dart';
import 'package:stroy_baza/presentation/profile/pages/phone_input.dart';
import 'package:telephony/telephony.dart';

@pragma('vm:entry-point')
void backgroundMessageHandler(SmsMessage message) {
  print("\n=== Yangi SMS keldi bg ===");
  print("SMS matni: ${message.body}");
}

class VerificationScreen extends StatefulWidget {
  final bool isLogin;
  final String phoneNumber;

  const VerificationScreen({
    super.key,
    required this.isLogin,
    required this.phoneNumber,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  final Telephony telephony = Telephony.instance;
  Timer? _timer;
  int _timeLeft = 59;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    _initSmsListener();
    _setupControllers();
  }

  void _setupControllers() {
    for (int i = 0; i < 5; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          focusNodes[i + 1].requestFocus();
        }
      });
    }

    controllers[5].addListener(() {
      if (controllers[5].text.length == 1) {
        _verifyCode();
      }
    });
  }

  Future<void> _initSmsListener() async {
    final bool? permissionsGranted =
    await telephony.requestPhoneAndSmsPermissions;

    if (permissionsGranted ?? false) {
      telephony.listenIncomingSms(
        onNewMessage: _handleIncomingSms,
        onBackgroundMessage: backgroundMessageHandler,
      );
      print("SMS listener faollashtirildi");
    } else {
      print("SMS ruxsati berilmadi");
    }
  }

  void _handleIncomingSms(SmsMessage message) {
    print("\n=== Yangi SMS keldi ===");
    print("SMS matni: ${message.body}");

    if (message.body?.contains("tasdiqlash kodingiz") ?? false) {
      final match = RegExp(r'tasdiqlash kodingiz[^\d]*(\d{6})')
          .firstMatch(message.body ?? '');
      if (match != null) {
        final code = match.group(1)!;
        setState(() {
          for (int i = 0; i < 6; i++) {
            controllers[i].text = code[i];
          }
        });
        _verifyCode();
      }
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        timer.cancel();
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void resendCode() {
    if (_timeLeft == 0) {
      setState(() {
        _timeLeft = 59;
      });
      startTimer();
      context.read<AuthBloc>().add(
        SendPhoneEvent(
          phoneNumber: widget.phoneNumber,
          isLogin: widget.isLogin,
        ),
      );
    }
  }

  void _verifyCode() {
    final code = controllers.map((c) => c.text).join();
    if (code.length != 6) return;

    setState(() {
      isLoading = true;
    });

    context.read<AuthBloc>().add(
      VerifyPhoneEvent(
        phoneNumber: widget.phoneNumber,
        code: code,
        isLogin: widget.isLogin,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
            } else if (state is VerificationSuccessState) {
              setState(() {
                isLoading = false;
              });
              if (widget.isLogin) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FullNameScreen()),
                );
              }
            } else if (state is AuthError) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'SMS Tasdiqlash',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Quyidagi raqamga yuborilgan kodni kiriting:\n${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: List.generate(6, (index) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(213, 213, 213, 0.55),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                            cursorHeight: 40,
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.yellow,
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 5) {
                                focusNodes[index + 1].requestFocus();
                              }
                              if (value.isEmpty && index > 0) {
                                focusNodes[index - 1].requestFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                Text(
                  _timeLeft > 0
                      ? 'Kodni qayta yuborish: 00:${_timeLeft.toString().padLeft(2, '0')}'
                      : 'Vaqt tugadi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: _timeLeft > 0 ? Colors.black87 : Colors.red,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 223, 2, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    onPressed: _timeLeft == 0
                        ? resendCode
                        : (isLoading ? null : _verifyCode),
                    child: isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      _timeLeft == 0
                          ? 'Qayta yuborish'
                          : (widget.isLogin
                          ? 'Tasdiqlash'
                          : 'Ro\'yxatdan o\'tishni yakunlash'),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PhoneInputScreen())),
                  child: const Text(
                    "Telefon raqamni o'zgartirish",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(71, 38, 188, 0.75),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}