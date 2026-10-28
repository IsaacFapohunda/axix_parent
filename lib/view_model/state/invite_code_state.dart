class InviteCodeState{
  final String code;
  final bool isError;
  final int countdown;
  final bool isLoading;

  const InviteCodeState({
    this.code = '',
    this.isError= false,
    this.countdown =59,
    this.isLoading = false,
});

  InviteCodeState copyWith({
     String? code,
     bool? isError,
     int? countdown,
     bool? isLoading,

  }) {
    return InviteCodeState(
      code: code ?? this.code,
      isError: isError ?? this.isError,
      countdown: countdown ?? this.countdown,
      isLoading: isLoading ?? this.isLoading
    );
  }

}