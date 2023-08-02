//
//  Model.swift
//  SwiftUItoCompose
//
//  Created by Andre on 01/08/23.
//

import Foundation

struct Task: Identifiable, Equatable { // Adicionamos Equatable aqui
    var id = UUID()
    var title: String
    var description: String
}
