//
//  HabitView.swift
//  Habit_Tracker
//
//  Created by Atai Ismaiilov on 1/7/22.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    var placeHolder: String
    @Binding var bindingState: String
    var maxHeight = 15
    var aligment: Alignment = .center
    
    var body: some View {
        TextField(placeHolder, text: $bindingState)
            .frame(height: Double(maxHeight), alignment: aligment)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.5)
                    .fill(.gray)
            )
        
    }
}

struct NewHabitView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isPresenting = false
    @State private var habitName = ""
    @State private var habitDetail = ""
    @State private var habitGoal = ""
    @State private var timesPerDay = 1
    
    @ObservedObject var habitViewModel: HabitViewModel
    
    var body: some View {
        GeometryReader { fullScreen in
            ScrollView (showsIndicators: false) {
                VStack {
                    Image("habitpng")
                        .resizable()
                        .frame(width: fullScreen.size.width * 0.5, height: fullScreen.size.height * 0.3)
                    
                    VStack(spacing: 20) {
                        Text("Provide details:")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        CustomTextField(placeHolder: "Habit name:", bindingState: $habitName)
                        
                        CustomTextField(placeHolder: "Habit detail:", bindingState: $habitDetail)
                        Section {
                            Picker("times per day", selection: $timesPerDay) {
                                ForEach( 1..<4, id: \.self) { index in
                                    Text(index == 1 ?  "\(index) time" : "\(index) times")
                                }
                            }
                            .pickerStyle(.segmented)
                            
                        } header: {
                            Text("Times per day:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.gray)
                        }
                        
                        CustomTextField(placeHolder: "Habit goal:",
                                        bindingState: $habitGoal,
                                        maxHeight: 70, aligment: .topLeading
                        )
                    }
                    .padding([.horizontal, .vertical], 20)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8)
                    )
                    
                    Spacer(minLength: fullScreen.size.height * 0.1)
                    
                    Button {
                        guard !habitName.isEmpty && !habitDetail.isEmpty else {
                            isPresenting.toggle()
                            return
                        }
                        let model   = HabitModel(nameHabit: habitName,
                                                                     detailHabit: habitDetail,
                                                                     complited: 0,
                                                                     goalHabit: habitGoal,
                                                                     timesPerDay: timesPerDay
                        )
                        
                        habitViewModel.save(
                            model: model
                        )

                        dismiss()
                } label: {
                    Text("Save")
                        .frame(height: 50)
                        .foregroundColor(.black)
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity)
                .background(.blue, in: RoundedRectangle(cornerRadius: 10))
                .alert("Please provide habit details.", isPresented: $isPresenting) {
                    Button("OK") { }
                }
            }
            
        }
        .padding()
        }

        
    }
}


struct NewHabitView_Previews: PreviewProvider {

    static var previews: some View {
        NewHabitView(habitViewModel: HabitViewModel())
    }
}
