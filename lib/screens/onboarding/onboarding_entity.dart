
class OnBoardingEntity {
  //final String? image;
  final String? title;
  final String? description;

  OnBoardingEntity({this.title, this.description});//this.image,

  static List<OnBoardingEntity> onBoardingData = [
    OnBoardingEntity(
        //image: "location.png",
        title: "On demand & runtime\nlocation",
        description: "Pick from your location at\nyour preferred date\nand time."
    ),
    OnBoardingEntity(
        //image: "time.png",
        title: "Anything, anytime,\nanywhere.",
        description: "Whether it's a parcel, a cheque or\nan important doc, we'll parcel."
    ),
    OnBoardingEntity(
        //image: "car.jfif",
        title: "Live track\nyour shipments",
        description: "See a realtime view of your courier\non the map on the day of delivery."
    ),
  ];
}