import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class StudentInfo extends StatelessWidget {
  const StudentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: <Widget>[
          Text(
            'Dayinta Palupi Tyas Seta',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            '222410102080',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
   _TimerPageState createState() => _TimerPageState(); //pengatur waktu dengan fungsi putaran, berhenti, setel ulang, dan mulai.
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer; //pengatur waktu
  final myController = TextEditingController(); //untuk mengendalikan input teks pada widget atau widget lain yang membutuhkan
  
  int _time = 0;
  String _status = 'start';

  void startTimer(int minutes) { //memulai waktu
    _time = minutes * 60;
    
    const oneSec = Duration(seconds: 1); //durasi waktu
    
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_time < 1) {
            timer.cancel();
            _status = 'stopped';
          } else {
            _time = _time - 1;
            _status = 'running';
          }
        },
      ),
    );
  }

  void stopTimer() { //menghentikan timer
    _timer.cancel();

    setState(() {
      _status = 'stopped';
    });
  }

  void resetTimer() { //mengatur ulang timer
    stopTimer();

    setState(() {
      _time = 0; //memasukkan waktu yang diinginkan
      _status = 'start';
    });
  }

  String formatTime(int seconds) {
    int minute = seconds ~/ 60;
    int second = seconds % 60;

    if (seconds <= 0) {
      return 'Waktu Habis';
    } else {
      return '${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}'; //untuk menghasilkan string yag menunjukkan waktu yang dimana menit dan detik selalu memiliki dua digit dengan angka not yang ditambahkan didepan jika perlu
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //fungsi dasar untuk mengatur tata letak
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const StudentInfo(),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(0, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(bottom: 16.0),
              padding: const EdgeInsets.all(16.0), //untuk mengatur jarak disetiap sisi
              child: Column(
                children: <Widget>[
                  if (_status != 'start' )
                    Text(
                      formatTime(_time),
                      style: Theme.of(context).textTheme.headlineMedium, //untuk mengatur gaya text pada widget
                      textAlign: TextAlign.center, //mengatur penataan pada text
                    ),
                  if (_status == 'start')
                    TextField(
                      controller: myController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Masukkan jumlah menit',
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
            if (_status == 'start')
              ElevatedButton(
                onPressed: () {
                  startTimer(int.parse(myController.text)); //memulai timer
                },
                child: const Text('Mulai'),
              ),
            if (_status == 'running')
              ElevatedButton(
                onPressed: () {
                  stopTimer();
                },
                child: const Text('Berhenti'),
              ),
            if (_status == 'stopped')
              ElevatedButton(
                onPressed: () {
                  resetTimer();
                },
                child: const Text('Atur ulang'),
              ),
          ],
        ),
      ),
    );
  }
}

