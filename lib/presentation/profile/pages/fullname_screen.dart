import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/logic/bloc_auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/core/router/router.dart';

class FullNameScreen extends StatefulWidget {
  final bool isEdit;
  final String? initialFirstName;
  final String? initialLastName;

  const FullNameScreen({
    Key? key,
    this.isEdit = false,
    this.initialFirstName,
    this.initialLastName,
  }) : super(key: key);

  @override
  State<FullNameScreen> createState() => _FullNameScreenState();
}

class _FullNameScreenState extends State<FullNameScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _firstNameController.text = widget.initialFirstName ?? '';
      _lastNameController.text = widget.initialLastName ?? '';
    }
  }

  void _updateProfile() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Iltimos, ism va familiyani kiriting')),
      );
      return;
    }

    setState(() => _isLoading = true);

    context.read<AuthBloc>().add(UpdateUserEvent(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isEdit
          ? AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profilni tahrirlash',
          style: TextStyle(color: Colors.black),
        ),
      )
          : null,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            setState(() => _isLoading = false);
            if (widget.isEdit) {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              context.go(AppRouteName.main);
            }
          } else if (state is AuthError) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!widget.isEdit) SizedBox(height: 100),
                  Text(
                    "Ism",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: _firstNameController,
                    style: TextStyle(fontSize: 18, height: 1.5),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      hintText: "Ismingizni kiriting",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Familiya",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: _lastNameController,
                    style: TextStyle(fontSize: 18, height: 1.5),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      hintText: "Familiyangizni kiriting",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
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
                      onPressed: _isLoading ? null : _updateProfile,
                      child: _isLoading
                          ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        widget.isEdit ? 'Saqlash' : 'Davom etish',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  if (!widget.isEdit)
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 20),
                      child: RichText(
                        text: TextSpan(
                          text: "Powered by ",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                          children: [
                            TextSpan(
                              text: "NSD CORPORATION",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(71, 38, 188, 0.75),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
