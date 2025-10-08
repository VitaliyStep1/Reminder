// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderPersistence",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderPersistence",
            targets: ["ReminderPersistence"]),
    ],
    targets: [
        .target(
            name: "ReminderPersistence",
            resources: [
              .process("Model.xcdatamodeld")
            ]
        ),
    ]
)
