//
//  TaskDetailsView.swift
//  SwiftUItoCompose
//
//  Created by Andre on 01/08/23.
//

import SwiftUI

struct TaskDetailView: View {
    var task: Task

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(task.title)
                    .font(.title)

                Text(task.description)
                    .font(.body)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle("Detalhes da Tarefa", displayMode: .inline)
    }
}


struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(title: "Tarefa 1", description: "Descrição da Tarefa 1"))
    }
}
