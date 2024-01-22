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

import Resolver
import XCTest
@testable import Cryptic

/*
 Here, you test if AssetService handles the success and failure responses of NetworkService as expected.

 In cases like this, mocking is an excellent approach because you’re in control of how you challenge your Subject Under Test, or SUT, based on different response types.
 */
class AssetServiceTests: XCTestCase {
  // MARK: - Properties
  /*
   By using **Lazy Injection** you ask Resolver to **lazy load** dependencies. Thus, Resolver won’t resolve this dependency before the first time it’s used.

   You need to use @LazyInjected here because the dependencies aren’t available when the class is initiated as you registered them in setup().
   */
  @LazyInjected var networkService: MockNetworkService

	var sut: AssetService?


  // MARK: - Life Cycle
	override func setUp() {
		super.setUp()

		sut = AssetService()
    
    Resolver.registerMockServices()

	}

	override func tearDown() {
		sut = nil

		super.tearDown()
	}
}

// MARK: - Unit tests
extension AssetServiceTests {
  /*
   Create a mock asset. The helper method mockAsset() is already included in the codebase for you. You’re welcome. :]
   Assert a success result to MockNetworkService as you test a success case.
   Fetch the assets from MockNetworkService. Test if you receive the same asset back as you provided to MockNetworkService.

   */
  func testFetchAssetsSuccessfully() {
    // 1
    let asset = mockAsset()
    // 2
    networkService.result = .success(assetList())

    // 3
    sut?.fetchAssets { assetList, error in
      XCTAssertEqual(assetList?.data.count, 1)
      XCTAssertEqual(assetList?.data.first, asset)
      XCTAssertNil(error)
    }

  }
/*
 Create a mock error of type AppError, as it’s the error type in this project.
 Then create a failure result with networkError and pass it to the MockNetworkService. That’s the benefit of mocking dependencies: you have complete control over the response.
 Fetch the assets from MockNetworkService. Test if you receive the same error back as you provided to MockNetworkService.
 */
  func testFetchAssetsFailure() {
    // 1
    let networkError = AppError.network(description: "Something went wrong!")
    // 2
    networkService.result = .failure(networkError)

    // 3
    sut?.fetchAssets { assetList, error in
      XCTAssertEqual(networkError, error)
      XCTAssertNil(assetList)
    }
  }
}

// MARK: - Helper functions
extension AssetServiceTests {
	private func mockAsset() -> Asset {
		Asset(
			id: "bitcoin",
			name: "Bitcoin",
			symbol: "BTC",
			changePercent24Hr: "4.6112912338284003",
			marketCapUsd: "1136551580407.9842430",
			priceUsd: "60867.8140898007")
	}

  private func assetList() -> Data {
    let asset = mockAsset()
    let assetListData = try? JSONEncoder().encode(AssetList(data: [asset]))
    return assetListData ?? Data()
  }
}
