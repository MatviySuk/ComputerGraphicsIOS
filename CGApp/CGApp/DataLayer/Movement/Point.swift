//
//  Point.swift
//  CGApp
//
//  Created by Matviy Suk on 12.11.2022.
//

import Foundation

struct Point: Identifiable, Equatable {
    var x: Double
    var y: Double
    
    var name: String = ""
    var id = UUID()
}
