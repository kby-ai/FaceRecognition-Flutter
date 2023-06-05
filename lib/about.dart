import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KBY-AI Technology'),
        toolbarHeight: 70,
        centerTitle: true,
      ),
      body: Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: const Column(children: [
            Text(
                "We are a leading provider of SDKs for advanced biometric authentication technology, including face recognition, liveness detection, and ID card recognition.\n\n"
                "In addition to biometric authentication solutions, we provide software development services for computer vision and mobile applications.\n\n"
                "With our team's extensive knowledge and proficiency in these areas, we can deliver exceptional results to our clients.\n\n"
                "If you're interested in learning more about how we can help you, please don't hesitate to get in touch with us today.\n\n"
                "Please contact us:"),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.white70,
                  weight: 24,
                ),
                SizedBox(width: 4),
                Text('Email: contact@kby-ai.com')
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Image(
                  image: AssetImage('assets/ic_skype.png'),
                  width: 24,
                  color: Colors.white70,
                ),
                SizedBox(width: 4),
                Text('Skype: live:.cid.66e2522354b1049b')
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Image(
                  image: AssetImage('assets/ic_telegram.png'),
                  width: 24,
                  color: Colors.white70,
                ),
                SizedBox(width: 4),
                Text('Telegram: kbyai')
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Image(
                  image: AssetImage('assets/ic_whatsapp.png'),
                  width: 24,
                  color: Colors.white70,
                ),
                SizedBox(width: 4),
                Text('WhatsApp: +19092802609')
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Image(
                  image: AssetImage('assets/ic_github.png'),
                  width: 24,
                  color: Colors.white70,
                ),
                SizedBox(width: 4),
                Text('Github: https://github.com/kby-ai')
              ],
            ),
          ])),
    );
  }
}
