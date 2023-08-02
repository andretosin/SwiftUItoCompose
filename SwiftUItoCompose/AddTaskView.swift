//
//  AddTaskView.swift
//  SwiftUItoCompose
//
//  Created by Andre on 01/08/23.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var newTask: Task?
    @Binding var isPresented: Bool // Binding para controlar a apresentação da tela

    @State private var title = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Título")) {
                    TextField("Digite o título da tarefa", text: $title)
                }
                Section(header: Text("Descrição")) {
                    TextField("Digite a descrição da tarefa", text: $description)
                }
            }
            .navigationBarTitle("Adicionar Tarefa", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancelar") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Salvar") {
                    // Adiciona a nova tarefa à lista e fecha a tela de adição
                    newTask = Task(title: title, description: description)
                    isPresented = false
                }
            )
        }
    }
}


struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
