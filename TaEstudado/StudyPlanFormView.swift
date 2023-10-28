//
//  StudyPlanFormView.swift
//  TaEstudado
//
//  Created by Yuri Cunha on 28/10/23.
//

import SwiftUI

struct StudyPlanFormView: View {
    @Binding private var path: NavigationPath
    @State private var course: String = ""
    @State private var section: String = ""
    @State private var date: Date = .now
    private let notificationCenter = UNUserNotificationCenter.current()
    // para fins didaticos
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        Form {
            TextField("Materia", text: $course)
            TextField("Assunto", text: $section)
            
            Section("Data que ira estudar") {
                DatePicker("Dia do estudo" ,selection: $date)
                    .datePickerStyle(.graphical)
            }
            
            Button {
                createStudyPlan()
            } label: {
                Text("Cadastrar")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Cadastro")
        .task {
            // sempre que for necessario pedir permissao do usuario, pedir sempre na hora que for usar
            // entao como vamos usar aqui vamos pedir permissao
            // depois que aceitar/recusar uma vez a mensagem nao sera mais exibida
            let acceptance = try? await notificationCenter.requestAuthorization(options: [.alert,.badge,.sound,.carPlay])
            
            
            print(acceptance ?? "nao sei")
        }
    }
    
    private func createStudyPlan() {
        let id = UUID().uuidString
        let studyPlan = StudyPlan(id: id, course: course, date: date)
       
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Materia: \(studyPlan.course)"
        content.body = "Estudar "
        content.categoryIdentifier = "lembrete"
        //content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "ring.caf")) // define um som personalizado
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // tem 3 tipos de trigger, calendario, time interval e
        let dateComponent = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: date) // pega uma data e extrai os componentes da data
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: studyPlan.id, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error {
                print(error)
            } else {
                StudyPlanManager.shared.addPlan(studyPlan)
            }
        }
        
        path.removeLast()
    }
}

#Preview {
    NavigationStack {
        StudyPlanFormView(path: .constant(.init()))
    }
}
