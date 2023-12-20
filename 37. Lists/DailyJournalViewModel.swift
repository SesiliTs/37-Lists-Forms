//
//  DailyJournalViewModel.swift
//  37. Lists
//
//  Created by Sesili Tsikaridze on 20.12.23.
//

import Foundation

@Observable
class DailyJournalViewModel {
    
    //MARK: - Model
    struct News: Hashable {
        var date: Date
        var title: String
        var text: String
    }
    
    //MARK: - Properties
    var newsArray: [News] = []
    var alert = false
    
    //MARK: - Functions
    func addNews(date: Date, title: String, news: String) {
        if title.isEmpty == false && news.isEmpty == false {
            let newElement = News(date: date, title: title, text: news)
            newsArray.append(newElement)
        }
        else {
            alert = true
        }
    }
    
    func moveNews(index: IndexSet, toOffset: Int) {
        newsArray.move(fromOffsets: index, toOffset: toOffset)
    }
    
    func removeNews(at index: IndexSet) {
        newsArray.remove(atOffsets: index)
    }
}
