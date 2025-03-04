import 'dart:ui';
import 'package:flutter/material.dart';

class QuickActionCard{
final String title;
final VoidCallback onTap;
final String mediaUrl;
final IconData icon;

QuickActionCard({
  required this.title,
  required this.onTap,
  required this.mediaUrl,
  required this.icon,
});
}