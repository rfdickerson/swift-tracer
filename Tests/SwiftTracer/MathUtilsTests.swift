//
//  MathUtilsTests.swift
//  SwiftTracer
//
//  Created by Robert Dickerson on 6/17/16.
//  Copyright © 2016 Swift@IBM Engineering. All rights reserved.
//

import XCTest

@testable import SwiftTracer

class MathUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMultiply() {
        
        let v1 = Vector3D(x: 1, y: 2, z: 3)
        let m1 = createTransform(withTranslation: Vector3D(x: 3,y: 5,z: 6))
        let m2 = createTransform(withTranslation: Vector3D(x: 3,y: 5,z: 6))
        
        let v2 = m1 * v1
        let v3 = m2 * v2
        
        
        XCTAssertEqual(v2.x, 4)
        XCTAssertEqual(v2.y, 7)
        XCTAssertEqual(v2.z, 9)
        
        XCTAssertEqual(v3.x, 7)
        XCTAssertEqual(v3.y, 12)
        XCTAssertEqual(v3.z, 15)
        
    }
    
    func testDotProduct() {
        
        let a = Vector3D(x: 1, y: 2, z: 3)
        let b = Vector3D(x: 4, y: -5, z: 6)
        
        // 4 -10 + 18
        
        let product = dot(a,b)
        
        XCTAssertEqual(product, 12)
        
    }
    
    func testNormalize() {
        
        let a = Vector3D(x: 3, y: 4, z: 5)
        
        let na = norm(a)
        
        XCTAssertEqual(na.x*na.x+na.y*na.y+na.z*na.z, 1)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        let m1 = createTransform(withTranslation: Vector3D(x: 3,y: 5,z: 6))
        
        self.measure {
            let _ = determinant(m1)
            // Put the code you want to measure the time of here.
        }
    }
    
}