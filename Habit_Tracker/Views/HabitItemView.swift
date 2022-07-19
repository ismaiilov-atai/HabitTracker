//
//  HabitItemView.swift
//  Habit_Tracker
//
//  Created by Atai Ismaiilov on 6/7/22.
//

import Foundation
import SwiftUI

struct HabitItemView: View {
     @State var habitModel: HabitModel
    @ObservedObject var habitViewModel: HabitViewModel
    var body: some View {
        HStack {
            NavigationLink {
                Text(habitModel.nameHabit)
            } label: {
                CustomStepper(habitModel: $habitModel, viewModel: habitViewModel)
                
                VStack(alignment: .center) {
                    Text(habitModel.nameHabit)
                        .font(.title2.bold())
                    
                    Text(habitModel.detailHabit)
                        .font(.body.italic())
                }
                .frame(maxWidth: .infinity)


                    if habitModel.complited != habitModel.timesPerDay {
                        Text("\(habitModel.complited)")
                            .font(.title.bold())
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                    } else if habitModel.complited == habitModel.timesPerDay {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 30))
                                .foregroundColor(.green)
                                .animation(.easeInOut, value: habitModel.complited)
                    }

            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white, in: RoundedRectangle(cornerRadius: 13))

        }

    }
}


struct HabitItemView_Previews: PreviewProvider {
    static var viewModel = HabitViewModel()
    static var previews: some View {
        HabitItemView(habitModel:
                        HabitModel(nameHabit: "Running",
                                   detailHabit: "description",
                                   complited: 2,
                                   goalHabit: "end goal",
                                   timesPerDay: 1),
                      habitViewModel: viewModel
        )
        
    }
}
