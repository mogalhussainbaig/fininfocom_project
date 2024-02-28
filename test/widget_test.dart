// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {

  ///UNIT TEST
  // test('API call returns image URL', () async {
  //   final client = MockClient();
  //   when(client.get(Uri.parse('https://dog.ceo/api/breeds/image/random')));
  //
  //   final response = await client.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  //   expect(response.statusCode, 200);
  //   expect(response.body, isNotEmpty);
  // });

  /// IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // testWidgets('Refresh button reloads image', (WidgetTester tester) async {
  //   final client = MockClient();
  //   when(client.get(Uri.parse('https://dog.ceo/api/breeds/image/random')));
  //   await tester.pumpWidget(MaterialApp(home: ImageLoader()));
  //
  //   final refreshButton = find.byType(ElevatedButton);
  //   expect(refreshButton, findsOneWidget);
  //
  //   await tester.tap(refreshButton);
  //   await tester.pumpAndSettle();
  //
  //   final image = find.byType(Image);
  //   expect(image, findsOneWidget);
  // }

  // testWidgets('ImageLoader widget renders correctly', (WidgetTester tester) async {
  //   final client = MockClient();
  //     when(client.get(Uri.parse('https://dog.ceo/api/breeds/image/random')));
  //
  //
  //   await tester.pumpWidget(MaterialApp(home: ImageLoader()));
  //
  //   expect(find.text('Image Loader'), findsOneWidget);
  //   expect(find.byType(Image), findsOneWidget);
  //   expect(find.byType(ElevatedButton), findsOneWidget);
  // });
}
