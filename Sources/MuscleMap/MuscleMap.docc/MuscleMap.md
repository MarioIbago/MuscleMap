# ``MuscleMap``

SDK de SwiftUI para renderizar mapas musculares interactivos del cuerpo humano con resaltados, mapas de calor y gestos.

## Descripción general

MuscleMap ofrece una forma declarativa de mostrar el cuerpo humano y visualizar datos musculares. Está construido íntegramente con SwiftUI, sin dependencias externas, y admite modelos masculino y femenino, vistas anterior y posterior, gestos de toque, pulsación prolongada y arrastre, escalas de color para mapas de calor, degradados, animación de pulso, zoom y más.

Los identificadores de la API (`.chest`, `.biceps`, `.quadriceps`, etc.) se mantienen en inglés para preservar compatibilidad. Los nombres visibles al usuario se localizan y, en español, usan nomenclatura anatómica revisada.

```swift
import MuscleMap

BodyView(gender: .male, side: .front)
    .highlight(.chest, color: .red)
    .highlight(.biceps, color: .orange, opacity: 0.8)
    .onMuscleSelected { muscle, side in
        print("Seleccionado: \(muscle.displayName) (\(side.displayName))")
    }
```

## Temas

### Primeros pasos

- <doc:GettingStarted>

### Visualización corporal

- ``BodyView``
- ``BodyGender``
- ``BodySide``

### Resaltado de músculos

- ``Muscle``
- ``MuscleSide``
- ``MuscleHighlight``
- ``MuscleFill``

### Mapas de calor

- <doc:HeatmapGuide>
- ``MuscleIntensity``
- ``HeatmapColorScale``
- ``HeatmapConfiguration``
- ``ColorInterpolation``
- ``GradientDirection``
- ``HeatmapLegendView``

### Estilos

- ``BodyViewStyle``

### Selección e historial

- ``MuscleSelection``
- ``SelectionHistory``

### Integración con UIKit

- <doc:UIKitIntegration>
- ``MuscleMapView``
- ``HeatmapLegendUIView``
