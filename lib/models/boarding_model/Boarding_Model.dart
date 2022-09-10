class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({this.image, this.body, this.title});
}
List<BoardingModel> boarding = [
  BoardingModel(
    image: 'images/onBoardingfirst.png',
    title: 'Get a today weather forecast',
    body:
    'The coldest temperature ever officially recorded was -89.2°C. Brrrr!',
  ),
  BoardingModel(
    image: 'images/onBoardingsecond.png',
    title: 'If it rains , you will be the first one to know',
    body:
    'Raindrops can be the size of a housefly and fall at more than 30kmph.',
  ),
];