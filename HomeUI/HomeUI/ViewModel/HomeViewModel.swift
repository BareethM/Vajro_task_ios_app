//
//  HomeModel.swift
//  HomeUI
//
//  Created by Bareeth on 21/01/23.
//

import Foundation


class HomeViewModel{
    
    func callApi(completionHandler: @escaping(_ additionOfNumberUsingClosuer: HomeData)->Void){
        
        let url = URL(string: "https://run.mocky.io/v3/cdc1c53e-2825-4162-826d-b8294e477934")!
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
               if let notes = try? JSONDecoder().decode(HomeData.self, from: data) {
                    print(notes)
                    completionHandler(notes)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
               
            }
        }
        task.resume()
    }
}



