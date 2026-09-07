// swift-tools-version: 5.9

//
//  Package.swift
//  MuscleMap
//
//  Creado por Melih Colpan el 2026-02-09.
//  Copyright © 2026 Melih Colpan. Todos los derechos reservados.
//  Licenciado bajo la licencia MIT.
//

import PackageDescription

let package = Package(
    name: "MuscleMap",
    defaultLocalization: "es",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "MuscleMap",
            targets: ["MuscleMap"]
        ),
    ],
    targets: [
        .target(
            name: "MuscleMap",
            path: "Sources/MuscleMap",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MuscleMapTests",
            dependencies: ["MuscleMap"],
            path: "Tests/MuscleMapTests"
        ),
    ]
)
