//
//  StoreManagerController.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/8/23.
//

import SwiftUI

final class StorageController: ObservableObject {
    
    @Published var openLevel = 1
    
    private var manager = StorageManager.shared
    private var category: String
    private var categoryEntity: CategoryEntity?
    private var currentLevel: LevelEntity?
    
    init(category: String) {
        self.category = category
        update()
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
        guard let level = getLevel(level: level),
              let time = level.time?.allObjects as? [TimeEntity],
              !time.isEmpty else {
            return 0.0
        }
        return time.map { $0.time }.reduce(0.0, +) / Double(time.count)
    }
    
    private func getLevel(level: Int) -> LevelEntity? {
        if let levels = categoryEntity?.levels?.allObjects as? [LevelEntity] {
                return levels.first(where: { $0.level == level })
            }
        return nil
    }
    
    private func setCategory() {
        categoryEntity = manager.fetchCategory(name: category)
    }
    
    private func setOpenLevel() {
        if let categoryEntity {
            openLevel = Int(categoryEntity.openLevel)
        }
    }
    
    private func update() {
        setCategory()
        setOpenLevel()
    }
}
