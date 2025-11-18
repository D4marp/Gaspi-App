import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaspi_app/features/home/presentation/widgets/navigation_wrapper.dart';
import 'package:gaspi_app/features/logs/data/models/activity_log_model.dart';

class ActivityLogsPage extends ConsumerStatefulWidget {
  const ActivityLogsPage({super.key});

  @override
  ConsumerState<ActivityLogsPage> createState() => _ActivityLogsPageState();
}

class _ActivityLogsPageState extends ConsumerState<ActivityLogsPage> {
  int currentPage = 1;
  final TextEditingController searchController = TextEditingController();
  final int itemsPerPage = 8;

  // Sample data - ready for API integration
  final List<ActivityLog> allLogs = [
    ActivityLog(
      id: '1',
      action: 'Add asset cylinder Acetyline @40L',
      userName: 'Thurston Moore',
      dateTime: '03:16 | 18 Sep 2022',
      timestamp: '2022-09-18T03:16:00Z',
    ),
    ActivityLog(
      id: '2',
      action: 'Add asset cylinder Acetyline @40L',
      userName: 'Thurston Moore',
      dateTime: '03:16 | 18 Sep 2022',
      timestamp: '2022-09-18T03:16:00Z',
    ),
    ActivityLog(
      id: '3',
      action: 'Add asset cylinder Acetyline @40L',
      userName: 'Thurston Moore',
      dateTime: '03:16 | 18 Sep 2022',
      timestamp: '2022-09-18T03:16:00Z',
    ),
    ActivityLog(
      id: '4',
      action: 'Add asset cylinder Acetyline @40L',
      userName: 'Thurston Moore',
      dateTime: '03:16 | 18 Sep 2022',
      timestamp: '2022-09-18T03:16:00Z',
    ),
    ActivityLog(
      id: '5',
      action: 'Add asset cylinder Acetyline @40L',
      userName: 'Thurston Moore',
      dateTime: '03:16 | 18 Sep 2022',
      timestamp: '2022-09-18T03:16:00Z',
    ),
    ActivityLog(
      id: '6',
      action: 'Add asset cylinder Acetyline @40L',
      userName: 'Thurston Moore',
      dateTime: '03:16 | 18 Sep 2022',
      timestamp: '2022-09-18T03:16:00Z',
    ),
    ActivityLog(
      id: '7',
      action: 'Add asset cylinder Acetyline @40L',
      userName: 'Thurston Moore',
      dateTime: '03:16 | 18 Sep 2022',
      timestamp: '2022-09-18T03:16:00Z',
    ),
    ActivityLog(
      id: '8',
      action: 'Add asset cylinder Acetyline @40L',
      userName: 'Thurston Moore',
      dateTime: '03:16 | 18 Sep 2022',
      timestamp: '2022-09-18T03:16:00Z',
    ),
    ActivityLog(
      id: '9',
      action: 'Update cylinder status to Completed',
      userName: 'Sarah Johnson',
      dateTime: '02:45 | 17 Sep 2022',
      timestamp: '2022-09-17T02:45:00Z',
    ),
    ActivityLog(
      id: '10',
      action: 'Delete maintenance record',
      userName: 'Mike Lee',
      dateTime: '01:30 | 16 Sep 2022',
      timestamp: '2022-09-16T01:30:00Z',
    ),
    ActivityLog(
      id: '11',
      action: 'Export data to CSV',
      userName: 'John Smith',
      dateTime: '04:20 | 15 Sep 2022',
      timestamp: '2022-09-15T04:20:00Z',
    ),
    ActivityLog(
      id: '12',
      action: 'Update user permissions',
      userName: 'Admin User',
      dateTime: '05:10 | 14 Sep 2022',
      timestamp: '2022-09-14T05:10:00Z',
    ),
  ];

  /// Get filtered and paginated logs
  List<ActivityLog> getFilteredAndPaginatedLogs() {
    List<ActivityLog> filtered = allLogs;

    // Apply search filter
    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      filtered = filtered.where((log) {
        return log.action.toLowerCase().contains(query) ||
            log.userName.toLowerCase().contains(query);
      }).toList();
    }

    // Calculate pagination
    final int startIndex = (currentPage - 1) * itemsPerPage;
    final int endIndex = (startIndex + itemsPerPage).clamp(0, filtered.length);

    if (startIndex >= filtered.length) {
      return [];
    }

