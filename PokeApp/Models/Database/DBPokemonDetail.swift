//
//  DBPokemonDetail.swift
//  PokeApp
//
//  Created by Kevin Renata on 08/07/23.
//

import Foundation
import CoreData

@objcMembers
final class DBPokemonDetail: NSManagedObject {
    static var entityName: String {
        return "Pokemon"
    }
    @NSManaged var name: String
    @NSManaged var id: NSNumber
    @NSManaged var images: [String]
    @NSManaged var height: NSNumber
    @NSManaged var weight: NSNumber
    @NSManaged var type: [String]
    @NSManaged var stats: Data
}

extension DBPokemonDetail {
    func toDto() -> PokemonDetailStoreDto {
        PokemonDetailStoreDto(
            name: name,
            id: id.intValue,
            images: images,
            stats: (try? JSONDecoder().decode([PokemonDetailStoreDto.StatStoreDto].self, from: stats)) ?? [],
            height: height.intValue,
            weight: weight.intValue,
            types: type
        )
    }
    
    func update(from dto: PokemonDetailStoreDto) {
        name = dto.name
        id = NSNumber(value: dto.id)
        images = dto.images
        stats = (try? JSONEncoder().encode(dto.stats)) ?? Data()
        height = NSNumber(value:dto.height)
        weight = NSNumber(value:dto.weight)
        type = dto.types
    }
}
