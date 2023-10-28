//
//  StudyPlanListView.swift
//  TaEstudado
//
//  Created by Yuri Cunha on 28/10/23.
//

import SwiftUI

struct StudyPlanListView: View {
    @Binding var path: NavigationPath
    private let studyPlanManager = StudyPlanManager.shared
    
    var body: some View {
        VStack {
            if studyPlanManager.studyPlans.isEmpty {
                Text("Voce nao possui um plano \nde estudos cadastrado")
                    .multilineTextAlignment(.center)
                    .italic()
            } else {
                List {
                    ForEach(studyPlanManager.studyPlans) { studyPlan in
                        HStack {
                            Text(studyPlan.course)
                                .foregroundStyle(.accent)
                            Spacer()
                            Text(studyPlan.dateFormatted)
                                .foregroundStyle(.gray)
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            
        }
        .navigationTitle("Plano de estudo") 
        .toolbar {
            Button("",systemImage: "plus") {
                path.append(NavigationType.form)
            }
        }
        
    }
    
    private func delete(index: IndexSet) {
        if let index = index.first {
            studyPlanManager.removePlan(at: index)
        }
        
    }
}

#Preview {
    StudyPlanListView(path: .constant(.init()))
}
