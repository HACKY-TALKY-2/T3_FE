import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'SelectExcusePage.dart';

class ResultPage extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? selectedGender;
  String? selectedLanguage;
  String? selectedAge;
  final String responseText;

  ResultPage(this.responseText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '변명이 생성되었습니다!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Image.asset('../assets/mike.png'),
                  onPressed: () async {
                    final response = await fetchData();
                    final responseAudio = json.decode(response.body);
                    _playAudio(responseAudio['url']);
                  },
                ),
                IconButton(
                  icon: Image.asset('../assets/speaker.png'),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => AudioSettings(
                        initialLanguage: selectedLanguage,
                        initialGender: selectedGender,
                        initialAge: selectedAge,
                        onLanguageChanged: (value) {
                          selectedLanguage = value;
                        },
                        onGenderChanged: (value) {
                          selectedGender = value;
                        },
                        onAgeChanged: (value) {
                          selectedAge = value;
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('읽어주기'),
                Text('오디오 설정'),
              ],
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: responseText[0],
                style: DefaultTextStyle.of(context).style,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('변명이 마음에 들지 않으시나요??'),
                  SizedBox(height: 30),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '변명 재생성하기',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<http.Response> fetchData() async {
    final Map<String, dynamic> postData = {
      "language": selectedLanguage,
      "gender": selectedGender,
      "age": selectedAge,
      "text": responseText,
    };

    final response = await http.post(
      Uri.parse('https://excuse.withsang.com/excuse/voice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
    return response;
  }

  Future<void> _playAudio(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }
}

class AudioSettings extends StatefulWidget {
  final String? initialLanguage;
  final String? initialGender;
  final String? initialAge;
  final ValueChanged<String?> onLanguageChanged;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<String?> onAgeChanged;

  AudioSettings({
    required this.initialLanguage,
    required this.initialGender,
    required this.initialAge,
    required this.onLanguageChanged,
    required this.onGenderChanged,
    required this.onAgeChanged,
  });

  @override
  _AudioSettingsState createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  String? selectedLanguage;
  String? selectedGender;
  String? selectedAge;

  final List<String> languages = ['한국어', '영어', '일본어'];
  final List<String> genders = ['남성', '여성'];
  final List<String> ages = ['청소년', '청년', '중년', '장년'];

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.initialLanguage ?? languages[0];
    selectedGender = widget.initialGender ?? genders[0];
    selectedAge = widget.initialAge ?? ages[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('언어:'),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedLanguage,
                items: languages.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value;
                  });
                  widget.onLanguageChanged(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('성별:'),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedGender,
                items: genders.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                  widget.onGenderChanged(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('연령:'),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedAge,
                items: ages.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAge = value;
                  });
                  widget.onAgeChanged(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}