// import 'package:cae/Constants/Constants.dart';
// import 'package:cae/Constants/Styles.dart';
// import 'package:cae/Models/CompetationTypesModel.dart';
// import 'package:cae/Provider/AppConstants.dart';
// import 'package:cae/Screens/AddCompetation.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
//
// class SelectCompetationType extends StatefulWidget {
//   const SelectCompetationType({Key? key}) : super(key: key);
//
//   @override
//   _SelectCompetationTypeState createState() => _SelectCompetationTypeState();
// }
//
// class _SelectCompetationTypeState extends State<SelectCompetationType> {
//   List<CompetationTypeModel> dashBoardList = [];
//
//   @override
//   void initState() {
//     CompetationTypeModel firstItem = CompetationTypeModel(
//         index: 0,
//         icon: FontAwesomeIcons.weightHanging,
//         subtile: 'Weight',
//         title: '');
//     CompetationTypeModel secondItem = CompetationTypeModel(
//         index: 1,
//         icon: FontAwesomeIcons.university,
//         subtile: 'Savings',
//         title: '');
//     CompetationTypeModel thirdItem = CompetationTypeModel(
//         index: 2, icon: Icons.school, subtile: 'Finance', title: '');
//     CompetationTypeModel fourthItem = CompetationTypeModel(
//         index: 3,
//         icon: FontAwesomeIcons.certificate,
//         subtile: 'Certifications',
//         title: '');
//     CompetationTypeModel fifthItem = CompetationTypeModel(
//         index: 4,
//         icon: Icons.sports_baseball,
//         subtile: 'Sports',
//         title: 'Total');
//     dashBoardList.add(firstItem);
//     dashBoardList.add(secondItem);
//     dashBoardList.add(thirdItem);
//     dashBoardList.add(fourthItem);
//     dashBoardList.add(fifthItem);
//     setState(() {});
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var appConstants = Provider.of<AppConstants>(context, listen: true);
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: height * 0.25,
//               decoration: BoxDecoration(
//                 color: payScreenUperColor.withOpacity(0.4),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: height * 0.04,
//                       width: width,
//                     ),
//                     InkWell(
//                         onTap: () {},
//                         child: Icon(
//                           Icons.arrow_back,
//                           color: white,
//                         )),
//                     const Spacer(),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Text(
//                         'Select Competation Type',
//                         style: textStyleHeading1(width * 0.7, whiteColor: 1),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             GridView.count(
//                 crossAxisCount: 3,
//                 childAspectRatio: (2 / 2),
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 children: dashBoardList
//                     .map((e) => InkWell(
//                         onTap: () async {
//                           appConstants.updatedCompetitionTypeName(e.subtile);
//                           appConstants
//                               .updatedSelectedIndexCompetationType(e.index);
//                           //  if (e.index==0) {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const AddCompetator()));
//                           //  }
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           color:
//                               appConstants.selectCompetitionTypeIndex == e.index
//                                   ? primaryColor
//                                   : white,
//                           elevation: 2,
//                           child: SizedBox(
//                             height: height * 0.2,
//                             //color: yellow,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Center(
//                                   child: Icon(
//                                     e.icon,
//                                     size: width * 0.12,
//                                     color: appConstants
//                                                 .selectCompetitionTypeIndex ==
//                                             e.index
//                                         ? white
//                                         : black,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 4.0),
//                                   child: Text(
//                                     '${e.subtile}',
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                         color: appConstants
//                                                     .selectCompetitionTypeIndex ==
//                                                 e.index
//                                             ? white
//                                             : black,
//                                         fontSize: width * 0.042,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )))
//                     .toList()),
//           ],
//         ),
//       ),
//     );
//   }
// }
