# Integración con UIKit

Usa MuscleMap en proyectos basados en UIKit mediante ``MuscleMapView`` y ``HeatmapLegendUIView``.

## Descripción general

Aunque MuscleMap está construido con SwiftUI, la clase ``MuscleMapView`` ofrece un contenedor `UIView` que puede utilizarse directamente desde controladores de vista UIKit. Toda la configuración se expone mediante propiedades modificables y métodos de conveniencia.

## Añadir una vista corporal

Crea un ``MuscleMapView`` y añádelo a la jerarquía de vistas:

```swift
import MuscleMap

class ViewController: UIViewController {
    private let muscleMap = MuscleMapView(gender: .male, side: .front)

    override func viewDidLoad() {
        super.viewDidLoad()

        muscleMap.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(muscleMap)

        NSLayoutConstraint.activate([
            muscleMap.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            muscleMap.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            muscleMap.widthAnchor.constraint(equalToConstant: 200),
            muscleMap.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}
```

## Resaltar músculos

Usa ``MuscleMapView/highlight(_:color:opacity:)`` con colores de UIKit:

```swift
muscleMap.highlight(.chest, color: .systemRed)
muscleMap.highlight(.biceps, color: .systemOrange, opacity: 0.8)
```

También puedes resaltar varios grupos a la vez:

```swift
muscleMap.highlight([.chest, .deltoids, .triceps], color: .systemBlue)
```

## Aplicar datos de mapa de calor

Usa ``MuscleMapView/setIntensities(_:colorScale:)`` para valores enteros de entrenamiento:

```swift
muscleMap.setIntensities([
    .chest: 4,
    .biceps: 2,
    .abs: 1
])
```

O usa ``MuscleMapView/setHeatmap(_:colorScale:)`` para intensidades normalizadas:

```swift
muscleMap.setHeatmap([
    MuscleIntensity(muscle: .chest, intensity: 0.9),
    MuscleIntensity(muscle: .biceps, intensity: 0.5),
])
```

## Gestionar eventos

Asigna closures para responder a las interacciones del usuario:

```swift
muscleMap.onMuscleSelected = { muscle, side in
    print("Seleccionado: \(muscle.displayName)")
}

muscleMap.onMuscleLongPressed = { muscle, side in
    print("Pulsación prolongada: \(muscle.displayName)")
}
```

## Configurar propiedades

Las funciones de ``BodyView`` están disponibles como propiedades modificables:

```swift
muscleMap.gender = .female
muscleMap.side = .back
muscleMap.showSubGroups = true
muscleMap.isAnimated = true
muscleMap.isPulseEnabled = true
muscleMap.isZoomEnabled = true
```

## Añadir una leyenda de mapa de calor

Usa ``HeatmapLegendUIView`` junto a la vista corporal:

```swift
let legend = HeatmapLegendUIView(colorScale: .workout)
legend.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(legend)
```
