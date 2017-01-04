import Foundation
import Dispatch


public typealias Color = Vector3D

public let backgroundColor = Vector3D(1.00, 1.00, 1.00)

// map values [-1 : 1] to [0 : 1 ]
func normalColor(_ v: Vector3D ) -> Vector3D {
    return Vector3D((v.x+1)/2, (v.y+1)/2, (v.z+1)/2)
}


public func castRay(ray: Ray,
                    bounceDepth: Int,
                    objects: [Intersectable]) -> Color {
    
    // var illuminance = Color(x: 0.0, y: 0.0, z: 0.0)
    let numberOfSamples = 10
    let sampleLight = Vector3D(0.0, 0.0, 0.0)
    
    if bounceDepth > 1 { return backgroundColor }
    
    // find the closest object
    
    var shortestDepth = Double.greatestFiniteMagnitude
    var closestObject: Intersectable? = nil
    var closestCollision: Collision? = nil
    
    for object in objects {
        
        if let collision = object.intersect(ray: ray) {

            if collision.depth < shortestDepth {
                shortestDepth = collision.depth
                closestCollision = collision
                closestObject = object
            }
            
        }
    }
    
    // Compute lighting
    
    if let closestObject = closestObject, let closestCollision = closestCollision {
     
        let lightDirection = norm(closestCollision.intersection - sampleLight)
        
        let lightAngle = clamp(low: 0, high: 1, value: dot( lightDirection, closestCollision.normal ) )
        
        let material = closestObject.material
        
        let diffuseIlluminance = lightAngle * material.diffuseColor
        let emissionIlluminance = material.emission
        
        if diffuseIlluminance.x < 0 || diffuseIlluminance.x > 1 {
            print("Can't be less than zero!!!")
        }
        
        let directLight = (material.kd * diffuseIlluminance) + emissionIlluminance
        
        // get a random hemisphere
        
        var indirectLight: Vector3D = Vector3D(0,0,0)
        
        let globalIllumination = true
        
        if globalIllumination {
            for _ in 0...numberOfSamples {
                let newDirection = cosWeightedRandomHemisphere(n: closestCollision.normal)
                let newRay = Ray(origin: closestCollision.intersection, direction: newDirection, minT: 0, maxT: 1)
                
                let indirectLightAngle = clamp(low: 0, high: 1, value: dot( newDirection, closestCollision.normal ) )
                
                indirectLight = indirectLight + indirectLightAngle * castRay(ray: newRay, bounceDepth: bounceDepth+1, objects: objects)
            }
        }
        
        indirectLight = (1/Number(numberOfSamples)) * indirectLight
        
        return clamp(low:0, high: 1, value: 1/(M_PI) * material.diffuseColor * (indirectLight + 2*directLight) )

        
    }
    
    return backgroundColor
    
}

public func cosWeightedRandomHemisphere( n: Vector3D) -> Vector3D {
    
    //let Xi1 = Number(arc4random())/Number(UINT32_MAX)
    //let Xi2 = Number(arc4random())/Number(UINT32_MAX)
    
    let Xi1 = drand48()
    let Xi2 = drand48()

    let theta = acos(sqrt(1.0-Xi1))
    let phi = 2.0 * Number(M_PI) * Xi2
    
    let xs = sin(theta) * cos(phi)
    let ys = cos(theta)
    let zs = sin(theta) * sin(phi)
    
    var h: Vector3D
    if fabs(n.x) <= fabs(n.y) && fabs(n.x) <= fabs(n.z) {
        h = Vector3D(1.0, n.y, n.z)
    } else if fabs(n.y) <= fabs(n.x) && fabs(n.y) <= fabs(n.z) {
        h = Vector3D(n.x, 1.0, n.z)
    } else {
        h = Vector3D(n.x, n.y, 1.0)
    }
    
    let x = norm(cross(h, n))
    let z = norm(cross(x, n))
    
    let direction =  xs * x + ys * n + zs * z
    return norm(direction)
    
}






/**
 Creates an array of screenCoordinates to sample from in Raster Space
 0 to width and 0 to height
 
 - parameter width: width of the pixel surface
 - parameter height: height of the pixel surface
 - returns: an array of the pixels of the surface
 */
public func rasterCoordinates(width: Int, height: Int) -> [Vector3D] {
    
    var coords = [Vector3D]()
    
    for j in 0...height-1 {
        for i in 0...width-1 {
            
            let x = Number(i)
            let y = Number(j)
            
            coords.append(Vector3D(x, y, 1.0))
        }
    }
    
    return coords
}






