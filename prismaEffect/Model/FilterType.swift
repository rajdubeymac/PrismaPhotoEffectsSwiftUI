//
//  FilterType.swift
//  Prisma
//
//  Created by Raj Dubey on 29/10/22.
//

import Foundation

enum FilterType: String, Identifiable, CaseIterable {
    var id: String { self.rawValue }
    case None, Paint, Mosaic, Cassatt, Starnight, Wave, Water, Pissarro, Pointillism, Style, Renoir, Cuphead, Candy, Feather, Muse, Scream, Morisot, Udnie, Cartoon, Night, Degas, Manet, Monet, Sisley
}
