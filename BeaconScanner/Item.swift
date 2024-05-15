//
//  Item.swift
//  BeaconScanner
//
//  Created by Christian Aldrich Darrien on 15/05/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
