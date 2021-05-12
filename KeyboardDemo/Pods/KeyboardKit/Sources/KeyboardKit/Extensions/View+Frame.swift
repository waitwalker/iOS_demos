//
//  View+Frame.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply the size of a `CGSize` to the view.
     */
    func frame(_ size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
}
