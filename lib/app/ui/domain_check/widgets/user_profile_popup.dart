import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/assets.dart';

class UserProfilePopup extends StatelessWidget {
  final String username;
  final String location;
  final VoidCallback? onLogout;

  const UserProfilePopup({
    super.key,
    required this.username,
    required this.location,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 11),
            

            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200, width: 2),
              ),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.userAvatar,
                  width: 76,
                  height: 76,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('头像加载失败: $error');
                    return Container(
                      width: 76,
                      height: 76,
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 5),
            

            Text(
              username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            
            const SizedBox(height: 4),
            

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 33,
                child: ElevatedButton(
                  onPressed: onLogout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromRGBO(34, 103, 244, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    elevation: 0,
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logout.png',
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(width: 4),
                      const Text(
                        '退出登录',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }


  static void show(
    BuildContext context, {
    required String username,
    required String location,
    VoidCallback? onLogout,
    Offset? position,
  }) {
    print('开始显示用户弹窗');


    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext dialogContext) {
        return Stack(
          children: [

            Positioned(
              top: 52,
              right:  12 ,
              child: Material(
                color: Colors.transparent,
                child: UserProfilePopup(
                  username: username,
                  location: location,
                  onLogout: () {
                    print('点击退出登录');
                    Navigator.of(dialogContext).pop();
                    onLogout?.call();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
