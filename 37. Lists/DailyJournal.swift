//
//  ContentView.swift
//  37. Lists
//
//  Created by Sesili Tsikaridze on 20.12.23.
//

import SwiftUI

struct DailyJournal: View {
    
    //MARK: - Properties
    @State var viewModel = DailyJournalViewModel()
    
    @State var title: String = ""
    @State var news: String = ""
    @State private var date = Date()
    
    
    //MARK: - Body
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("Add News")
            Form {
                DatePicker(
                    "choose news date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .font(.system(size: 16, weight: .light))
                .padding(.bottom, 20)
                TextField("Title", text: $title)
                TextField("News", text: $news, axis: .vertical)
                
            }
            .scrollContentBackground(.hidden)
            .frame(height: 200)
            
            Button("save news") {
                viewModel.addNews(date: date, title: title, news: news)
                title = ""
                news = ""
            }
            .buttonStyle(BorderlessButtonStyle())
            .font(.system(size: 18, weight: .bold))
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.yellow)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(20)
            .alert(isPresented: $viewModel.alert) {
                Alert(title: Text("please fill out all fields"), dismissButton: .default(Text("OK")))
            }
            
            
            Text("News")
            List {
                if viewModel.newsArray.isEmpty {
                    Text("loos like there's no news...")
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(viewModel.newsArray, id: \.self) { news in
                        newsViewComponent(date: news.date, title: news.title, news: news.text)
                    }
                    
                    .onDelete(perform: { indexSet in
                        viewModel.removeNews(at: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        viewModel.moveNews(index: indices, toOffset: newOffset)
                    })
                    
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
    
    //MARK: - List Component View
    
    private func newsViewComponent(date: Date, title: String, news: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(date, style: .date)")
                .font(.system(size: 14, weight: .light))
                .foregroundStyle(.gray)
            Text(title)
                .font(.system(size: 18, weight: .bold))
            Text(news)
                .font(.system(size: 16, weight: .light))
        }
    }
    
}

#Preview {
    DailyJournal()
}
