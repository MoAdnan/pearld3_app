part of 'network_cubit.dart';

 class NetworkState extends Equatable {
   String status;
   factory NetworkState.initial(){
     return NetworkState(status:'initial');
   }
   NetworkState({required this.status});

   @override
   List<Object> get props => [status];

   @override
   String toString() {
     return 'NetworkState{status: $status}';
   }
   NetworkState copyWith({
     String? status,
   }) {
     return NetworkState(
       status: status ?? this.status,
     );
   }
 }
