//
//  UIDevice+Idiom.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var isPad: Bool { userInterfaceIdiom == .pad }
    var isPhone: Bool { userInterfaceIdiom == .phone }
}
