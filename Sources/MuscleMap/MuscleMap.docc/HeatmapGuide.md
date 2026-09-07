# Guía de mapas de calor

Visualiza datos de intensidad muscular mediante mapas de calor codificados por color.

## Descripción general

MuscleMap puede colorear cada región muscular según un valor de intensidad. Puedes usar escalas de color incluidas, aplicar curvas de interpolación, activar rellenos con degradado y mostrar una leyenda.

## Escalas de color

``HeatmapColorScale`` asigna valores de intensidad de 0.0 a 1.0 a colores. Las escalas incluidas son:

| Escala | Colores |
|---|---|
| ``HeatmapColorScale/workout`` | Gris → amarillo → naranja → rojo |
| ``HeatmapColorScale/thermal`` | Azul → verde → amarillo → rojo |
| ``HeatmapColorScale/medical`` | Verde → amarillo → rojo |
| ``HeatmapColorScale/monochrome`` | Gris claro → oscuro |

### Usar una escala de color

```swift
BodyView()
    .heatmap([
        MuscleIntensity(muscle: .chest, intensity: 0.9),
        MuscleIntensity(muscle: .biceps, intensity: 0.5),
        MuscleIntensity(muscle: .abs, intensity: 0.3),
    ], colorScale: .thermal)
```

### Intensidades enteras

Para casos sencillos, por ejemplo un registro de entrenamiento, usa `intensities` con una escala de 0 a 4:

```swift
BodyView()
    .intensities([
        .chest: 4,    // máxima
        .biceps: 2,   // media
        .abs: 1,      // baja
    ], colorScale: .workout)
```

## Interpolación

Controla cómo transicionan los colores mediante ``ColorInterpolation``:

```swift
BodyView()
    .heatmap(data, colorScale: .workout)
    .heatmapInterpolation(.easeInOut)
```

Modos disponibles:
- ``ColorInterpolation/linear`` — distribución uniforme, valor predeterminado.
- ``ColorInterpolation/easeIn`` — inicio lento y final rápido.
- ``ColorInterpolation/easeOut`` — inicio rápido y final lento.
- ``ColorInterpolation/easeInOut`` — curva suave en S.
- ``ColorInterpolation/step(count:)`` — bandas de color discretas.
- ``ColorInterpolation/custom(_:)`` — función de curva personalizada.

## Relleno con degradado

Activa un degradado dentro de cada región muscular, desde una intensidad menor hasta la intensidad real:

```swift
BodyView()
    .heatmap(data, colorScale: .thermal)
    .heatmapGradient(direction: .topToBottom, lowFactor: 0.3)
```

`lowFactor` controla la intensidad del extremo inferior del degradado con respecto a la intensidad real de la región.

## Umbral

Oculta regiones cuya intensidad sea inferior a un valor mínimo:

```swift
BodyView()
    .heatmap(data, colorScale: .workout)
    .heatmapThreshold(0.2) // oculta intensidades < 0.2
```

## Configuración completa

Usa ``HeatmapConfiguration`` para combinar todas las opciones:

```swift
let config = HeatmapConfiguration(
    colorScale: .thermal,
    interpolation: .easeInOut,
    threshold: 0.1,
    isGradientFillEnabled: true,
    gradientDirection: .topToBottom,
    gradientLowIntensityFactor: 0.3
)

BodyView()
    .heatmap(data, configuration: config)
```

## Leyenda

Muestra ``HeatmapLegendView`` junto al cuerpo para explicar la escala cromática:

```swift
VStack {
    BodyView()
        .heatmap(data, colorScale: .workout)
        .frame(width: 200, height: 400)

    HeatmapLegendView(colorScale: .workout)
        .frame(width: 200)
}
```

Personaliza las etiquetas de la leyenda:

```swift
HeatmapLegendView(
    colorScale: .thermal,
    interpolation: .easeInOut,
    orientation: .vertical,
    barThickness: 20,
    labelMin: "Reposo",
    labelMax: "Máxima"
)
```
