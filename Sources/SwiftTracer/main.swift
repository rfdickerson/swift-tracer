import Foundation
import Dispatch

import SimplePNG

import PathTracer

var currentID = 0

let width = 400
let height = 300
let aspectRatio = Double(width)/Double(height)

print("Swift Monte-Carlo Path Tracing renderer")

var objects = [Intersectable]()

let lightMaterial = Material(emission: Color(0.5, 0.5, 0.5),
                             diffuseColor: Color(1.0, 1.0, 1.0),
                             ks: 0, kd: 1.0, n: 0)

let redMaterial = Material(emission: Color(0.0 , 0.0, 0.0),
                           diffuseColor: Color(1.0, 0.0, 0.0),
                           ks: 0.0, kd: 0.7, n: 0)

let greenMaterial = Material(emission: Color(0.0 , 0.0, 0.0),
                             diffuseColor: Color(0.0, 0.5, 0.0),
                             ks: 0.0, kd: 0.7, n: 0)

let yellowMaterial = Material(emission: Color(0.0, 0.0, 0.0),
                              diffuseColor: Color(1.0, 1.0, 0.0),
                              ks: 0.0, kd: 0.3, n: 0)

let blueMaterial = Material(emission: Color(0.0, 0.0, 0.0),
                            diffuseColor: Color(0.0, 0.0, 1.0),
                            ks: 0.0, kd: 0.4, n: 0)

let whiteMaterial = Material(emission: Color(0.0, 0.0, 0.0),
                             diffuseColor: Color(1.0, 1.0, 1.0),
                             ks: 0.0, kd: 0.9, n: 0)


let sphere = Sphere(id: currentID, objectToWorld: Transform.translate(delta: Vector3D(0,-0.3,-0.7)),
                    radius: 0.3,
                    material: whiteMaterial)

objects.append(sphere)
currentID += 1

let sphere2 = Sphere(id: currentID, objectToWorld: Transform.translate(delta: Vector3D(-0.4,0.3,-0.7)),
                    radius: 0.3,
                    material: whiteMaterial)

objects.append(sphere2)
currentID += 1

let sphere3 = Sphere(id: currentID, objectToWorld: Transform.translate(delta: Vector3D(0.4,0.3,-0.7)),
                     radius: 0.3,
                     material: whiteMaterial)

objects.append(sphere3)
currentID += 1


let triangle = Triangle(
    id: currentID,
    v1: Vector3D(-1, -1, 0),
    v2: Vector3D(1,  -1, 0),
    v3: Vector3D(-1,  1, 0),
    material: whiteMaterial,
    objectToWorld: Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

let triangle2 = Triangle(
    id: currentID,
    v1: Vector3D(1, -1, 0),
    v2: Vector3D(1,  1, 0),
    v3: Vector3D(-1, 1, 0),
    material: whiteMaterial,
    objectToWorld: Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

let triangle3 = Triangle(
    id: currentID,
    v1: Vector3D(-1, -1, -1),
    v2: Vector3D(-1, -1,  1),
    v3: Vector3D(-1,  1, -1),
    material: greenMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

let triangle4 = Triangle(
    id: currentID,
    v1: Vector3D(-1, -1, 1),
    v2: Vector3D(-1,  1, 1),
    v3: Vector3D(-1,  1, -1),
    material: greenMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

let triangle5 = Triangle(
    id: currentID,
    v1: Vector3D(1, -1, -1),
    v2: Vector3D(1,  1, -1),
    v3: Vector3D(1,  -1, 1),
    material: redMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

let triangle6 = Triangle(
    id: currentID,
    v1: Vector3D(1, -1,  1),
    v2: Vector3D(1,  1, -1),
    v3: Vector3D(1,  1,  1),
    material: redMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

let triangle7 = Triangle(
    id: currentID,
    v1: Vector3D( 1, 1, -1),
    v2: Vector3D(-1, 1,  1),
    v3: Vector3D( 1, 1,  1),
    
    
    material: whiteMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1


let triangle8 = Triangle(
    id: currentID,
    v1: Vector3D( -1, 1, -1),
    v2: Vector3D(-1, 1,  1),
    v3: Vector3D( 1, 1,  -1),
    material: whiteMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

let triangle9 = Triangle(
    id: currentID,
    v1: Vector3D( -1, -1, -1),
    v2: Vector3D( 1, -1,  -1),
    v3: Vector3D(-1, -1,  1),
    
    material: whiteMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

let triangle10 = Triangle(
    id: currentID,
    v1: Vector3D(1, -1,  -1),
    v2: Vector3D( 1, -1, 1),
    v3: Vector3D( -1, -1,  1),
    material: whiteMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

let triangleLight = Triangle(
    id: currentID,
    v1: Vector3D( -0.2, 0.8,  -1),
    v2: Vector3D(  0.2, 0.8, -1),
    v3: Vector3D( -0.2, 0.8, -1),
    material: lightMaterial,
    objectToWorld:  Transform.translate(delta: Vector3D(0,0,0))
)
currentID += 1

//objects.append(triangle)
//objects.append(triangle2)
//objects.append(triangle3)
//objects.append(triangle4)
//objects.append(triangle5)
//objects.append(triangle6)
//objects.append(triangle7)
//objects.append(triangle8)
//objects.append(triangle9)
//objects.append(triangle10)

let lookAt = Transform.lookAtMatrix(
    eye:  Vector3D(0.05,   -6.50,    0.34),
    target: Vector3D(0.0,   -0.30,    -0.7),
    up:   Vector3D(0.0,   0.0,    1.0))

let perspective = Transform.perspectiveMatrix(
    near: 0.01,
    far:  100.0,
    fov:  55,
    aspect: aspectRatio)

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


let pathtracer = PathTracer()

let scene = Scene()

let pointLight = Light(0,0,0)

scene.append( triangle )
scene.addLight( pointLight )

print("Rendering...")

let dispatchQueue = DispatchQueue(label: "renderqueue", attributes: .concurrent)
let dispatchGroup = DispatchGroup()
let semaphore = DispatchSemaphore(value: 1)

var bitmap = Bitmap(repeating: [Pixel](), count: height)

for j in 0...height-1 {
    
    dispatchQueue.async(group: dispatchGroup) {
        
        var row: [Pixel] = [Pixel]()
        
        for i in 0...width-1 {
            
            let x = Number(i)
            let y = Number(j)
            
            let color = adaptiveSample(x: x, y: y, depth: 1)
            
            row.append( Pixel.srgb(Float(color.x), Float(color.y), Float(color.z)))
            
        }
        
        semaphore.wait()
        //bitmap.append(row)
        bitmap[j] = row
        semaphore.signal()
        
    }
    
}

// sleep(1)

dispatchGroup.wait()

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



