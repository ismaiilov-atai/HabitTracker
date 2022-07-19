//
//  Habit_Model.swift
//  Habit_Tracker
//
//  Created by Atai Ismaiilov on 1/7/22.
//

import Foundation

struct HabitModel: Codable, Identifiable, Equatable {
    var id = UUID()
    var nameHabit: String
    var detailHabit: String
    var complited: Int
    var goalHabit: String
    var timesPerDay: Int
}

class HabitViewModel: ObservableObject {
    @Published var habitList : [HabitModel] {
        didSet {
            if let encoded = try? JSONEncoder().encode(habitList) {
                UserDefaults.standard.set(encoded, forKey: KeysEnum.habitsKey.rawValue)
            }
            
        }
    }
    
    init () {
        if let data = UserDefaults.standard.object(forKey: KeysEnum.habitsKey.rawValue) as? Data {
            if let decoded = try? JSONDecoder().decode([HabitModel].self, from: data) {
                habitList = decoded
                return
            }
        }
        habitList = []
    }
    
    func save(model: HabitModel) {
            habitList.insert(model, at: 0)
    }
    
    func setCompleted(model: HabitModel ) {
        
        if let index = habitList.firstIndex(of: model) {
            habitList[index] = model
        }
    }
}
