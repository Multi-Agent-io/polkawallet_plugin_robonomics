import 'package:flutter/material.dart';

const int SECONDS_OF_DAY = 24 * 60 * 60; // seconds of one day
const int SECONDS_OF_YEAR = 365 * 24 * 60 * 60; // seconds of one year

const node_list_robonomics = [
  {
    'name': 'Robonomics (via Airalab)',
    'ss58': 32,
    'endpoint': 'wss://kusama.rpc.robonomics.network',
  },
];

const MaterialColor robonomics_black = const MaterialColor(
  0xFF222222,
  const <int, Color>{
    50: const Color(0xFF555555),
    100: const Color(0xFF444444),
    200: const Color(0xFF444444),
    300: const Color(0xFF333333),
    400: const Color(0xFF333333),
    500: const Color(0xFF222222),
    600: const Color(0xFF111111),
    700: const Color(0xFF111111),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  },
);

const String genesis_hash_robonomics =
    '0x00000000000000000000000000000000000000000000000000000000000000000095fdc6a85cbd30a0c29e336430a9d6bd2cfc3d2592c6abf63f2aee8dcde746b903170a2e7597b7b7e3d84c05391d139a62b157e78786d8c082f29dcf4c11131400';
