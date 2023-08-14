class BlueDevice{
  String name;
  String address;

  BlueDevice({
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'address': this.address,
    };
  }

  factory BlueDevice.fromMap(Map<String, dynamic> map) {
    return BlueDevice(
      name: map['name'] as String,
      address: map['address'] as String,
    );
  }
}