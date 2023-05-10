//
//  StoreManagerController.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/8/23.
//

import SwiftUI

class StorageController: ObservableObject {
    
    private var manager = StorageManager.shared
    private var category: String
    private var categoryEntity: CategoryEntity?
    private var currentLevel: LevelEntity?
    @Published var openLevel = 1
    
    init(category: String) {
        self.category = category
        update()
    }
    
    func setCategory() {
        categoryEntity = manager.fetchCategory(name: category)
    }
    
    func setOpenLevel() {
        if let categoryEntity {
            openLevel = Int(categoryEntity.openLevel)
        }
    }
    
    func update() {
        setCategory()
        setOpenLevel()
    }
    
    func getLevelsBestResult(level: Int) -> Int {
        guard let level = getLevel(level: level) else {
            return 0
        }
        return Int(level.bestResult)
    }
    
    func updateLevel(level: Int, newTime: Double, result: Int, updateMax: Bool) {
        guard let levelEntity = getLevel(level: level) else { return }
        if result > levelEntity.bestResult {
            levelEntity.bestResult = Int64(result)
        }
        manager.addTime(time: newTime, for: levelEntity)
        manager.saveData()
        if updateMax {
            let category =  manager.fetchCategory(name: category)
            if category.openLevel == Int64(level) {
                category.openLevel = Int64(level + 1)
                manager.saveData()
            }
        }
        update()
    }
    
    func getLevelsAvarageTime(level: Int) -> Double {
        var allTimeResults = [Double]()
        guard let level = getLevel(level: level) else { return 0.00 }
        if let time = level.time?.allObjects as? [TimeEntity] {
            for i in time {
                allTimeResults.append(i.time)
            }
        }
        guard !allTimeResults.isEmpty else { return 0.00}
        let alltime = allTimeResults.reduce(0, +) / Double(allTimeResults.count)
        return alltime
    }
    
    func getLevel(level: Int) -> LevelEntity? {
        if let levels = categoryEntity?.levels?.allObjects as? [LevelEntity] {
                return levels.first(where: { $0.level == level })
            }
        return nil
    }
}
