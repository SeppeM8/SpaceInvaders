import 'dart:math';

import 'package:flame/components.dart';

Vector2 vectorFromAngle(double angle) {
  return Vector2(sin(angle), -cos(angle));
}

double length(Vector2 vector) {
  return sqrt(vector.x * vector.x + vector.y * vector.y);
}

double angleBetween(Vector2 a, Vector2 b) {
  return atan2(b.x - a.x, -(b.y - a.y));
}
