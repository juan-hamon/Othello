import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This is a [Map] of [StateProvider<int>] and it's used to store,
/// for each player id, it's selected color, represented as a
/// number (1 -> White, 2 -> Black). This in order to know which
/// color at which card should be highlighted in the UI.
final Map<int, StateProvider<int>> selectedOptionProviders = {
  1: StateProvider<int>((ref) => 0),
  2: StateProvider<int>((ref) => 0)
};

/// This is a [Map] of [StateProvider<Color>] and it's used to
/// store, for each player id, the color selected by a player.
final Map<int, StateProvider<Color>> selectedColorProviders = {
  1: StateProvider<Color>((ref) => Colors.transparent),
  2: StateProvider<Color>((ref) => Colors.transparent)
};

/// This is a [Map] of [StateProvider<String>] and it's used to
/// store each player names.
final Map<int, StateProvider<String>> namesProviders = {
  1: StateProvider<String>((ref) => ""),
  2: StateProvider<String>((ref) => "")
};
