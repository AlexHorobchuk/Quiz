//
//  StorageModel.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/7/23.
//

import Foundation
import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    let container = NSPersistentContainer(name: "Storage")
    
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchResults() -> [MPResult] {
        let request = NSFetchRequest<MPResult>(entityName: "MPResult")
        do {
            let result = try container.viewContext.fetch(request)
            return result
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        return [MPResult]()
    }
    
    func addResult(myResult: Int, enemyResult: Int, didWin: Bool, name: String) {
        let newResult = MPResult(context: container.viewContext)
        newResult.enemyName = name
        newResult.enemyResult = Int64(enemyResult)
        newResult.didWin = didWin
        newResult.myResult = Int64(myResult)
        saveData()
    }
    
    func fetchCategory(name: String) -> CategoryEntity {
        let request = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
        request.predicate = NSPredicate(format: "name == %@", name as CVarArg)
            do {
                let result = try container.viewContext.fetch(request)
                if let category = result.first {
                    return category
                } else {
                    let newCategory = addCategory(name: name)
                    return newCategory
                }
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        return CategoryEntity()
    }
    
    func addLevel(level: Int, for category: CategoryEntity) {
        let newLevel = LevelEntity(context: container.viewContext)
        newLevel.level = Int64(level)
        newLevel.bestResult = 0
        newLevel.category = category
        saveData()
    }
    
    func addTime(time: Double, for level: LevelEntity) {
        let newTime = TimeEntity(context: container.viewContext)
        newTime.time = time
        newTime.level = level
        saveData()
    }
 
    func saveData() {
        do {
            try  container.viewContext.save()
        } catch let error {
            print("Couldt save to CoreData: \(error.localizedDescription)")
        }
    }
    
    private func addCategory(name: String) -> CategoryEntity {
        let newCategory = CategoryEntity(context: container.viewContext)
        newCategory.name = name
        newCategory.openLevel = 1
        saveData()
        addLevel(level: 1, for: newCategory)
        return newCategory
    }
}
