//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Arne Moen on 10/24/24.
//

import XCTest
@testable import Recipes

final class RecipesTests: XCTestCase {
    
    let recipesUrlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    let malformedUrlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    let emptyDataUrlString = " https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulRecipeDownload() async {
        do {
            let recipes = try await NetworkManager.shared.getRecipes(urlString: recipesUrlString)
            XCTAssertNotNil(recipes, "Recipes are not expected to be nil")
            XCTAssertGreaterThan(recipes.count, 0, "Recipes are expected contain values")
        } catch {
            XCTFail("Expected recipes to be fetched without assert")
        }
    }

    func testMalformedRecipeDownload() async {
        do {
            let recipes = try await NetworkManager.shared.getRecipes(urlString: malformedUrlString)
            XCTAssertNil(recipes, "Recipes are expected to be nil with a malformed url")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse, "The error thrown is expected to be of type invalidResponse")
        }
    }

    func testEmptyDataRecipeDownload() async {
        do {
            let recipes = try await NetworkManager.shared.getRecipes(urlString: emptyDataUrlString)
            XCTAssertNil(recipes, "Recipes are expected to be nil with an empty data url")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL, "The error thrown is expected to be of type invalid data")
        }
    }

    func testImageDownloadInvalidUrl() {
        NetworkManager.shared.getImage(fromURLString: "invalidUrl") { image in
            XCTAssertNil(image, "Images are expected to be nil with an invalid url")
        }
    }
    
    func testImageDownloadValidUrl() {
        NetworkManager.shared.getImage(fromURLString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg") { image in
            XCTAssertNotNil(image, "The image is expected to download successfully")
        }
    }
    
    @MainActor func testRecipeViewModelInitialValues() async {
        let vm = RecipeViewModel()
        XCTAssertNotNil(vm.recipes, "The default value for recipes must not be nil")
        XCTAssertTrue(vm.recipes.count == 0, "The default value count for recipes must not be zero")
        XCTAssertFalse(vm.loading, "The default value for loading must be false")
        XCTAssertNil(vm.netWorkError, "The default value for netWorkError must be nil")
        XCTAssertFalse(vm.hasAlert, "The default value for hasAlert must be false")
        XCTAssertFalse(vm.sortByName, "The default value for sortByName must be false")
    }
}
