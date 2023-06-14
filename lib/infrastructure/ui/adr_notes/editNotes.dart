

// class EditarNotaTwoScreen extends GetWidget<EditarNotaTwoController> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: ColorConstant.indigo50,
//             appBar: CustomAppBar(
//                 height: getVerticalSize(59),
//                 leadingWidth: 50,
//                 leading: AppbarImage(
//                     height: getSize(30),
//                     width: getSize(30),
//                     svgPath: ImageConstant.imgArrowleft,
//                     margin: getMargin(left: 20, top: 7, bottom: 20),
//                     onTap: () {
//                       onTapArrowleft3();
//                     }),
//                 title: AppbarImage(
//                     height: getSize(44),
//                     width: getSize(44),
//                     svgPath: ImageConstant.imgCheck,
//                     margin: getMargin(left: 30)),
//                 actions: [
//                   AppbarImage(
//                       height: getSize(33),
//                       width: getSize(33),
//                       svgPath: ImageConstant.imgTag,
//                       margin: getMargin(left: 36, top: 24)),
//                   AppbarImage(
//                       height: getSize(33),
//                       width: getSize(33),
//                       svgPath: ImageConstant.imgBell,
//                       margin: getMargin(left: 6, top: 21, right: 36, bottom: 3))
//                 ]),
//             body: Container(
//                 width: double.maxFinite,
//                 padding: getPadding(left: 3, top: 95, right: 3),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                           padding: getPadding(left: 28),
//                           child: Text("lbl_mi_primera_nota".tr,
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.left,
//                               style: AppStyle.txtRubikRomanBold36)),
//                       Align(
//                           alignment: Alignment.centerRight,
//                           child: Container(
//                               height: getVerticalSize(51),
//                               width: getHorizontalSize(335),
//                               margin: getMargin(top: 20, right: 6),
//                               child: Stack(
//                                   alignment: Alignment.bottomLeft,
//                                   children: [
//                                     Align(
//                                         alignment: Alignment.bottomCenter,
//                                         child: Padding(
//                                             padding: getPadding(bottom: 22),
//                                             child: SizedBox(
//                                                 width: getHorizontalSize(335),
//                                                 child: Divider(
//                                                     height: getVerticalSize(1),
//                                                     thickness:
//                                                         getVerticalSize(1),
//                                                     color: ColorConstant
//                                                         .whiteA70099)))),
//                                     Align(
//                                         alignment: Alignment.bottomLeft,
//                                         child: Container(
//                                             width: getHorizontalSize(234),
//                                             child: Text(
//                                                 "msg_curabitur_venenatis2".tr,
//                                                 maxLines: null,
//                                                 textAlign: TextAlign.left,
//                                                 style:
//                                                     AppStyle.txtRubikLight10))),
//                                     Align(
//                                         alignment: Alignment.topRight,
//                                         child: Padding(
//                                             padding: getPadding(right: 158),
//                                             child: SizedBox(
//                                                 height: getVerticalSize(25),
//                                                 child: VerticalDivider(
//                                                     width: getHorizontalSize(1),
//                                                     thickness:
//                                                         getVerticalSize(1),
//                                                     color: ColorConstant
//                                                         .whiteA700))))
//                                   ]))),
//                       Spacer(),
//                       Padding(
//                           padding: getPadding(right: 36, bottom: 129),
//                           child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CustomImageView(
//                                     svgPath: ImageConstant.imgMicrophoneBlue400,
//                                     height: getVerticalSize(30),
//                                     width: getHorizontalSize(28),
//                                     margin: getMargin(top: 6, bottom: 3)),
//                                 CustomImageView(
//                                     svgPath: ImageConstant.imgCamera,
//                                     height: getVerticalSize(31),
//                                     width: getHorizontalSize(36),
//                                     margin:
//                                         getMargin(left: 9, top: 5, bottom: 3)),
//                                 CustomImageView(
//                                     svgPath: ImageConstant.imgPhotograph,
//                                     height: getSize(37),
//                                     width: getSize(37),
//                                     margin: getMargin(left: 9, top: 2)),
//                                 CustomImageView(
//                                     svgPath: ImageConstant.imgTrash,
//                                     height: getVerticalSize(29),
//                                     width: getHorizontalSize(33),
//                                     margin:
//                                         getMargin(left: 50, top: 2, bottom: 8)),
//                                 CustomImageView(
//                                     svgPath: ImageConstant.imgMenu,
//                                     height: getVerticalSize(26),
//                                     width: getHorizontalSize(20),
//                                     margin:
//                                         getMargin(left: 24, top: 4, bottom: 9)),
//                                 CustomImageView(
//                                     svgPath: ImageConstant.imgMaximize,
//                                     height: getVerticalSize(31),
//                                     width: getHorizontalSize(24),
//                                     margin: getMargin(left: 25, bottom: 8)),
//                                 CustomImageView(
//                                     svgPath: ImageConstant.imgMicrophone,
//                                     height: getVerticalSize(29),
//                                     width: getHorizontalSize(20),
//                                     margin:
//                                         getMargin(left: 18, top: 1, bottom: 9))
//                               ]))
//                     ]))));
//   }

//   onTapArrowleft3() {
//     Get.back();
//   }
// }