import 'package:flutter/material.dart';
import 'package:hotel_app/core/base/base_viewmodel.dart';

/// Base View widget that connects ViewModel to UI
abstract class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({super.key});

  /// Create ViewModel instance
  T createViewModel();

  /// Build UI based on ViewModel state
  Widget buildView(BuildContext context, T viewModel);

  @override
  State<BaseView<T>> createState() => BaseViewState<T>();
}

/// Base State for BaseView
class BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late T _viewModel;

  T get viewModel => _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.createViewModel();
    _viewModel.init();
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildView(context, _viewModel);
  }
}

