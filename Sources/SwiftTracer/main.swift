import Foundation
import Dispatch

import SimplePNG

import PathTracer

let width = 300
let height = 200
let aspectRatio = Double(width)/Double(height)

print("Swift Monte-Carlo Path Tracing renderer")

var objects = [Intersectable]()

let lightMaterial = Material(emission: Color(0.5, 0.5, 0.5),
                             diffuseColor: Color(1.0, 1.0, 1.0),
                             ks: 0, kd: 1.0, n: 0)

let redMaterial = Material(emission: Color(0.0 , 0.0, 0.0),
                           diffuseColor: Color(1.0, 0.0, 0.0),
                           ks: 0.0, kd: 0.3, n: 0)

let greenMaterial = Material(emission: Color(0.0 , 0.0, 0.0),
                             diffuseColor: Color(0.0, 0.5, 0.0),
                             ks: 0.0, kd: 0.3, n: 0)

let yellowMaterial = Material(emission: Color(0.0, 0.0, 0.0),
                              diffuseColor: Color(1.0, 1.0, 0.0),
                              ks: 0.0, kd: 0.3, n: 0)

let blueMaterial = Material(emission: Color(0.0, 0.0, 0.0),
                            diffuseColor: Color(0.0, 0.0, 1.0),
                            ks: 0.0, kd: 0.3, n: 0)

let whiteMaterial = Material(emission: Color(0.0, 0.0, 0.0),
                             diffuseColor: Color(1.0, 1.0, 1.0),
                             ks: 0.0, kd: 0.3, n: 0)


let sphere = Sphere(objectToWorld: Transform.translate(delta: Vector3D(0,0,5)),
                    radius: 0.3,
                    material: whiteMaterial)

objects.append(sphere)

//for j in 0...6 {
//    for i in 0...6 {
//
//        let mat = Material(emission: Color(0.1 , 0.1, 0.0),
//                           diffuseColor: Color(Number(i)/6, Number(j)/6, 0.8),
//                           ks: 0.0,
//                           kd: 0.8,
//                           n: 0)
//
//        let objectToWorld = Transform.translate(delta: Vector3D(-0.5 + Number(j)/6,
//                                                                -0.5 + Number(i)/6,
//                                                                9))
//
//        objects.append(Sphere(objectToWorld: objectToWorld,
//                              radius: 0.050,
//                              material: mat))
//    }
//}

let triangle = Triangle(
    v1: Vector3D(-1, -1, 0),
    v2: Vector3D(1,  -1, 0),
    v3: Vector3D(-1,  1, 0),
    material: whiteMaterial,
    objectToWorld: Transform.translate(delta: Vector3D(0,0,10))
)

let triangle2 = Triangle(
    v1: Vector3D(1, -1, 0),
    v2: Vector3D(1,  1, 0),
    v3: Vector3D(-1, 1, 0),
    material: whiteMaterial,
    objectToWorld: Transform.translate(delta: Vector3D(0,0,10))
)

let triangle3 = Triangle(
    v1: Vector3D(-1, -1, -5),
    v2: Vector3D(-1, -1,  1),
    v3: Vector3D(-1,  1, -5),
    material: greenMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,10))
)

let triangle4 = Triangle(
    v1: Vector3D(-1, -1, 1),
    v2: Vector3D(-1,  1, 1),
    v3: Vector3D(-1,  1, -5),
    material: greenMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,10))
)

let triangle5 = Triangle(
    v1: Vector3D(1, -1, -5),
    v2: Vector3D(1,  1, -5),
    v3: Vector3D(1,  -1, 1),
    material: redMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,10))
)

let triangle6 = Triangle(
    v1: Vector3D(1, -1,  1),
    v2: Vector3D(1,  1, -5),
    v3: Vector3D(1,  1,  0),
    material: redMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,10))
)

let triangle7 = Triangle(
    v1: Vector3D( 1, 1, -5),
    v2: Vector3D(-1, 1,  1),
    v3: Vector3D( 1, 1,  1),
    
    
    material: yellowMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,10))
)

let triangle8 = Triangle(
    v1: Vector3D( -1, 1, -5),
    v2: Vector3D(-1, 1,  1),
    v3: Vector3D( 1, 1,  -5),
    
    
    
    material: yellowMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,10))
)

