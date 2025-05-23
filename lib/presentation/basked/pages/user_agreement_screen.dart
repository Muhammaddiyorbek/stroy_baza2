import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroy_baza/logic/repository/user_agreement_repository.dart';
import 'package:stroy_baza/presentation/basked/bolcs/user_agreement/user_agreement_bloc.dart';
import 'package:stroy_baza/presentation/basked/bolcs/user_agreement/user_agreement_event.dart';
import 'package:stroy_baza/presentation/basked/bolcs/user_agreement/user_agreement_state.dart';
import 'package:stroy_baza/presentation/blocs/language_bloc/language_bloc.dart';

class UserAgreementScreen extends StatefulWidget {
  final String locale;

  const UserAgreementScreen({super.key, required this.locale});

  @override
  State<UserAgreementScreen> createState() => _UserAgreementScreenState();
}

class _UserAgreementScreenState extends State<UserAgreementScreen> {
  late final UserAgreementBloc _userAgreementBloc;

  @override
  void initState() {
    super.initState();
    _userAgreementBloc =
    UserAgreementBloc(UserAgreementRepository(Dio()))
      ..add(LoadUserAgreement(widget.locale));
  }

  @override
  void dispose() {
    _userAgreementBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserAgreementBloc>.value(
      value: _userAgreementBloc,
      child: BlocListener<LanguageBloc, LanguageState>(
        listener: (context, state) {
          if (!_userAgreementBloc.isClosed) {
            _userAgreementBloc
                .add(LoadUserAgreement(state.locale.languageCode));
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            surfaceTintColor: const Color.fromRGBO(220, 195, 139, 1),
            backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            titleSpacing: -15,
            title: const Text(
              "Foydalanuvchi shartnomasi",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          body: BlocBuilder<UserAgreementBloc, UserAgreementState>(
            builder: (context, state) {
              if (state is UserAgreementLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserAgreementLoaded) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                state.content,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: RichText(
                          text: const TextSpan(
                            text: 'Powered by ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'NSD CORPORATION',
                                style: TextStyle(
                                  color: Color(0xFF8264F2),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is UserAgreementError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
