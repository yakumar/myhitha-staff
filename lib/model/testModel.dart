class TestModel {
  final List veggies;

  TestModel(this.veggies);

  TestModel.fromJson(Map<String, dynamic> json) : veggies = json['veggies'];

  Map<String, dynamic> toJson() {
    return {'veggies': veggies};
  }
}
