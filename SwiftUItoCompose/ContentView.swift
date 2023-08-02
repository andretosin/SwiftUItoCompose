//
//  ContentView.swift
//  SwiftUItoCompose
//
//  Created by Andre on 01/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks = [
        Task(title: "Tarefa 1", description: "Descrição da Tarefa 1"),
        Task(title: "Tarefa 2", description: "Descrição da Tarefa 2"),
        Task(title: "Tarefa 3", description: "Descrição da Tarefa 3")
    ]
    @State private var selectedTask: Task? = nil // Estado para controlar a tarefa selecionada
    @State private var newTask: Task? = nil // Estado para representar a nova tarefa a ser adicionada
    @State private var isShowingAddTaskView = false // Estado para controlar a apresentação da tela de adição de tarefas

    var body: some View {
            NavigationView {
                VStack {
                    HStack {
                        Text("Lista de Tarefas")
                            .font(.title)

                        Spacer()

                        Button(action: {
                            selectedTask = nil
                            newTask = Task(title: "", description: "")
                            isShowingAddTaskView = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    .padding(.horizontal)

                    List {
                        ForEach(tasks) { task in
                            TaskRow(task: task, selectedTask: $selectedTask)
                                .contextMenu {
                                    Button(action: {
                                        deleteTask(task: task)
                                        if tasks.isEmpty {
                                            selectedTask = nil // Definir selectedTask como nil quando a lista estiver vazia
                                        }
                                    }) {
                                        Label("Excluir", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                }
                .background(
                    NavigationLink(
                        destination: TaskDetailView(task: selectedTask ?? Task(title: "Tarefa 32", description: "Descrição da Tarefa 32")),
                        isActive: Binding<Bool>(
                            get: { selectedTask != nil },
                            set: { if !$0 { selectedTask = nil } }
                        ),
                        label: {
                            EmptyView()
                        }
                    )
                    .hidden()
                )
                .sheet(isPresented: $isShowingAddTaskView, content: {
                    AddTaskView(newTask: $newTask, isPresented: $isShowingAddTaskView)
                        .onDisappear {
                            newTask = nil
                        }
                })
                .onChange(of: newTask) { task in
                    if let newTask = task {
                        if !newTask.title.isEmpty {
                            tasks.append(newTask)
                        }
                        self.newTask = nil
                    }
                }
            }
        }

    func deleteTask(task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
        }
    }
}




struct TaskRow: View {
    @State private var showDescription = false
    var task: Task
    @Binding var selectedTask: Task?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(task.title)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(showDescription ? 90 : 0))
            }
            if showDescription {
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Button("Ver mais") {
                    // Ação específica do botão "Ver mais"
                    selectedTask = task
                }
                .foregroundColor(.blue)
                .buttonStyle(PlainButtonStyle()) // Evita a ação de toggle ao clicar no botão
            }
        }
        .contentShape(Rectangle()) // Make the whole VStack tappable
        .onTapGesture {
            showDescription ? showDescription.toggle() : withAnimation{ showDescription.toggle() }
        }
    }
}

struct ProgressBar: View {
    var value: Double
    var maxValue: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(geometry.size.height / 2) // Cantos arredondados
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: min(CGFloat(value / maxValue) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .cornerRadius(geometry.size.height / 2) // Cantos arredondados
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
