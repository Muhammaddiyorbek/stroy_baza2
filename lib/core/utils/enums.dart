enum SectionEnum{
  base(name: "Stroy Baza №1", icon: "assets/images/stroy.png", branch: 0),
  mebel(name: "Mebel", icon: "assets/images/mebel.png", branch: 1),
  klinker(name: "Gold Klinker", icon: "assets/images/klinker.png", branch: 2);

  final String name;
  final String icon;
  final int branch;
  const SectionEnum({required this.name, required this.icon, required this.branch});
}
