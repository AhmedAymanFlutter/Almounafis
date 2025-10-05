
import 'package:almonafs_flutter/features/servicepackadge/data/model/getAllcountry.dart';
import 'package:equatable/equatable.dart';


abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object> get props => [];
}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final ServicesModel services;
  final bool hasReachedMax;

  const ServicesLoaded({
    required this.services,
    this.hasReachedMax = false,
  });

  ServicesLoaded copyWith({
    ServicesModel? services,
    bool? hasReachedMax,
  }) {
    return ServicesLoaded(
      services: services ?? this.services,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [services, hasReachedMax];
}

class ServicesError extends ServicesState {
  final String message;

  const ServicesError(this.message);

  @override
  List<Object> get props => [message];
}