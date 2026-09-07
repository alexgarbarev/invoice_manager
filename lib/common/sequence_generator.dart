abstract class SequenceGenerator {
  const SequenceGenerator();

  factory SequenceGenerator.numeric({String prefix = '', int start = 0}) {
    return _SequenceGeneratorNumeric(prefix, start);
  }

  factory SequenceGenerator.timestamp({String prefix = ''}) {
    return _SequenceGeneratorTimestamp(prefix);
  }

  String next();
}

class _SequenceGeneratorNumeric extends SequenceGenerator {
  final String prefix;
  final int start;
  var _index = -1;

  _SequenceGeneratorNumeric([this.prefix = '', this.start = 0]);

  @override
  String next() {
    _index += 1;
    return '$prefix${_index + start}';
  }
}

class _SequenceGeneratorTimestamp extends SequenceGenerator {
  final String prefix;
  int _lastSeconds = 0;
  int _counter = 0;

  _SequenceGeneratorTimestamp(this.prefix);

  @override
  String next() {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (now == _lastSeconds) {
      _counter += 1;
    } else {
      _counter = 0;
      _lastSeconds = now;
    }
    return '$prefix${now.toRadixString(36)}$_counter';
  }
}
