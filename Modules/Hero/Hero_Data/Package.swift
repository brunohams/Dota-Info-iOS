// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hero_Data",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Hero_Data",
            targets: ["Hero_Data"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Alamofire", url: "https://github.com/Alamofire/Alamofire", branch: "master"),
        .package(name: "Hero_Domain", path: "Hero_Domain")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Hero_Data",
            dependencies: ["Alamofire", "Hero_Domain"]),
        .testTarget(
            name: "Hero_DataTests",
            dependencies: ["Hero_Data", "Alamofire", "Hero_Domain"]),
    ]
)
