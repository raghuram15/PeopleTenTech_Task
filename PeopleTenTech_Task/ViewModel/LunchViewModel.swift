//
//  LunchViewModel.swift
//  PeopleTenTech_Task
//
//  Created by Raghuram on 29/05/20.
//  Copyright © 2020 Raghuram. All rights reserved.
//

import UIKit

class LunchViewModel{
     var dataModel : LunchModel?
    
    func fetchJson(completion: @escaping(Result<LunchModel, Error>) -> ()) {
               
               guard let url = URL(string: Constants.fetchRestaurentsURL) else {
                   return
               }
               
               URLSession.shared.dataTask(with: url) { (data, res, err) in
                   
                   
                   if let err = err {
                       completion(.failure(err))
                       return
                   }
                   
                   //Successful
                   
                   do {
                       
                       let lunch = try JSONDecoder().decode(LunchModel.self, from: data!)
                     self.dataModel = lunch
                       completion(.success(lunch))
                    
                   }catch let jsonError {
                       completion(.failure(jsonError))
                   }
                   
               }.resume()
               
           }
    
    
    
   
    
}
