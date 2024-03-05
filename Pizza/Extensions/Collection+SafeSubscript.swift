//
//  Collection+SafeSubscript.swift
//  Mercaux
//
//  Created by Alexey Ivanov on 4/3/23.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
