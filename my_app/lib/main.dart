// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

//Stateful 위젯 추가 하기
//RandomWordsState는 RandomWords 클래스에 의존적
class RandomWordsState extends State<RandomWords> {
  //참고: Dart 언어에서는 식별자 앞에 밑줄을 붙이면 프라이빗 적용이 됩니다.
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    /*
    RandomWordsState 클래스에서 build() 메서드를 변경하여 단어 생성 라이브러리를 직접 호출하지 말고
    _buildSuggestions()을 사용하도록 변경
    (Scaffold는 기본적인 머티리얼 디자인 시각 레이아웃을 구현합니다.) 
    */
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    // ListView 클래스는 builder 속성인 itemBuilder를 제공
    /*
    1 : itemBuilder 콜백은 단어 쌍이 제안될 때마다 호출되고 각각을 ListTile 행에 배치합니다. 
        짝수 행인 경우 ListTile 행에 단어 쌍을 추가합니다. 
        홀수 행인 경우 시각적으로 각 항목을 구분하는 Divider 위젯을 추가합니다. 
        작은 기기에서는 구분선을 보기 어려울 수 있습니다.
    2 : ListView의 각 행 앞에 1 픽셀 높이의 구분선 위젯을 추가하십시오.
    3 : i ~/ 2 표현식은 i를 2로 나눈 뒤 정수 결과를 반환합니다. 예를 들어: 1, 2, 3, 4, 5는 0, 1, 1, 2, 2가 됩니다. 
        이렇게 하면 구분선 위젯을 제외한 ListView에 있는 단어 쌍 수가 계산됩니다.
    4 : 가능한 단어 쌍을 모두 사용하고 나면, 10개를 더 생성하고 제안 목록에 추가합니다.
        _buildSuggestions() 함수는 단어 쌍 마다 한 번 씩 _buildRow()를 호출합니다. 이 함수는 ListTile에서 각각 새로운 쌍을 표시하여 다음 단계에서 행을 더 매력적으로 만들 수 있게 합니다.    
    */
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

//RandomWords 위젯은 상태 클래스를 만드는 것 이외에 별다른 일을 하지 않음
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
