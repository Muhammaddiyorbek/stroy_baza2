import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stroy_baza/logic/repository/auth_repository.dart';
import 'package:stroy_baza/presentation/profile/pages/fullname_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stroy_baza/logic/bloc_auth/auth_bloc.dart';
import 'package:stroy_baza/presentation/profile/pages/aksiyalar_screen.dart';
import 'package:stroy_baza/presentation/basked/pages/orders_screen.dart';
import 'package:stroy_baza/presentation/profile/pages/phone_input.dart';
import 'package:stroy_baza/presentation/profile/pages/shop_list_screen.dart';

import 'favorites_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;

  // Support contact information
  final String _supportPhone = "+998 90 762 92 82";
  final String _trustPhone = "+998 90 123 45 67";

  // Social media links
  final String _instagramUrl = "https://instagram.com";
  final String _youtubeUrl = "https://youtube.com";
  final String _telegramUrl = "https://t.me";

  @override
  void initState() {
    print("\n=== Profile Page Started ===");
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  void _checkAuth() {
    try {
      print("Checking auth status...");
      setState(() => _isLoading = true);
      context.read<AuthBloc>().add(CheckAuthEvent());
    } catch (e) {
      print("Error in auth check: $e");
      _showError("Xatolik yuz berdi, qayta urinib ko'ring");
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          setState(() => _isLoading = false);

          print("\n=== Auth State Changed ===");
          print("Current state: ${state.runtimeType}");

          if (state is ProfileUpdateSuccess) {
            print("Profile updated, checking auth");
            _checkAuth();
          } else if (state is AuthError) {
            print("Auth error: ${state.message}");
            _showError(state.message);
          }
        },
        builder: (context, state) {
          print("Building UI for state: ${state.runtimeType}");

          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                if (state is AuthenticatedState) ...[
                  _buildUserProfile(state),
                ] else ...[
                  _buildLoginButton(context),
                ],
                // Menu items
                _buildCard([
                  _buildMenuItem(
                    "assets/profile_icons/orders.svg",
                    "Buyurtmalar",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrdersScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    "assets/profile_icons/promotions.svg",
                    "Keshbeklar",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AksiyalarScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                      "assets/profile_icons/favorites.svg", "Sevimlilar",
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoritesScreen()))),
                ]),

                _buildCard([
                  _buildMenuItem(
                    "assets/profile_icons/select_city.svg",
                    "Shahar tanlash",
                  ),
                  _buildMenuItem(
                    "assets/profile_icons/select_language.svg",
                    "Til tanlash",
                  ),
                ]),

                _buildCard([
                  _buildMenuItem(
                    "assets/profile_icons/support.svg",
                    "Qo'llab-quvvatlash",
                    hideArrow: true,
                    onTap: _showSupportModal,
                  ),
                  if (state is AuthenticatedState)
                    _buildMenuItem(
                      "assets/profile_icons/exit.svg",
                      "Chiqish",
                      isRed: true,
                      hideArrow: true,
                      onTap: () => _showLogoutDialog(context),
                    ),
                ]),

                // Footer
                Padding(
                  padding: const EdgeInsets.only(top: 37, bottom: 20),
                  child: RichText(
                    text: const TextSpan(
                      text: "Powered by ",
                      style: TextStyle(
                        color: Color.fromRGBO(67, 67, 67, 0.81),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: "NSD CORPORATION",
                          style: TextStyle(
                            color: Color.fromRGBO(130, 100, 242, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: " v.1.00.0"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShopListScreen()),
            ),
            child: const Icon(Icons.location_on),
          ),
          ElevatedButton(
              onPressed: () async {
                final authRepository = AuthRepository();
                print('Access Token: ${await authRepository.getAccessToken()}');
                print('Refresh Token: ${await authRepository.getRefreshToken()}');
              },
              child: Text("refresh"))
        ],
      ),
    );
  }

  Widget _buildUserProfile(AuthenticatedState state) {
    return Container(
      margin: const EdgeInsets.only(top: 22, left: 22, right: 22, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(213, 213, 213, 1)),
      ),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullNameScreen(
              isEdit: true,
              initialFirstName: state.user.firstName,
              initialLastName: state.user.lastName,
            ),
          ),
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.person, size: 30, color: Colors.grey[600]),
        ),
        title: Text(
          "${state.user.firstName ?? ''} ${state.user.lastName ?? ''}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          state.user.phoneNumber,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: Icon(Icons.edit, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromRGBO(213, 213, 213, 1),
          width: 1,
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem(
      String svgIcon,
      String title, {
        bool isRed = false,
        bool hideArrow = false,
        Function? onTap,
      }) {
    return ListTile(
      leading: SvgPicture.asset(svgIcon, width: 24, height: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isRed ? Colors.red : Colors.black,
        ),
      ),
      trailing: hideArrow
          ? null
          : SvgPicture.asset(
        "assets/profile_icons/arrow.svg",
        width: 24,
        height: 24,
      ),
      contentPadding: EdgeInsets.zero,
      onTap: onTap != null ? () => onTap() : null,
    );
  }

  void _showSupportModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Qo'llab-quvvatlash xizmati",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Savolingiz bormi? Qo'ng'iroq qiling"),
              subtitle: Text(_supportPhone),
              trailing: IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () => launchUrl(
                    Uri.parse("tel:${_supportPhone.replaceAll(" ", "")}")),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Ishonch telefoni"),
              subtitle: Text(_trustPhone),
              trailing: IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () => launchUrl(
                    Uri.parse("tel:${_trustPhone.replaceAll(" ", "")}")),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => launchUrl(Uri.parse(_instagramUrl)),
                  child: Column(
                    children: const [
                      Icon(FontAwesomeIcons.instagram, size: 30),
                      SizedBox(height: 5),
                      Text("Instagram"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => launchUrl(Uri.parse(_youtubeUrl)),
                  child: Column(
                    children: const [
                      Icon(FontAwesomeIcons.youtube, size: 30),
                      SizedBox(height: 5),
                      Text("Youtube"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => launchUrl(Uri.parse(_telegramUrl)),
                  child: Column(
                    children: const [
                      Icon(FontAwesomeIcons.telegram, size: 30),
                      SizedBox(height: 5),
                      Text("Telegram"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Xaqiqatdan ham accauntdan\nchiqilsinmi ?",
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Yo'q",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 20),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.pop(context);
            },
            child: const Text(
              "Ha",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildLoginButton(BuildContext context) {
  return InkWell(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhoneInputScreen()),
    ),
    child: Container(
      height: 58,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 22, right: 22, top: 20, bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 223, 2, 1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(213, 213, 213, 1)),
      ),
      child: const Text(
        "Kirish",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
