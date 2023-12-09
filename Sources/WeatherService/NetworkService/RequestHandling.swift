//
//  RequestHandling.swift
//  
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

//Protocol for the `RequestHandler`. The network service will conform to this protocol and implement the method
//
//`RequestHandler` is generalized enough to work on potential new `APIRoute`s as well.
protocol RequestHandling {
    func request<T: Decodable>(route: APIRoute, completion: @escaping (Result<T, DataLoadError>) -> Void)
}
