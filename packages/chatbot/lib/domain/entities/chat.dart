import 'package:chatbot/domain/entities/prediction.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Chat extends Equatable {
  Chat({
    required this.text,
    this.image,
    this.prediction,
    this.isReceive = true,
    this.isLoading = false,
  });

  final String text;
  final Widget? image;
  final Prediction? prediction;
  final bool isReceive;
  final bool isLoading;
  final DateTime createdAt = DateTime.now();

  @override
  List<Object?> get props => [
        text,
        image,
        prediction,
        isReceive,
        isLoading,
        createdAt,
      ];
}
