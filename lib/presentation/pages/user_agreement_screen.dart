import 'package:flutter/material.dart';

class UserAgreementScreen extends StatelessWidget {
  const UserAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDEB887),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Foydalanuvchi shartnomasi',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Оммавий таклиф шартномаси',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '«Technomart.uz» Интернет-дўкони оммавий офертаси',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ушбу оммавий Оферта (кейинги ўринларда Шартнома деб юритилади) "ТЕХНОМАРТ" МЧЖ (кейинги ўринларда ТЕХНОМАРТ деб юритилади), шунда ҳар қандай жисмоний ёки юридик шахс ушбу Офертада кўрсатилган шартларда ТЕХНОМАРТ билан Маҳсулотларни олди-сотти бўйича шартнома тузиш учун зарур ҳуқуқий асослар ва шартноманинг барча муҳим шартларини ўз ичига олади.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text(
              'I. АТАМАЛАР ВА ТАЪРИФЛАР',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '1.1 Шартномада фойдаланилган атамалар ва тушунчалар базъи ҳолларда тегишли таърифлар билан махсус изоҳланади. Шартномада келтирилган атамалар ва тушунчаларнинг таърифлари унинг барча қоидаларига ва ундан келиб чиқадиган Томонлар ҳуқуқий муносабатларига нисбатан қўлланилади. Агар Бирон-бир атама ёки тушунчанинг маъноси Шартномада кўрсатилмаган бўлса ва қонун ҳужжатлари ва меъёрий ҳужжатлар асосида аниқланиши мумкин бўлмаса, бундай атама ёки тушунча одатий луғавий маънода қўлланилади.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            const Text(
              '1.2 Шартномада ишлатиладиган асосий атамалар ва таърифлар:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 40),
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
      ),
    );
  }
}
