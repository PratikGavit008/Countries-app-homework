//
//  ApiManager.swift
//  Countries
//
//  Created by Pratik Gavit on 18/01/23.
//

import Foundation

enum DataError :Error {
    case invalidUrl
    case invalidResponce
    case invalidData
    case networkError(_ error:Error?)
}

final class ApiManager{
    static let shared = ApiManager()
    private init() {}
    
    func getCountriesList(Completion: @escaping ((Result<[CountryModel], DataError>) -> Void)){
        guard let url = URL(string: Constants.Api.countriesUrl) else {
            Completion(.failure(.invalidUrl))
            return}
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data, error == nil else {
                Completion(.failure(.invalidData))
                return
            }
            guard let responce = responce as? HTTPURLResponse, 200...209 ~= responce.statusCode else {
                Completion(.failure(.invalidResponce))
                return
            }
            do {
                let decodedData =  try JSONDecoder().decode([CountryModel].self, from: data)
                Completion(.success(decodedData))
            } catch {
                Completion(.failure(.networkError(error)))
            }
        }.resume()
    }
}
