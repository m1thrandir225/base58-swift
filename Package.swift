// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Base58",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Base58",
            targets: ["Base58"]),
    ],
	dependencies: [
		.package(url: "https://github.com/attaswift/BigInt", .upToNextMajor(from: "5.1.0")),
	],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Base58",
			dependencies: ["BigInt"]
		),
        .testTarget(
            name: "Base58Tests",
            dependencies: ["Base58", "BigInt"]),
    ]
)
