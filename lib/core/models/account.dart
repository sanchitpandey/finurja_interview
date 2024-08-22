class Account {
  final String id;
  final String name;
  final String accountNumber;
  final String bankIcon;

  Account({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.bankIcon,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      name: json['name'],
      accountNumber: json['accountNumber'],
      bankIcon: json['bankIcon'],
    );
  }
}
