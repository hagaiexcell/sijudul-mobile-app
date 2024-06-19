import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skripsi/component/app_bar_widget.dart';
import 'package:flutter_project_skripsi/features/pengajuan/bloc/pengajuan_bloc.dart';
import 'package:flutter_project_skripsi/resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class PengajuanListPage extends StatelessWidget {
  final String type;
  PengajuanListPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _currentSearchQuery = '';

  Future<int?> _getUserId() async {
    await Future.delayed(const Duration(milliseconds: 50));
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      final Map<String, dynamic> userMap = jsonDecode(userData);
      return userMap['id'];
    }
    return null;
  }

  void _toggleSearch(BuildContext context) {
    _isSearching.value = !_isSearching.value;
    if (!_isSearching.value) {
      _searchController.clear();
      _currentSearchQuery = ''; // Clear current search query
      context
          .read<PengajuanBloc>()
          .add(const PengajuanInitialFetchEvent(isInitial: false));
    }
  }

  void _onSearchChanged(String value, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      _currentSearchQuery = value;
      context
          .read<PengajuanBloc>()
          .add(PengajuanSearchEvent(query: value, type: type));
    });
  }

  void _navigateToDetail(BuildContext context, int id) async {
    await Navigator.of(context).pushNamed('/detail-judul', arguments: id);
    // Reset the search state when returning from detail page
    _isSearching.value = false;
    _searchController.clear();
    _currentSearchQuery = '';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isSearching,
      builder: (context, isSearching, child) {
        return Scaffold(
          appBar: isSearching
              ? AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.2,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.black),
                    onPressed: () => _toggleSearch(context),
                  ),
                  title: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _onSearchChanged(value, context),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => _toggleSearch(context),
                    ),
                  ],
                )
              : AppBarWidget.defaultAppBar(
                  title: type == 'all'
                      ? 'Daftar Judul Mahasiswa'
                      : 'Riwayat Pengajuan Saya',
                  context: context,
                  onSearchTap: () => _toggleSearch(context),
                ),
          body: type == 'all'
              ? _buildAllContent(context)
              : FutureBuilder<int?>(
                  future: _getUserId(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildLoadingScreen(context);
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('No user ID found'));
                    } else {
                      final userId = snapshot.data!;
                      context.read<PengajuanBloc>().add(
                          PengajuanFetchAllByMahasiswaIdEvent(
                              id: userId, isInitial: true));
                      return BuildContent(
                        currentSearchQuery: _currentSearchQuery,
                        type: type,
                        searchController: _searchController,
                        onDetailTap: (id) => _navigateToDetail(context, id),
                      );
                    }
                  },
                ),
        );
      },
    );
  }

  Widget _buildLoadingScreen(BuildContext context) {
    return Scaffold(
      // appBar: AppBarWidget.defaultAppBar(
      //   title: "Riwayat Pengajuan Saya",
      //   context: context,
      // ),
      body: Container(
        color: Colors.white,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildAllContent(BuildContext context) {
    context
        .read<PengajuanBloc>()
        .add(const PengajuanInitialFetchEvent(isInitial: true));

    return BuildContent(
      type: type,
      searchController: _searchController,
      currentSearchQuery: _currentSearchQuery,
      onDetailTap: (id) => _navigateToDetail(context, id),
    );
  }
}

class BuildContent extends StatelessWidget {
  final String type;
  final TextEditingController searchController;
  final int? userId;
  final String currentSearchQuery;
  final Function(int) onDetailTap;

  const BuildContent({
    required this.type,
    required this.searchController,
    required this.currentSearchQuery,
    required this.onDetailTap,
    this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PengajuanBloc, PengajuanState>(
      listener: (context, state) {
        if (state is PengajuanFetchingErrorState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(state.error),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (currentSearchQuery.isNotEmpty) {
          searchController.text =
              currentSearchQuery; // Set search query in text field
          context
              .read<PengajuanBloc>()
              .add(PengajuanSearchEvent(query: currentSearchQuery, type: type));
        }
        if (state is PengajuanResetState) {
          if (type == "all") {
            context
                .read<PengajuanBloc>()
                .add(const PengajuanInitialFetchEvent(isInitial: false));
          } else if (type == "user") {
            context.read<PengajuanBloc>().add(
                PengajuanFetchAllByMahasiswaIdEvent(
                    id: userId, isInitial: false));
          }
          return const Center(child: CircularProgressIndicator());
        } else if (state is PengajuanLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PengajuanFetchingSuccessfulState) {
          return ListView.builder(
            itemCount: state.listPengajuan.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => onDetailTap(state.listPengajuan[index].id),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [AppElevation.elevationPrimary],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.listPengajuan[index].judul,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${state.listPengajuan[index].mahasiswa.name} - ${state.listPengajuan[index].mahasiswa.nim}",
                            style: const TextStyle(color: AppColors.gray700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${state.listPengajuan[index].mahasiswa.prodi} (${state.listPengajuan[index].mahasiswa.angkatan})",
                            style: const TextStyle(color: AppColors.gray700),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      "lib/resources/images/arrow-right.svg",
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
