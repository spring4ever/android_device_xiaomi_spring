// SPDX-License-Identifier: Apache-2.0

#include <sstream>
#include <string>
#include <unistd.h>

#include <android-base/file.h>
#include <android-base/logging.h>
#include <android-base/properties.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include "vendor_init.h"

// Called after importing boot properties, before ExportKernelBootProps().
// Setting ro.boot.mode here also makes init export ro.bootmode=charger.
void vendor_process_bootenv() {
    if (android::base::GetProperty("ro.boot.hwname", "") != "spring") return;

    // Preserve explicit bootloader modes and dedicated recovery boots.
    if (!android::base::GetProperty("ro.boot.mode", "").empty() ||
        access("/system/bin/recovery", F_OK) == 0) {
        return;
    }

    std::string cmdline;
    if (!android::base::ReadFileToString("/proc/cmdline", &cmdline)) return;

    std::istringstream args(cmdline);
    std::string arg;
    std::string reason;
    constexpr char prefix[] = "bootinfo.pureason=";
    while (args >> arg) {
        if (arg.compare(0, sizeof(prefix) - 1, prefix) != 0) continue;
        // Fail closed if the boot argument is repeated or empty.
        if (!reason.empty() || arg.size() == sizeof(prefix) - 1) return;
        reason = arg.substr(sizeof(prefix) - 1);
    }

    // Observed on cable insertion from shutdown. An adb reboot reports
    // 0x40041; a power-key boot can report 0x80081. Neither is accepted.
    if (reason != "0x40040") return;

    constexpr char property[] = "ro.boot.mode";
    constexpr char value[] = "charger";
    auto* info = const_cast<prop_info*>(__system_property_find(property));
    const int result = info
            ? __system_property_update(info, value, sizeof(value) - 1)
            : __system_property_add(property, sizeof(property) - 1, value, sizeof(value) - 1);
    if (result == 0) {
        LOG(INFO) << "Spring: cable-insertion boot; selecting charger mode";
    } else {
        LOG(ERROR) << "Spring: could not set charger boot mode";
    }
}
