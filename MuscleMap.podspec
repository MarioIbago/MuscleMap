Pod::Spec.new do |s|
  s.name         = "MuscleMap"
  s.version      = "1.6.4"
  s.summary      = "SDK de SwiftUI para renderizar mapas musculares interactivos del cuerpo humano."
  s.description  = <<-DESC
    MuscleMap ofrece una forma declarativa de mostrar el cuerpo humano y visualizar
    datos musculares. Está construido íntegramente con SwiftUI y no tiene dependencias
    externas. Admite modelos masculino y femenino, vistas anterior y posterior,
    gestos de toque, pulsación prolongada y arrastre, mapas de calor, degradados,
    animaciones de pulso, zoom, subgrupos musculares, integración con UIKit,
    accesibilidad y localización. El español es la localización predeterminada.
  DESC

  s.homepage     = "https://github.com/MarioIbago/MuscleMap"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Melih Colpan" => "colpanmelih@gmail.com" }

  s.ios.deployment_target = "17.0"
  s.osx.deployment_target = "14.0"
  s.swift_version = "5.9"

  s.source       = { :git => "https://github.com/MarioIbago/MuscleMap.git", :tag => s.version.to_s }
  s.source_files = "Sources/MuscleMap/**/*.swift"
  s.resource_bundles = { "MuscleMap" => ["Sources/MuscleMap/Resources/**/*.strings"] }

  s.frameworks   = "SwiftUI"
end
