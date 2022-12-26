/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import Resolver

// MARK: - NetworkServiceProtocol


// MARK: - NetworkService
class NetworkService {
  //Here NetworkService is dependent on URLSession
  //IT is hard to customize session.
  /*
   For example, using a custom configuration instead of the default one in URLSession would change NetworkService.
   */
//	private let session = URLSession(configuration: .default)
  
  //Solution
  /*
   Remove the URLSession constructor and make the session mutable.
   Create an initializer for NetworkService and receive the session as a dependency.
   Update the local session variable with the newly received value from the initializer.
   */
  
  // 1
  private var session: URLSession
  // 2
  init(session: URLSession) {
    // 3
    self.session = session
  }
//Now, NetworkService isn’t responsible for creating the session. Instead, it receives it through the initializer.
}

extension NetworkService {
	func fetch(with urlRequest: URLRequest, completion: @escaping (Result<Data, AppError>) -> Void) {
		guard urlRequest.httpMethod == "GET" else {
			completion(.failure(AppError.network(description: "Something went wrong! Please try again later.")))
			return
		}

		URLSession.shared.dataTask(with: urlRequest) { data, _, error in
			guard
        error == nil,
        let data = data
      else {
				completion(.failure(AppError.network(description: "Something went wrong! Please try again later.")))
				return
			}

			completion(.success(data))
		}
		.resume()
	}
}
