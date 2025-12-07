// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DomainLocalization",
    platforms: [
      .iOS(.v17)
    ],
    products: [
        .library(
            name: "DomainLocalization",
            targets: ["DomainLocalization"]),
    ],
    dependencies: [
      .package(path: "ReminderDomain"),
    ],
    targets: [
      .target(
        name: "DomainLocalization",
        dependencies: [
          "ReminderDomain",
        ],
        resources: [
          .process("Resources")
        ]
      ),
    ]
)
