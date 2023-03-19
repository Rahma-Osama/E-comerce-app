class BoardingModel
{
  final String image;
  final String title;
  final String description;
  BoardingModel(this.image,this.title,this.description);
}

List<BoardingModel> boardingItems =
[
  BoardingModel("images/img.png", "ORDER ONLINE", "make your order sitting on a Sofa."),
  BoardingModel("images/img_1.png", "M-COMMERCE", "Download our application and buy using your phone or laptop"),
  BoardingModel("images/img_2.png", "DELIVERY SERVICES", "Modern delivering technologies"),
];
