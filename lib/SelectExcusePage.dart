import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:startup_namer/result.dart';
import 'result.dart';
import 'LoadExcuse.dart';
import 'package:http/http.dart' as http;

class SelectExcusePageWidget extends StatefulWidget {
  const SelectExcusePageWidget({Key? key}) : super(key: key);

  @override
  _SelectExcusePageWidgetState createState() => _SelectExcusePageWidgetState();
}


class _SelectExcusePageWidgetState extends State<SelectExcusePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  List<String> execuseType = ['레슨', '업무', '약속', '회의', '연인/가족 연락'];
  List<String> excuseStlye = ['예의바른', '능청맞게', '친근하게', '뻔뻔하게', 'MZ스럽게'];
  String? dropdownValue1;
  String? dropdownValue2;

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final phoneUnitHeight = MediaQuery.of(context).size.height/844;
    final phoneUnitWidth = MediaQuery.of(context).size.width/390;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(phoneUnitWidth * 20, phoneUnitHeight * 20, 0, 0),
                  child: Text(
                    '변명할 대상',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(phoneUnitWidth * 20, phoneUnitHeight * 20, phoneUnitWidth * 20, 0),
                  child: TextFormField(
                    controller: textController1,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: '직장 동료',
                      hintStyle: TextStyle(
                        color: Color(0xff9e9e9e),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      )
                    )
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(phoneUnitWidth * 20, phoneUnitHeight * 10, phoneUnitWidth * 20, 0),
                  child: Text(
                    '변명 상황',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(phoneUnitWidth * 20, phoneUnitHeight * 20, phoneUnitWidth * 20, 0),
                  child: DropdownButton(
                    value: dropdownValue1,
                    items: execuseType.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    )).toList(),
                    onChanged: (value) =>
                        setState(() {
                          dropdownValue1 = value!;
                        }
                        ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color.fromRGBO(190, 185, 183, 1),
                      size: 24,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                    underline: Container(
                      height: 2,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(phoneUnitWidth * 20, 0, 0, 0),
                  child: Text(
                    '변명 스타일',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(phoneUnitWidth * 20, phoneUnitHeight * 10, phoneUnitWidth * 20, 0),
                  child: DropdownButton(
                    value: dropdownValue2,
                    items: excuseStlye.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    )).toList(),
                    onChanged: (value) =>
                        setState(() {
                          dropdownValue2 = value!;
                        }
                        ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color.fromRGBO(190, 185, 183, 1),
                      size: 24,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                    underline: Container(
                      height: 2,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.80, 0.00),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '변명 이유',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xff000000),
                        ),
                      ),
                      TextSpan(
                        text: '(20글자 이내)',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 10,
                          color: Color(0xff000000),
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(phoneUnitWidth * 20, phoneUnitHeight * 10, phoneUnitWidth * 20, 0),
                  child: TextFormField(
                    controller: textController2,
                    autofocus: true,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: '아침에 병원 다녀오느라 출근 늦음',
                      hintStyle:
                      TextStyle(
                        height: 3,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                  ),
                ),
                ),
              ),
              SizedBox(height: phoneUnitHeight * 30),
              ElevatedButton(
                  onPressed: ()async{
                    final response = await fetchData();
                    final responseData = json.decode(response.body);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultPage(),
                      )
                    );
                  },
                  child: Container(
                    width: 120 * phoneUnitWidth,
                    child: Text(
                      '변명 만들기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
        ),

      );

  }

  Future<http.Response> fetchData() async{
    final Map<String, dynamic> postData = {
      "receiver":textController1.text, "type":dropdownValue1, "tone":dropdownValue2, "situation":textController2.text
      };

    final response = await http.post(
      Uri.parse('https://excuse.withsang.com/excuse/'),
      headers: <String, String>{
        'Content-Type':'application/json',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode == 200) {
      // Request successful, print the response body
      print('Response body: ${response.body}');
    } else {
      // Request failed with an error code, print the error
      print('Request failed with status: ${response.statusCode}');
    }
    return response;
  }

}


