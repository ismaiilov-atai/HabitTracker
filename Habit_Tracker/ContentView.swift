//
//  ContentView.swift
//  Habit_Tracker
//
//  Created by Atai Ismaiilov on 1/7/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habitViewModel = HabitViewModel()
    @State private var toDelete: HabitModel?
    @State private var isRemoveAlertShowing = false
    @State private var removableItemIndex = -1
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(habitViewModel.habitList) { item in
                        HabitItemView(habitModel: item, habitViewModel: habitViewModel )
                                .simultaneousGesture(
                                    LongPressGesture()
                                        .onEnded({ _ in
                                            if let habitIndex = habitViewModel.habitList.firstIndex(where: { habit in
                                                habit.id == item.id
                                            }) {
                                                isRemoveAlertShowing = true
                                                removableItemIndex = habitIndex
                                                
                                            }
                                        })
                                )

                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                
                // new habit btn
                NavigationLink {
                    NewHabitView(habitViewModel: habitViewModel)
                } label: {
                    VStack {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 40))
                            .padding(.vertical, 5)
                            .foregroundColor(.green)
                    }
                }
                
                
            }
            .background(.thickMaterial)
            .navigationTitle("Habit Tracker")
            
        }
        .alert("Are you sure?", isPresented: $isRemoveAlertShowing, actions: {
            Button ("Cencel") { }
            
            Button ("YES") {
                    onDelete(indexAt: removableItemIndex)
            }
            
        }, message:    {
            Text("You want to delete?")
        })
        
    }
    
    func onDelete(indexAt: Int) {
        habitViewModel.habitList.remove(at: indexAt)
        habitViewModel.save(model: nil)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
