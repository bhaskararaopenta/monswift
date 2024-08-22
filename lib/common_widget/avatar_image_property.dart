import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';

import '../constants/common_constants.dart';
import '../style/app_text_styles.dart';

class AvatarImage extends StatefulWidget {
  var data;

  AvatarImage(Data this.data, {key}) : super(key: key);

  @override
  State<AvatarImage> createState() => _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 30.0,
        child: SizedBox(
            child: Text(
          getInitials(widget.data!.beneFirstName.toLowerCase().capitalize()),
          style: AppTextStyles.letterTitle,
        )),
      ),
      Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            child: Image.asset(AssetsConstant.miniFlag),
            padding: EdgeInsets.all(0),
          ))
    ]);
  }
}

String getInitials(String user_name) => user_name.isNotEmpty
    ? user_name.trim().split(' ').map((l) => l[0]).take(2).join()
    : '';
