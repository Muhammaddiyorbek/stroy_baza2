import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/logic/bloc_auth/auth_bloc.dart';
import 'package:stroy_baza/presentation/profile/pages/verification_screen.dart';

class PhoneInputScreen extends StatefulWidget {
  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
  static const routeName = '/phone-input';
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {


  final TextEditingController _controller = TextEditingController();
  bool isLoginMode = true;
  String? errorText;
  bool isLoading = false;

  void _submit() async{
    final phoneNumber = _controller.text.trim();

    if (phoneNumber.isEmpty) {
      setState(() {
        errorText = "Telefon raqamni kiriting";
      });
      return;
    }

    if (phoneNumber.replaceAll(RegExp(r'[^\d]'), '').length != 9) {
      setState(() {
        errorText = "Xato telefon raqam";
      });
      return;
    }

    setState(() {
      errorText = null;
      isLoading = true;
    });

    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    final fullPhoneNumber = '+998$cleanNumber';


    context.read<AuthBloc>().add(
      SendPhoneEvent(
        phoneNumber: fullPhoneNumber,
        isLogin: isLoginMode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is CodeSentState) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                isLogin: isLoginMode,
                phoneNumber: state.phoneNumber,
              ),
            ),
          );
        } else if (state is AuthError) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(leading: IconButton(onPressed:()=> context.pop(), icon: Icon(Icons.arrow_back)),),
        body: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              isLoginMode ? 'Xush kelibsiz !' : 'Ro\'yxatdan o\'tish',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '+998',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              PhoneNumberFormatter(),
                            ],
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 12),
                              border: InputBorder.none,
                              hintText: '__-___-__-__',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 12),
                      child: Text(
                        errorText!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 33),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 223, 2, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      onPressed:isLoading?null: _submit,
                      child: isLoading
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        isLoginMode ? 'Kirish' : 'Ro\'yxatdan o\'tish',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isLoginMode = !isLoginMode;
                    });
                  },
                  child: Text(
                    isLoginMode ? 'Ro\'yxatdan o\'tish' : 'Login orqali kirish',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(71, 38, 188, 0.75),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';

    if (digits.length > 2) {
      formatted += digits.substring(0, 2) + '-';
    } else {
      formatted += digits;
    }
    if (digits.length > 5) {
      formatted += digits.substring(2, 5) + '-';
    } else if (digits.length > 2) {
      formatted += digits.substring(2);
    }
    if (digits.length > 7) {
      formatted += digits.substring(5, 7) + '-';
    } else if (digits.length > 5) {
      formatted += digits.substring(5);
    }
    if (digits.length > 9) {
      formatted += digits.substring(7, 9);
    } else if (digits.length > 7) {
      formatted += digits.substring(7);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
