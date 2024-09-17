class HomeModel {
  String? name;
  String? image_path;
  HomeModel({this.name, this.image_path});
}

List<HomeModel> list_home = [
  HomeModel(name: "Quran", image_path: "images/4.png"),
  HomeModel(name: "Hadith", image_path: "images/Rectangle5.png"),
  HomeModel(name: "Azkar", image_path: "images/Rectangle6.png"),
  HomeModel(name: "Duhaa", image_path: "images/Rectangle7.png"),
  HomeModel(name: "Tasbih", image_path: "images/Rectangle8.png"),
];
