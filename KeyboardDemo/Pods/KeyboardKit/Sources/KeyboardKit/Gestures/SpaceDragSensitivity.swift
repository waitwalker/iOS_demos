//
//  SpaceDragSensitivity.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum can be used to change the drag sensitivity of the
 spacebar.
 
 `NOTE` The sensitivity value corresponds to how many points
 a spacebar must be dragged for the input cursor to move one
 step. This means that the sensitivity is `inverted`. Higher
 values mean that the cursor moves less.
 */
public enum SpaceDragSensitivity {
    
    case low, medium, high, custom(_ points: Int)
    
    public var points: Int {
        switch self {
        case .low: return 10
        case .medium: return 5
        case .high: return 2
        case .custom(let points): return points
        }
    }
}
