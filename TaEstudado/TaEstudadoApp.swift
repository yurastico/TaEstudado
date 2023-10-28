//
//  TaEstudadoApp.swift
//  TaEstudado
//
//  Created by Yuri Cunha on 28/10/23.
//

import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    private let center = UNUserNotificationCenter.current()
    private let notificationCenterDelegate = NotificationCenterDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // eh o metodo que eh disparado sempre que abrimos o app, sem estar em background, otimo momento pra fazer ocisas na hora que abrimos o app
        
        
        // inves de um obj executar algo, ele delega para um outro objeto executar
        center.delegate = notificationCenterDelegate // pra que eu delegue pra alguem, esse alguem tem que ser apto a fazer o que eu quero, entao pra receber aqui, ele tem que implementar x protocolo
        
        let confirmActions = UNNotificationAction(identifier: "confirm", title: "Ja estudei",options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "cancel", title: "Cancelar")
        let category = UNNotificationCategory(identifier: "lembrete", actions: [confirmActions,cancelAction], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
        return true
    }
}

final class NotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    // se nao der erro apos implementarmos um protocolo, significa que os metodos nao sao obrigatorios
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // dispara qunado recebe a resposta de uma notificacaco
        print("recebi norifcicacao")
        
        switch response.actionIdentifier {
        case "confirm":
            print("o usuario confirmou")
            //StudyPlanManager.shared.setPlanDone(id: )
            
            
        case "cancel":
            print("o usuario cancelou")
        case UNNotificationDefaultActionIdentifier:
            print("o usuario clicou")
        case UNNotificationDismissActionIdentifier:
            print("o usuario dismiss")
        default:
            print("caiu no default")
        }
        
        completionHandler()
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // exibe quando o app esta aberto
        print("estou usando com o app aberto")
        completionHandler([.banner,.badge])
    }
    
   
}

@main
struct TaEstudadoApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
