// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderUserDefaultsStorage",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderUserDefaultsStorage",
            targets: ["ReminderUserDefaultsStorage"]),
    ],
    targets: [
        .target(
            name: "ReminderUserDefaultsStorage"),

    ]
)
