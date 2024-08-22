import 'package:nationremit/constants/common_constants.dart';

class OnboardSliderModel{
   String? image;

// images given
  OnboardSliderModel({this.image});

// setter for image
  void setImage(String getImage){
    image = getImage;
  }

// getter for image
  String? getImage(){
    return image;
  }
}
List<OnboardSliderModel> getSlides(){
  List<OnboardSliderModel> slides = <OnboardSliderModel>[];
  OnboardSliderModel onboardSliderModel = new OnboardSliderModel();

// 1
  onboardSliderModel.setImage(AssetsConstant.onBoardPage_1st_img);
  slides.add(onboardSliderModel);

  onboardSliderModel = new OnboardSliderModel();

// 2
  onboardSliderModel.setImage(AssetsConstant.onBoardPage_2nd_img);
  slides.add(onboardSliderModel);

  onboardSliderModel = new OnboardSliderModel();

// 3
  onboardSliderModel.setImage(AssetsConstant.onBoardPage_3rd_img);
  slides.add(onboardSliderModel);

  onboardSliderModel = new OnboardSliderModel();
  return slides;
}
