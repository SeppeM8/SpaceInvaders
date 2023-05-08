import "dart:math";

import "package:flame/components.dart";

/// Calculate the vector from an angle.
Vector2 vectorFromAngle(double angle) {
  return Vector2(sin(angle), -cos(angle));
}

/// Calculate the angle from a vector.
double angleFromVector(Vector2 vector) {
  return atan2(vector.x, -vector.y);
}

/// Calculate the length of a vector.
double length(Vector2 vector) {
  return sqrt(vector.x * vector.x + vector.y * vector.y);
}

/// Calculate the angle between two vectors.
double angleBetween(Vector2 a, Vector2 b) {
  return atan2(b.x - a.x, -(b.y - a.y));
}
