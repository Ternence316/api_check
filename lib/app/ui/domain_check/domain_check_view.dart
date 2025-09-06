import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/assets.dart';
import '../../routes/app_pages.dart';
import 'domain_check_controller.dart';
import 'widgets/user_profile_popup.dart';

class DomainCheckView extends GetView<DomainCheckController> {
  const DomainCheckView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppAssets.loginBg, fit: BoxFit.cover),
          Container(
            child: SafeArea(
              child: Column(
                children: [
                  // 顶部导航栏
                  _buildTopBar(),

                  // 标签页切换
                  _buildTabBar(),


                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: PageView(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        children: [
                          _buildTodayTaskPage(),
                          _buildRecordPage(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [

          Row(
            children: [
              Image.asset(
                AppAssets.apiCheck,
                height: 25,
                fit: BoxFit.fill,
              ),
            ],
          ),
          
          const Spacer(),
          

          Builder(
            builder: (BuildContext ctx) => GestureDetector(
              onTap: () {
                print('点击了用户信息区域');
                final RenderBox renderBox = ctx.findRenderObject() as RenderBox;
                final Offset position = renderBox.localToGlobal(Offset.zero);
                final Size size = renderBox.size;

                _showUserProfilePopup(
                  ctx,
                  position: Offset(
                    position.dx + size.width, // 用户区域右边缘
                    position.dy + size.height - 2,
                  ),
                );
              },
              child: Row(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppAssets.userAvatar,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 18,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() => Text(
                  controller.username.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => _buildTabButton(
              '今日任务',
              0,
              controller.currentTabIndex.value == 0,
            )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(() => _buildTabButton(
              '检测记录',
              1,
              controller.currentTabIndex.value == 1,
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.switchTab(index),
      child: Container(
        height: 39,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color.fromRGBO(255, 255, 255, 0.2),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF4A90E2) : const Color.fromRGBO(255, 255, 255, 0.4),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodayTaskPage() {
    return Column(
      children: [
        _buildStatsSection(),
        Expanded(
          child: _buildDomainList(),
        ),
      ],
    );
  }

  Widget _buildRecordPage() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          '检测记录',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: _buildStatItem(
              '今日待检测 : ',
              controller.todayWaitingCount,
              const Color(0xFFFF9500),
              AppAssets.preTest,
            ),
          ),
          Container(
            width: 0.5,
            height: 15,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: _buildStatItem(
              '今日已检测 : ',
              controller.todayCompletedCount,
              const Color.fromRGBO(85, 112, 204, 1),
              AppAssets.testFinish,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, RxInt count, Color color, String iconAsset) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          iconAsset,
          width: 13,
          height: 13,
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style:  const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 4),
        Obx(() => Text(
          count.value.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        )),
      ],
    );
  }

  Widget _buildDomainList() {
    return Obx(() => MediaQuery.removePadding(
      context: Get.context!,
      removeTop: true,
      child: ListView.builder(
        itemCount: controller.domainList.length,
        itemBuilder: (context, index) {
          final domain = controller.domainList[index];
          return _buildDomainItem(domain, index);
        },
      ),
    ));
  }

  Widget _buildDomainItem(DomainItem domain, int index) {
    Color linkColor = domain.status == DomainStatus.waiting
        ? const Color(0xFFFF9500)
        : const Color(0xFF4A90E2);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  domain.url,
                  style: TextStyle(
                    fontSize: 15,
                    color: linkColor,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              _buildStatusButton(domain, index),
            ],
          ),
        ),

        if (index < controller.domainList.length - 1)
          Container(
            height: 0.5,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.grey.shade300,
          ),
      ],
    );
  }

  Widget _buildStatusButton(DomainItem domain, int index) {
    switch (domain.status) {
      case DomainStatus.waiting:
        return ElevatedButton(
          onPressed: () => controller.startCheck(index),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF9500),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 0,
            minimumSize: const Size(80, 40),
          ),
          child: const Text(
            '开始检测',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        );
      case DomainStatus.checking:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF34C759),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 8),
              Text(
                '检测中',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      case DomainStatus.completed:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color:  const Color.fromRGBO(35, 103, 239, 1),
            borderRadius: BorderRadius.circular(25),
          ),
          constraints: const BoxConstraints(minWidth: 80, minHeight: 40),
          child: const Center(
            child: Text(
              '检测完成',
              style: TextStyle(fontSize: 12, color: Colors.white , fontWeight: FontWeight.w600),
            ),
          ),
        );
    }
  }

  void _showUserProfilePopup(BuildContext context, {Offset? position}) {
    print('_showUserProfilePopup 被调用');
    try {

      UserProfilePopup.show(
        context,
        username: controller.username.value,
        location: '广东广州',
        position: position,
        onLogout: () {
          Get.snackbar(
            '提示',
            '退出登录成功',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 1),
          );


          Future.delayed(const Duration(seconds: 1), () {
            Get.offAllNamed(Routes.login);
          });
        },
      );
    } catch (e) {
      print('显示弹窗时出错: $e');
    }
  }
}
