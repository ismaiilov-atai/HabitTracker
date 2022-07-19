//
//  CustomStepper.swift
//  Habit_Tracker
//
//  Created by Atai Ismaiilov on 6/7/22.
//

import Foundation
import SwiftUI

struct CustomStepper: View {
    @Binding var habitModel: HabitModel
    @ObservedObject var viewModel: HabitViewModel
    var body: some View {
        HStack {
            Button {
                if habitModel.complited > 0 {
                    withAnimation(.easeInOut) {
                        if let index = viewModel.habitList.firstIndex(of: habitModel) {
                            habitModel.complited -= 1
                            viewModel.habitList[index] = habitModel
                        }
                    }
                    
                }
            } label: {
                Image(systemName: "minus")
                    .foregroundColor(.black)
                    .padding([.horizontal, .vertical], 8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 4))
            }
            
            Button {
                if habitModel.complited != habitModel.timesPerDay {
                    withAnimation(.easeInOut) {
                        if let index = viewModel.habitList.firstIndex(of: habitModel) {
                            habitModel.complited += 1
                            viewModel.habitList[index] = habitModel
                        }
                    }
                }
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 4))
            }
            
            
        }
    }
    
}

struct CustomStepper_Previews: PreviewProvider {
    static  var habitModel = HabitModel(nameHabit: "run",
                                        detailHabit: "run run",
                                        complited: 2,
                                        goalHabit: "end goal",
                                        timesPerDay: 1
    )
    
    static var previews: some View {
        CustomStepper(habitModel: .constant(habitModel), viewModel: HabitViewModel())
    }
}
