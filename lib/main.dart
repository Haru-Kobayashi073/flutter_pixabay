import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PixabayPage(),
    );
  }
}

class PixabayPage extends StatefulWidget {
  const PixabayPage({super.key});

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {
  List hits = [];

  Future<void> fetchImages({required String text}) async {
    Response response = await Dio().get(
        "https://pixabay.com/api/?key=32688940-599bdd8b91299e2e22675b480&q=$text&image_type=photo&per_page=100");
    hits = response.data['hits'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //最初に一度だけ呼ばれる
    fetchImages(text: "programing");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextFormField(
            initialValue: "programing",
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
            ),
            onFieldSubmitted: (text) {
              print(text);
              fetchImages(text: text);
            },
          ),
          backgroundColor: Colors.cyan),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: hits.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> hit = hits[index];
            return Image.network(hit['previewURL']);
          }),
    );
  }
}
