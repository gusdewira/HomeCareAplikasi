class Register {
    int id;
    String firstName;
    String lastName;
    String username;
    String email;
    String numberPhone;
    String address;
    List<String> role;

    Register({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.numberPhone,
        required this.address,
        required this.role,
    });

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        numberPhone: json["number_phone"],
        address: json["address"],
        role: List<String>.from(json["role"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "number_phone": numberPhone,
        "address": address,
        "role": List<dynamic>.from(role.map((x) => x)),
    };
}