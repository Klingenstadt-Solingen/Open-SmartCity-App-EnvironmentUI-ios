// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let essentialsPackageLocal = false
let testCaseExtensionPackageLocal: Bool = false

let oscaEssentialsVersion = Version("1.1.0")
let oscaTestCaseExtensionVersion = Version("1.1.0")


let package = Package(
  name: "OSCAEnvironmentUI",
  defaultLocalization: "de",
  platforms: [.iOS(.v15)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "OSCAEnvironmentUI",
      targets: ["OSCAEnvironmentUI"]
    ),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    /* SwiftDate */
    .package(url: "https://github.com/malcommac/SwiftDate.git",
             from: "7.0.0" ),
    .package(url: "https://github.com/parse-community/Parse-SDK-iOS-OSX.git", exact: "4.1.1"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.2.3"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSVGCoder.git", from: "1.7.0"),
    /* OSCAEssentials */
    /// use local package path
    essentialsPackageLocal ? .package(path: "modules/OSCAEssentials") :
    .package(url: "https://git-dev.solingen.de/smartcityapp/modules/oscaessentials-ios.git",
             .upToNextMinor(from: oscaEssentialsVersion)),
    // OSCATestCaseExtension
    /// use local package path
    testCaseExtensionPackageLocal ? .package(path: "modules/OSCAEssentials") :
    .package(url: "https://git-dev.solingen.de/smartcityapp/modules/oscatestcaseextension-ios.git",
             .upToNextMinor(from: oscaTestCaseExtensionVersion)),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "OSCAEnvironmentUI",
      dependencies: [
        .product(name: "SwiftDate", package: "SwiftDate"),
        .product(name: "ParseObjC", package: "Parse-SDK-iOS-OSX"),
        .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
        .product(name: "SDWebImageSVGCoder", package: "SDWebImageSVGCoder"),
        /* OSCAEssentials */
        .product(name: "OSCAEssentials",
                 package: essentialsPackageLocal ? "OSCAEssentials" : "oscaessentials-ios"),
      ],
      path: "OSCAEnvironmentUI/OSCAEnvironmentUI",
      exclude: [
        "Info.plist",
        "SupportingFiles"
      ],
      resources: [.process("Resources")]),
    .testTarget(
      name: "OSCAEnvironmentUITests",
      dependencies: ["OSCAEnvironmentUI",
        .product(name: "OSCATestCaseExtension", package: "oscatestcaseextension-ios")
      ],
      path: "OSCAEnvironmentUI/OSCAEnvironmentUITests",
      exclude: ["Info.plist"],
      resources: [.process("Resources")]
    ),
  ]
)
