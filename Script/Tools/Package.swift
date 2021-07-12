// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tools",
    products: [
        .library(
            name: "Tools",
            targets: ["Tools"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
        .package(url: "https://github.com/kiliankoe/CLISpinner", from: "0.4.0"),
        .package(url: "https://github.com/marmelroy/Zip.git", from: "2.1.1"),
        .package(url: "https://github.com/nerdishbynature/octokit.swift", from: "0.9.0")
    ],
    targets: [
        .target(
            name: "Tools",
            dependencies: ["ArgumentParser", "CLISpinner", "Zip", "OctoKit"])
    ]
)

