import 'package:expensetrackermobileapp/constants/text_styles.dart';
import 'package:expensetrackermobileapp/controller/auth_controller.dart';
import 'package:expensetrackermobileapp/utils/bottom_sheet_for_picking_image.dart';
import 'package:expensetrackermobileapp/utils/logout_dialogbox.dart';
import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ListView(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 60,
                ),
                SizedBox(
                  width: size.width * 0.08,
                ),
                Flexible(
                  child: Text(
                    auth.currentUser!.email ?? "Guest",
                    style: userProfileNameStyle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.account_balance_wallet_sharp,
                      size: 30,
                    ),
                    title: Text(
                      "Account",
                      style: listTileTextStyle,
                    ),
                    onTap: () {},
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    title: Text(
                      "Settings",
                      style: listTileTextStyle,
                    ),
                    onTap: () {
                      BottomSheetForImagePicking.bottomSheet(context);
                    },
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.ios_share,
                      size: 30,
                    ),
                    title: Text(
                      "Export",
                      style: listTileTextStyle,
                    ),
                    onTap: () {
                      ReusableSnackBar.showSnackBar(
                          context, "This feature is not currently available");
                    },
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    title: Text(
                      "Logout",
                      style: listTileTextStyle,
                    ),
                    onTap: () {
                      LogoutDialogBox.askForLogout(context);
                    },
                    leading: const Icon(
                      Ionicons.log_out_outline,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
