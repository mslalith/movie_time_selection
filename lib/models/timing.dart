import 'package:flutter/material.dart' show required;

class Timing {
  final DateTime time;
  final double price;
  final bool disabled;

  const Timing({
    @required this.time,
    @required this.price,
    @required this.disabled,
  });
}

final List<Timing> timings = <Timing>[
  Timing(
    time: DateTime(0, 0, 0, 11, 0, 0, 0, 0),
    price: 50.0,
    disabled: false,
  ),
  Timing(
    time: DateTime(0, 0, 0, 11, 30, 0, 0, 0),
    price: 50.0,
    disabled: false,
  ),
  Timing(
    time: DateTime(0, 0, 0, 12, 0, 0, 0, 0),
    price: 50.0,
    disabled: false,
  ),
  Timing(
    time: DateTime(0, 0, 0, 12, 30, 0, 0, 0),
    price: 50.0,
    disabled: false,
  ),
  Timing(
    time: DateTime(0, 0, 0, 13, 0, 0, 0, 0),
    price: 70.0,
    disabled: false,
  ),
  Timing(
    time: DateTime(0, 0, 0, 13, 30, 0, 0, 0),
    price: 70.0,
    disabled: false,
  ),
  Timing(
    time: DateTime(0, 0, 0, 14, 0, 0, 0, 0),
    price: 70.0,
    disabled: true,
  ),
  Timing(
    time: DateTime(0, 0, 0, 14, 30, 0, 0, 0),
    price: 70.0,
    disabled: true,
  ),
  Timing(
    time: DateTime(0, 0, 0, 15, 0, 0, 0, 0),
    price: 70.0,
    disabled: false,
  ),
  Timing(
    time: DateTime(0, 0, 0, 15, 30, 0, 0, 0),
    price: 70.0,
    disabled: true,
  ),
  Timing(
    time: DateTime(0, 0, 0, 16, 0, 0, 0, 0),
    price: 70.0,
    disabled: false,
  ),
  Timing(
    time: DateTime(0, 0, 0, 15, 30, 0, 0, 0),
    price: 70.0,
    disabled: false,
  ),
];