let triangle9 = Triangle(
    v1: Vector3D( -1, -1, -5),
    v2: Vector3D( 1, -1,  -5),
    v3: Vector3D(-1, -1,  1),
    
    material: blueMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,10))
)

let triangle10 = Triangle(
    v1: Vector3D(1, -1,  -5),
    v2: Vector3D( 1, -1, 1),
    v3: Vector3D( -1, -1,  1),
    material: blueMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,10))
)

let triangleLight = Triangle(
    v1: Vector3D( -0.2, 0.8,  -5),
    v2: Vector3D(  0.2, 0.8, -5.2),
    v3: Vector3D( -0.2, 0.8, -5),
    material: lightMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,10))
)


objects.append(triangle)
objects.append(triangle2)
objects.append(triangle3)
objects.append(triangle4)
objects.append(triangle5)
objects.append(triangle6)
objects.append(triangle7)
objects.append(triangle8)
objects.append(triangle9)
objects.append(triangle10)

objects.append(triangleLight)

//let triangle2 = Triangle(
//    a: Vector3D(552.8, -200, 20),
//    b: Vector3D(200,     -20, 20),
//    c: Vector3D(0,     -20, 559.2),
//    material: redMaterial,
//    objectToWorld: Transform()
//)
//
//objects.append(triangle2)

//let floorMatrix = Transform.translate(delta: Vector3D(0.0, -5000.0, 0.0))
//objects.append(Sphere(  objectToWorld: floorMatrix,
//                        radius: 5000,
//                        material: whiteMaterial))

//let leftMatrix = Transform.translate(delta: Vector3D(-2700.0, 0.0, 0.0))
//objects.append(Sphere(  objectToWorld: leftMatrix,
//                        radius: 5000,
//                        material: yellowMaterial))




let lookAt = Transform.lookAtMatrix(
    pos:  Vector3D(0.0,   1.0,    -3.0),
    look: Vector3D(0.0,   0.02,    1.0),
    up:   Vector3D(0.0,   -1.0,    0.0))

let perspective = Transform.perspectiveMatrix(
    near: 0.01,
    far:  100.0,
    fov:  55,
    aspect: aspectRatio)

// converts -1:1 coordinates to 0:300
let screenToRaster = Transform.scale(withVector: Vector3D(
    Number(width), Number(height), 1.0))
    * Transform.scale(withVector: Vector3D(1, 1/aspectRatio, 1))
    * Transform.translate(delta: Vector3D(-Number(width)/2, -Number(height)/2, 0.0))

let rasterToScreen = screenToRaster.inverse

let cameraToScreen = perspective
let screenToCamera = cameraToScreen.inverse

let cameraToWorld = lookAt.inverse
let worldToCamera = cameraToWorld.inverse

let worldToScreen = cameraToScreen * cameraToWorld

let rasterToWorld =  cameraToWorld * screenToCamera * rasterToScreen

let screenCoords = rasterCoordinates(width: Int(width),
                                     height: Int(height))
var origin = Vector3D(0.0, 0.0, 0.0)

let sampleOrigin = cameraToWorld * origin

print("Rendering...")

var bitmap = Bitmap()

for j in 0...height-1 {
    
    var row: [Pixel] = [Pixel]()
    
    for i in 0...width-1 {
        
        let x = Number(i)
        let y = Number(j)
        
        var direction = rasterToWorld * Vector3D(x, y, 1)
        direction = norm(direction)
        
        let ray = Ray(origin: origin,
                      direction: direction)
        
        let color = castRay(ray: ray,
                            bounceDepth: 0,
                            objects: objects)
        
        row.append( Pixel.srgb(Float(color.x), Float(color.y), Float(color.z)))
        
    }
    
    bitmap.append(row)
    
}

var image = Image( width: width,
                   height: height,
                   colorType: ColorType.rgb,
                   bitDepth: 8,
                   bitmap: bitmap
)

do {
    try image.write(to: URL(fileURLWithPath: "image.png"))
    print("Wrote image to image.png")
} catch {
    print("Could not export the image")
}

