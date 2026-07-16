import 'package:flutter/material.dart';

import '../models/room.dart';
import '../theme/app_theme.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;

  const RoomCard({
    super.key,
    required this.room,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark
        ? const Color(0xff12182B)
        : Colors.white;

    final borderColor = AppColors.purple.withValues(alpha: .15);

    final textColor =
        isDark ? AppColors.darkText : AppColors.lightText;

    final dimColor =
        isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return InkWell(
      onTap: room.available ? onTap : null,
      borderRadius: BorderRadius.circular(22),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        margin: const EdgeInsets.only(
          bottom: 16,
        ),

        decoration: BoxDecoration(
          color: cardColor,

          borderRadius: BorderRadius.circular(22),

          border: Border.all(
            color: borderColor,
          ),

          boxShadow: [

            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),

            BoxShadow(
              color: AppColors.purple.withValues(alpha: .08),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Row(
                children: [

                  Container(
                    width: 54,
                    height: 54,

                    decoration: BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(16),

                      gradient: const LinearGradient(
                        colors: [
                          AppColors.purple,
                          AppColors.purpleDark,
                        ],
                      ),
                    ),

                    child: const Icon(
                      Icons.meeting_room_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Room ${room.roomNo}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          room.department,
                          style: TextStyle(
                            color: dimColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: room.available
                          ? AppColors.green.withValues(alpha: .15)
                          : AppColors.red.withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      room.available ? "FREE" : "OCCUPIED",
                      style: TextStyle(
                        color: room.available
                            ? AppColors.green
                            : AppColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [

                  Expanded(
                    child: _infoTile(
                      Icons.location_on_outlined,
                      "Block",
                      room.blockName,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _infoTile(
                      Icons.layers_outlined,
                      "Floor",
                      room.floorNo,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [

                  Expanded(
                    child: _infoTile(
                      Icons.apartment_outlined,
                      "Type",
                      room.roomType,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _infoTile(
                      Icons.people_outline,
                      "Capacity",
                      "${room.capacity}",
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 10),

              _infoTile(
                Icons.schedule_outlined,
                "Time Slot",
                room.timeSlot,
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: room.available ? onTap : null,

                  icon: const Icon(Icons.send_rounded),

                  label: const Text(
                    "Request Room",
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            size: 18,
            color: AppColors.purple,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),

                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}