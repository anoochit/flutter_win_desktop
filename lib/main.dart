import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await SystemTheme.accentInstance.load();
    await flutter_acrylic.Window.initialize();
  }

  runApp(const MyApp());

  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = const Size(755, 545);
    //win.size = const Size(755, 545);
    win.alignment = Alignment.center;
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //accentColor: SystemTheme.accentInstance.accent.toAccentColor(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        typography: const Typography(
          caption: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: _currentIndex,
        onChanged: (i) => setState(() => _currentIndex = i),
        displayMode: PaneDisplayMode.auto,
        size: const NavigationPaneSize(
          openMinWidth: 200,
          openMaxWidth: 250,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('PaneItem 1'),
            infoBadge: const InfoBadge(
              source: Text('9'),
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('PaneItem 2'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('PaneItem 3'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('PaneItem 4'),
          ),
        ],
        footerItems: [
          PaneItemAction(
            icon: const Icon(FluentIcons.open_source),
            title: const Text('PaneItemAction'),
            onTap: () {},
          ),
        ],
      ),
      content: NavigationBody(
        index: _currentIndex,
        children: const [
          ScaffoldPage(
            header: PageHeader(title: Text("Page 1")),
          ),
          ScaffoldPage(
            header: PageHeader(title: Text("Page 2")),
          ),
          ScaffoldPage(
            header: PageHeader(title: Text("Page 3")),
          ),
          ScaffoldPage(
            header: PageHeader(title: Text("Page 4")),
          ),
        ],
      ),
    );
  }
}
