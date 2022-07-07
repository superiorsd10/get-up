import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:animated_background/animated_background.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ParticleOptions particles = const ParticleOptions(
    baseColor: Colors.yellowAccent,
    spawnOpacity: 0.5,
    opacityChangeRate: 0.5,
    minOpacity: 0.3,
    maxOpacity: 0.6,
    particleCount: 100,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );

  @override
  TimeOfDay _time = TimeOfDay.now().replacing(hour: 07, minute: 30);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF001432),
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(options: particles),
        child: Center(
          child: AnimateGradient(
            primaryColors: [
              Colors.lightBlueAccent.shade200,
              Colors.lightBlueAccent.shade400,
              Colors.lightBlueAccent.shade700,
            ],
            secondaryColors: const [
              Color(0x0F001432),
              Color(0xF0001432),
              Color(0xFF001432),
            ],
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GradientText(
                    _time.format(context),
                    colors: const [
                      Color(0xFFFFA82A),
                      Color(0xFFEED52C),
                      Color(0xFFFFFFFF),
                    ],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 66.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProBold',
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: _time,
                          iosStylePicker: true,
                          onChange: onTimeChanged,
                          minuteInterval: MinuteInterval.ONE,
                          // Optional onChange to receive value as DateTime
                          onChangeDateTime: (DateTime dateTime) {
                            // print(dateTime);
                            debugPrint("[debug datetime]:  $dateTime");
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    child: const ButtonContent(
                      title: 'TIME PICKER',
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GetUpButton(
                    time: _time,
                    title: 'SET ALARM',
                    onPressed: () {
                      FlutterAlarmClock.createAlarm(_time.hour, _time.minute);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GetUpButton(
                    time: _time,
                    title: 'SHOW ALARMS',
                    onPressed: () {
                      FlutterAlarmClock.showAlarms();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GetUpButton extends StatelessWidget {
  const GetUpButton({
    Key? key,
    required TimeOfDay time,
    required this.title,
    required this.onPressed,
  })  : _time = time,
        super(key: key);

  final TimeOfDay _time;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      child: ButtonContent(title: title),
    );
  }
}

class ButtonContent extends StatelessWidget {
  const ButtonContent({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFA82A),
            Color(0xFFEED52C),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Container(
        width: 200,
        height: 50,
        alignment: Alignment.center,
        child: BorderedText(
          strokeColor: Colors.black87,
          strokeWidth: 4.0,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              letterSpacing: 2.5,
              fontWeight: FontWeight.bold,
              fontFamily: 'SFProBold',
            ),
          ),
        ),
      ),
    );
  }
}
