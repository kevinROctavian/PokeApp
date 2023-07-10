//
//  DataManager.swift
//  Pokemon
//
//  Created by Kevin Renata on 09/07/2023.
//

import UIKit
import CoreData

public protocol DataManagerProtocol {
    func save(pokemon: PokemonDetailStoreDto)
    func getPokemon() throws -> [PokemonDetailStoreDto]
}

final class DataManager: DataManagerProtocol {
    private var managedObjectContext: NSManagedObjectContext! = nil
    private var entity: NSEntityDescription! = nil

    init(objectContext: NSManagedObjectContext, entity: NSEntityDescription) {
        self.managedObjectContext = objectContext
        self.entity = entity
    }

    required init() {
        debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        managedObjectContext = CoreDataStack.shared.mainContext
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        if let entityDescription = NSEntityDescription.entity(
            forEntityName: "Pokemon",
            in: managedObjectContext) {
            entity = entityDescription
        }
    }

    func getPokemon() throws -> [PokemonDetailStoreDto] {
        let fetchRequest = NSFetchRequest<DBPokemonDetail>(entityName: DBPokemonDetail.entityName)
        let pokemon: [DBPokemonDetail]
        do {
            pokemon = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            throw ErrorModel(errorDescription: "Core Data Error. Could not fetch. \(error), \(error.userInfo)")
        }
        if pokemon.isEmpty {throw ErrorModel(errorDescription: "No Pokemon Found")}
        return pokemon.map {$0.toDto()}

    }

    func save(pokemon: PokemonDetailStoreDto) {
        managedObjectContext.perform {
            let object = DBPokemonDetail(entity: self.entity, insertInto: self.managedObjectContext)
            object.update(from: pokemon)
            self.saveContext(completion: {})
        }
    }

    private func saveContext(completion: @escaping () -> Void) {
        managedObjectContext.perform {
            do {
                try self.managedObjectContext.save()
                completion()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