    return filtered.sublist(startIndex, endIndex);
  }

  /// Get total pages
  int getTotalPages() {
    List<ActivityLog> filtered = allLogs;

    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      filtered = filtered.where((log) {
        return log.action.toLowerCase().contains(query) ||
            log.userName.toLowerCase().contains(query);
      }).toList();
    }

    return (filtered.length / itemsPerPage).ceil();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final filteredLogs = getFilteredAndPaginatedLogs();
    final totalPages = getTotalPages();

    return NavigationWrapper(
      title: 'Activity Logs',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.024),
              Text(
                'Activity Logs',
                style: TextStyle(
                  color: const Color(0xFF101828),
                  fontSize: screenWidth * 0.052,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.10,
                  letterSpacing: -0.40,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Search bar
              Container(
                height: screenHeight * 0.045,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.035,
                  vertical: screenHeight * 0.012,
                ),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFF0F0F0),
                    ),
                    borderRadius: BorderRadius.circular(64),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: screenWidth * 0.02,
                  children: [
                    Icon(
                      Icons.search,
                      size: screenWidth * 0.045,
                      color: const Color(0xFF9C9C9C),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            currentPage = 1;
                          });
                        },
                        cursorColor: const Color(0xFF007EFF),
                        style: TextStyle(
                          color: const Color(0xFF101828),
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search at Activity Logs',
                          hintStyle: TextStyle(
                            color: const Color(0xFF9C9C9C),
                            fontSize: screenWidth * 0.03,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.12,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.024),

              // Log items
              if (filteredLogs.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
                    child: Text(
                      'No logs found',
                      style: TextStyle(
                        color: const Color(0xFF999999),
                        fontSize: 14,
                        fontFamily: 'Nunito Sans',
                      ),
                    ),
                  ),
                )
              else
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    filteredLogs.length,
                    (index) {
                      final log = filteredLogs[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.016,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: screenHeight * 0.008,
                              children: [
                                Text(
                                  log.action,
                                  style: TextStyle(
                                    color: const Color(0xFF353535),
                                    fontSize: 14,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.28,
                                  ),
                                ),
                                Text(
                                  '${log.userName} - ${log.dateTime}',
                                  style: TextStyle(
                                    color: const Color(0xFF677487),
                                    fontSize: 14,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                    letterSpacing: -0.28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Divider line
                          if (index < filteredLogs.length - 1)
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: const Color(0xFFEDEDED),
                            ),
                        ],
                      );
                    },
                  ),
                ),

              SizedBox(height: screenHeight * 0.024),

              // Pagination
              if (totalPages > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous button
                    GestureDetector(
                      onTap: currentPage > 1
                          ? () => setState(() => currentPage--)
                          : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.008,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0xFFD4DBEA),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x07090B0E),
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            )
                          ],
                        ),
                        child: Text(
                          'Previous',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF9C9C9C),
                            fontSize: screenWidth * 0.03,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.60,
                          ),
                        ),
                      ),
                    ),
                    // Page numbers
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: screenWidth * 0.012,
                      children: List.generate(
                        totalPages > 5 ? 5 : totalPages,
                        (index) {
                          int pageNum;
                          if (totalPages > 5) {
                            if (currentPage <= 3) {
                              pageNum = index + 1;
                            } else if (currentPage >= totalPages - 2) {
                              pageNum = totalPages - 4 + index;
                            } else {
                              pageNum = currentPage - 2 + index;
                            }
                          } else {
                            pageNum = index + 1;
                          }

                          return GestureDetector(
                            onTap: () =>
                                setState(() => currentPage = pageNum),
                            child: Container(
                              padding: EdgeInsets.all(
                                screenWidth * 0.01,
                              ),
                              width: screenWidth * 0.085,
                              height: screenWidth * 0.085,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: currentPage == pageNum
                                    ? const Color(0xFF007EFF)
                                    : Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                '$pageNum',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: currentPage == pageNum
                                      ? Colors.white
                                      : const Color(0xFF9C9C9C),
                                  fontSize: screenWidth * 0.03,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 1.60,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Next button
                    GestureDetector(
                      onTap: currentPage < totalPages
                          ? () => setState(() => currentPage++)
                          : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.008,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0xFFD4DBEA),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x07090B0E),
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            )
                          ],
                        ),
                        child: Text(
                          'Next',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF393D4E),
                            fontSize: screenWidth * 0.03,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.60,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              SizedBox(height: screenHeight * 0.15),
            ],
          ),
        ),
      ),
    );
  }
}
