import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DomainCheckController extends GetxController {

  final currentTabIndex = 0.obs;
  late PageController pageController;
  

  final todayWaitingCount = 0.obs;
  final todayCompletedCount = 0.obs;
  

  final domainList = <DomainItem>[].obs;
  

  final username = '张三'.obs;
  
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _initDomainList();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
  
  void _initDomainList() {

    domainList.value = [
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.waiting,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.waiting,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
      DomainItem(
        url: 'https://iconfontarchindexsearchT...',
        status: DomainStatus.completed,
      ),
    ];


    _updateStats();
  }

  void _updateStats() {
    todayWaitingCount.value = domainList.where((item) => item.status == DomainStatus.waiting).length;
    todayCompletedCount.value = domainList.where((item) => item.status == DomainStatus.completed).length;
  }
  

  void switchTab(int index) {
    currentTabIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int index) {
    currentTabIndex.value = index;
  }
  

  void startCheck(int index) {
    if (domainList[index].status == DomainStatus.waiting) {
      domainList[index].status = DomainStatus.checking;
      domainList.refresh();
      

      Future.delayed(const Duration(seconds: 2), () {
        domainList[index].status = DomainStatus.completed;
        domainList.refresh();
        

        _updateStats();
      });
    }
  }
}


class DomainItem {
  String url;
  DomainStatus status;
  
  DomainItem({
    required this.url,
    required this.status,
  });
}

enum DomainStatus {
  waiting,
  checking,
  completed,
}
