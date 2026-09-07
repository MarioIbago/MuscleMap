//
//  Muscle.swift
//  MuscleMap
//
//  Creado por Melih Colpan el 2026-02-09.
//  Copyright © 2026 Melih Colpan. Todos los derechos reservados.
//  Licenciado bajo la licencia MIT.
//

import Foundation

/// Representa todos los grupos musculares disponibles que pueden resaltarse sobre el cuerpo.
///
/// Los identificadores de los `case` se conservan en inglés para mantener compatibilidad binaria
/// y de código fuente. Usa ``displayName`` para mostrar al usuario la nomenclatura localizada.
public enum Muscle: String, CaseIterable, Codable, Identifiable, Sendable {
    case abs
    case biceps
    case calves
    case chest
    case deltoids
    case feet
    case forearm
    case gluteal
    case hamstring
    case hands
    case head
    case knees
    case lowerBack = "lower-back"
    case obliques
    case quadriceps
    case tibialis
    case trapezius
    case triceps
    case upperBack = "upper-back"

    // Nuevos grupos musculares
    case rotatorCuff = "rotator-cuff"
    case serratus
    case rhomboids

    // Subgrupos
    case ankles
    case adductors
    case neck
    case hipFlexors = "hip-flexors"
    case upperChest = "upper-chest"
    case lowerChest = "lower-chest"
    case innerQuad = "inner-quad"
    case outerQuad = "outer-quad"
    case upperAbs = "upper-abs"
    case lowerAbs = "lower-abs"
    case frontDeltoid = "front-deltoid"
    case rearDeltoid = "rear-deltoid"
    case upperTrapezius = "upper-trapezius"
    case lowerTrapezius = "lower-trapezius"

    public var id: String { rawValue }

    /// Nombre localizado que debe mostrarse al usuario.
    public var displayName: String {
        NSLocalizedString("muscle.\(localizationKey)", bundle: .module, comment: "")
    }

    /// Clave usada para la búsqueda de localización.
    /// Convierte los nombres de los `case` de Swift en claves de `Localizable.strings`.
    private var localizationKey: String {
        switch self {
        case .abs: return "abs"
        case .adductors: return "adductors"
        case .ankles: return "ankles"
        case .biceps: return "biceps"
        case .calves: return "calves"
        case .chest: return "chest"
        case .deltoids: return "deltoids"
        case .feet: return "feet"
        case .forearm: return "forearm"
        case .gluteal: return "gluteal"
        case .hamstring: return "hamstring"
        case .hands: return "hands"
        case .head: return "head"
        case .knees: return "knees"
        case .lowerBack: return "lowerBack"
        case .neck: return "neck"
        case .obliques: return "obliques"
        case .quadriceps: return "quadriceps"
        case .tibialis: return "tibialis"
        case .trapezius: return "trapezius"
        case .triceps: return "triceps"
        case .upperBack: return "upperBack"
        case .rotatorCuff: return "rotatorCuff"
        case .hipFlexors: return "hipFlexors"
        case .serratus: return "serratus"
        case .rhomboids: return "rhomboids"
        case .upperChest: return "upperChest"
        case .lowerChest: return "lowerChest"
        case .innerQuad: return "innerQuad"
        case .outerQuad: return "outerQuad"
        case .upperAbs: return "upperAbs"
        case .lowerAbs: return "lowerAbs"
        case .frontDeltoid: return "frontDeltoid"
        case .rearDeltoid: return "rearDeltoid"
        case .upperTrapezius: return "upperTrapezius"
        case .lowerTrapezius: return "lowerTrapezius"
        }
    }

    /// Indica si el elemento es una parte cosmética (cabeza/cabello) y no un músculo.
    public var isCosmeticPart: Bool {
        self == .head
    }

    /// Subgrupos que pertenecen a este grupo muscular.
    /// Devuelve un arreglo vacío cuando el músculo no tiene subgrupos.
    public var subGroups: [Muscle] {
        switch self {
        case .chest: return [.upperChest, .lowerChest]
        case .quadriceps: return [.innerQuad, .outerQuad, .hipFlexors]
        case .abs: return [.upperAbs, .lowerAbs]
        case .deltoids: return [.frontDeltoid, .rearDeltoid]
        case .trapezius: return [.upperTrapezius, .lowerTrapezius]
        case .obliques: return [.serratus]
        case .feet: return [.ankles]
        case .hamstring: return [.adductors]
        case .head: return [.neck]
        default: return []
        }
    }

    /// Grupo muscular padre cuando este elemento es un subgrupo.
    public var parentGroup: Muscle? {
        switch self {
        case .upperChest, .lowerChest: return .chest
        case .innerQuad, .outerQuad, .hipFlexors: return .quadriceps
        case .upperAbs, .lowerAbs: return .abs
        case .frontDeltoid, .rearDeltoid: return .deltoids
        case .upperTrapezius, .lowerTrapezius: return .trapezius
        case .serratus: return .obliques
        case .ankles: return .feet
        case .adductors: return .hamstring
        case .neck: return .head
        default: return nil
        }
    }

    /// Indica si este músculo es subgrupo de otro.
    public var isSubGroup: Bool {
        parentGroup != nil
    }

    /// Indica si el subgrupo debe renderizarse siempre aunque los subgrupos estén ocultos.
    /// En el modo predeterminado, al tocarlo se devuelve el músculo padre.
    public var isAlwaysVisibleSubGroup: Bool {
        switch self {
        case .ankles, .adductors, .neck: return true
        default: return false
        }
    }
}

/// Identificador interno de renderizado que también incluye el cabello.
enum BodySlug: String, CaseIterable {
    case abs
    case biceps
    case calves
    case chest
    case deltoids
    case feet
    case forearm
    case gluteal
    case hamstring
    case hands
    case hair
    case head
    case knees
    case lowerBack = "lower-back"
    case obliques
    case quadriceps
    case tibialis
    case trapezius
    case triceps
    case upperBack = "upper-back"

    // Nuevos grupos musculares
    case rotatorCuff = "rotator-cuff"
    case serratus
    case rhomboids

    // Subgrupos
    case ankles
    case adductors
    case neck
    case hipFlexors = "hip-flexors"
    case upperChest = "upper-chest"
    case lowerChest = "lower-chest"
    case innerQuad = "inner-quad"
    case outerQuad = "outer-quad"
    case upperAbs = "upper-abs"
    case lowerAbs = "lower-abs"
    case frontDeltoid = "front-deltoid"
    case rearDeltoid = "rear-deltoid"
    case upperTrapezius = "upper-trapezius"
    case lowerTrapezius = "lower-trapezius"

    var muscle: Muscle? {
        switch self {
        case .hair: return nil
        default: return Muscle(rawValue: rawValue)
        }
    }
}
