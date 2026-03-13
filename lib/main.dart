import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext ctx) => MaterialApp(
    title: 'ويميز',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00e5ff)), useMaterial3: true),
    home: const WebScreen(),
  );
}

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});
  @override State<WebScreen> createState() => _WS();
}

class _WS extends State<WebScreen> {
  late final WebViewController _c;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    _c = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (_) => setState(() => _loading = false)))
      ..loadRequest(Uri.parse('https://store-dz-10587.web.app/'));
  }
  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(
      title: const Text('ويميز'),
      backgroundColor: const Color(0xFF00e5ff),
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    body: Stack(children: [
      WebViewWidget(controller: _c),
      if (_loading) const Center(child: CircularProgressIndicator()),
    ]),
  );
}