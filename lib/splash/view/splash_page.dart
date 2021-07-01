import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: Scaffold(
        body: MyRiveAnimation(),
      ),
    );
  }
}

class MyRiveAnimation extends StatefulWidget {


  @override
  _MyRiveAnimationState createState() => _MyRiveAnimationState();
}

class _MyRiveAnimationState extends State<MyRiveAnimation> {
  // final riveFileName = 'assets/truck.riv';
  final riveFileName = 'assets/trivia_expert.riv';

  Artboard? _artboard;
  RiveAnimationController? _wipersController;

  bool _wipers = false;


  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  void _loadRiveFile() async {
    // final bytes = await rootBundle.load(riveFileName);
    rootBundle.load(riveFileName).then(
            (data) async {
              final file = RiveFile.import(data);
              final artboard = file.mainArtboard;
              artboard.addController(SimpleAnimation('fall_in_line'));
              setState(() => _artboard = artboard);
            });
    // final file = RiveFile.import(bytes);
    


  }

  void _wipersChange(bool wipersOn) {
    if(_wipersController == null) {
      _artboard!.addController(
        _wipersController = SimpleAnimation('windshield_wipers'),
      );
    }
    setState(() => _wipersController!.isActive = _wipers = wipersOn);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: _artboard !=  null
              ? Rive(
            artboard: _artboard!,
            fit: BoxFit.cover,
          )
              : Container(),
        ),
        // SizedBox(
        //   height: 50,
        //   width: 200,
        //   child: SwitchListTile(
        //     title: const Text('Wipers'),
        //     value: _wipers,
        //     onChanged: _wipersChange,
        //   ),
        // )
      ],
    );

  }
}
