//
//  StudyPlanManager.swift
//  TaEstudado
//
//  Created by Yuri Cunha on 28/10/23.
//

import Foundation
import Observation
import UserNotifications
@Observable final class StudyPlanManager {
    
    //Singleton
    static let shared = StudyPlanManager()
    private let userDefaults = UserDefaults.standard
    private let key = "StudyPlans"
    var studyPlans: [StudyPlan] = []
    
    private init() {
        if let data = userDefaults.data(forKey: key) {
            if let studyPlans = try? JSONDecoder().decode([StudyPlan].self, from: data) {
                self.studyPlans = studyPlans
            }
        }
    }
    
    func savePlans() {
        if let data = try? JSONEncoder().encode(studyPlans) {
            userDefaults.set(data, forKey: key)
            userDefaults.synchronize() // na teoria nao precisa, mas na pratica a teoria eh outra
        }
    }
    
    func addPlan(_ studyPlan: StudyPlan) {
        studyPlans.append(studyPlan)
        savePlans()
    }
    
    func removePlan(at index: Int) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [studyPlans[index].id])
        studyPlans.remove(at: index)
        savePlans()
    }
    
    func setPlanDone(id: String) {
        if let studyPlan = studyPlans.firstIndex(where: { $0.id == id}) {
            studyPlans[studyPlan].done = true
           
            savePlans()
        }
    }
    
}
