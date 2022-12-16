// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CPackage",
    platforms: [.iOS(.v13), .macCatalyst(.v14)],
    products: [
        .library(name: "CoreUI", targets: ["CoreUIWrapper"]),
        .library(name: "RealmTest", targets: ["RealmWrapper"]),
        .library(name: "Analytics", targets: ["AnalyticsWrapper"]),
        .library(name: "CoreNetwork", targets: ["CoreNetworkWrapper"]),
        .library(name: "Integration", targets: ["IntegrationWrapper"])
    ],
    dependencies: [
        .package(url: "https://github.com/ayham-achami/CRest", branch: "mainline"),
        .package(url: "https://github.com/ayham-achami/CArch", branch: "mainline"),
        .package(url: "https://github.com/ayham-achami/CUIKit.git", branch: "mainline"),
        .package(url: "https://github.com/ayham-achami/CRepository", branch: "mainline"),
        .package(url: "https://github.com/ayham-achami/CFoundation.git", branch: "mainline"),
        .package(url: "https://github.com/Alamofire/AlamofireImage.git", .upToNextMajor(from: "4.2.0"))
    ],
    targets: [
        // Realm
        .target(name: "RealmWrapper",
                dependencies: [.target(name: "Realm-test")],
                path: "RealmWrapper"),
        .binaryTarget(
            name: "Realm-test",
            url: "https://nexus.inno.tech/repository/vkc-hosted-raw-ios/Test/Realm-test.xcframework.zip",
            checksum: "87ea132245864955f188229be20b99b6ed0b522c12efae76a04da74bf216ea9e"),
        // CoreNetwork
        .target(name: "CoreNetworkWrapper",
                dependencies: [
                    .target(name: "CoreNetwork"),
                    .product(name: "CArch", package: "CArch"),
                    .product(name: "CRest", package: "CRest"),
                    .product(name: "CFoundation", package: "CFoundation"),
                    .product(name: "AlamofireImage", package: "AlamofireImage"),
                ],
                path: "CoreNetworkWrapper"),
        .binaryTarget(
            name: "CoreNetwork",
            url: "https://nexus.inno.tech/repository/vkc-hosted-raw-ios/com/innotech/CoreNetwork/526911581/CoreNetwork-27837641.526911581.xcframework.zip",
            checksum: "ba6f15c9b98487952b17dfa4a5234342a5a7d1bc7b25fa89803cdde7d619a943"),
        // Integration
        .target(name: "IntegrationWrapper",
                dependencies: [
                    .target(name: "Realm-test"),
                    .target(name: "Integration"),
                    .target(name: "CoreNetwork"),
                    .product(name: "CRest", package: "CRest"),
                    .product(name: "CArch", package: "CArch"),
                    .product(name: "CFoundation", package: "CFoundation"),
                    .product(name: "CRepository", package: "CRepository"),
                    .product(name: "AlamofireImage", package: "AlamofireImage"),
                ],
                path: "IntegrationWrapper"),
        .binaryTarget(
            name: "Integration",
            url: "https://nexus.inno.tech/repository/vkc-hosted-raw-ios/com/innotech/Integration/496814869/Integration-27843082.496814869.xcframework.zip",
            checksum: "48720a196ccf5db819f4aa0f61acae7a798573b883b539fe8e5e81a60cfc29b4"),
        // CoreUI
        .target(name: "CoreUIWrapper",
                dependencies: [
                    .target(name: "CoreUI"),
                    .target(name: "CoreNetworkWrapper"),
                    .product(name: "CArch", package: "CArch"),
                    .product(name: "CUIKit", package: "CUIKit"),
                    .product(name: "CFoundation", package: "CFoundation"),
                ],
                path: "CoreUIWrapper",
                swiftSettings: [.unsafeFlags(["-Xfrontend", "-enable-experimental-concurrency"])]),
        .binaryTarget(
            name: "CoreUI",
            url: "https://nexus.inno.tech/repository/vkc-hosted-raw-ios/com/innotech/CoreUI/347298657/CoreUI-27853384.347298657.xcframework.zip",
            checksum: "8b5498539f97c6c601b6965a857bbc2f3db668156b5ba311f6c694d322287e69"),
        // Analytics
        .target(name: "AnalyticsWrapper",
                dependencies: [
                    .target(name: "Analytics"),
                    .target(name: "Realm-test"),
                    .target(name: "CoreNetwork"),
                    .target(name: "Integration"),
                    .product(name: "CArch", package: "CArch"),
                    .product(name: "CRest", package: "CRest"),
                    .product(name: "CFoundation", package: "CFoundation"),
                    .product(name: "CRepository", package: "CRepository"),
                    .product(name: "AlamofireImage", package: "AlamofireImage")
                ],
                path: "AnalyticsWrapper"),
        .binaryTarget(
            name: "Analytics",
            url: "https://nexus.inno.tech/repository/vkc-hosted-raw-ios/com/innotech/Analytics/421000317/Analytics-27853046.421000317.xcframework.zip",
            checksum: "00f9b0c6ef11b5e61098ca5cfeb83c5da1616f1c0275511496ea0cfc27df1f42"),
    ]
)
