//
//  StudyPlan.swift
//  TaEstudado
//
//  Created by Yuri Cunha on 28/10/23.
//

import Foundation

enum DateHelper {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        // formatter.locale = Locale(identifier: "pt-BR") nao precisa pq ele pega pela regiao do dispositivo, usado somente se o uso for independente da regiao
        // formatter.dateFormat = "MM/YY" assim voce define o formato que quer
        formatter.timeStyle = .short // pra mostrar a hora
        return formatter
    }()
    static func format(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
}


struct StudyPlan: Identifiable, Codable {
    let id: String
    let course: String
    let date: Date
    var done: Bool = false
    
    var dateFormatted: String {
        DateHelper.format(date)
    }
}
