import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageIndicator extends Notifier<int> {
  late final PageController _controller;
  @override
  int build() {
    _controller = PageController();
    return 0;
  }

  void onPageChange(int value) {
    state = value;
  }

  void onSkipTap(int value) {
    _controller.animateToPage(
      value,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goToNextPage(int value) {
    _controller.animateToPage(
      value,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  PageController get pageController => _controller;
}

final pageIndicatorProvider =
    NotifierProvider<PageIndicator, int>(PageIndicator.new);
