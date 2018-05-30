import MetalKit

struct Particle{
    var color: float4
    var position: float2
    var velocity: float2
}

struct ModelConstants{
    var modelMatrix = matrix_identity_float4x4
}

class MainView: MTKView {
    
    @IBOutlet weak var txtParticleCount: NSTextField!
    @IBOutlet weak var sldParticleCount: NSSlider!
    
    var commandQueue: MTLCommandQueue!
    
    var sampler: MTLSamplerState!
    var clearPass: MTLComputePipelineState!
    var dotPass: MTLComputePipelineState!

    var particleBuffer: MTLBuffer!
    
    var particleCount: Int = 10_000
    var modelConstants = ModelConstants()
    
    var screenSize: Float {
        return Float(self.bounds.width * 2)
    }

    override func viewDidMoveToWindow() {
        txtParticleCount.stringValue = String(particleCount)
        sldParticleCount.floatValue = Float(particleCount)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        self.commandQueue = device?.makeCommandQueue()
        self.colorPixelFormat = .bgra8Unorm
        self.framebufferOnly = false
        
        let library = device?.makeDefaultLibrary()
        let clearFunction = library?.makeFunction(name: "clear_kernel")
        let dotFunction = library?.makeFunction(name: "dot_kernel")
        
        do{
            clearPass = try device?.makeComputePipelineState(function: clearFunction!)
            dotPass = try device?.makeComputePipelineState(function: dotFunction!)
        }catch let error as NSError{
            print(error)
        }
        createParticles()
    }
    
    func createParticles(){
        var particles: [Particle] = []
        for _ in 0..<particleCount{
            let red: Float = Float(arc4random_uniform(100)) / 100
            let green: Float = Float(arc4random_uniform(100)) / 100
            let blue: Float = Float(arc4random_uniform(100)) / 100
            let particle = Particle(color: float4(red, green, blue, 1),
                                    position: float2(Float(arc4random_uniform(UInt32(screenSize))),
                                                     Float(arc4random_uniform(UInt32(screenSize)))),
                                    velocity: float2((Float(arc4random() %  10) - 5) / 10,
                                                     (Float(arc4random() %  10) - 5) / 10))
            particles.append(particle)
        }
        particleBuffer = device?.makeBuffer(bytes: particles, length: MemoryLayout<Particle>.stride * particleCount, options: .storageModeManaged)
    }
    
    func doComputePass(computeEncoder: MTLComputeCommandEncoder, drawable: CAMetalDrawable){
        computeEncoder.setTexture(drawable.texture, index: 0)
        
        //Clear the screen
        computeEncoder.setComputePipelineState(clearPass)

        let w = clearPass.threadExecutionWidth
        let h = clearPass.maxTotalThreadsPerThreadgroup / w
        var threadsPerGrid = MTLSize(width: drawable.texture.width, height: drawable.texture.height, depth: 1)
        var threadsPerThreadGroup = MTLSize(width: w, height: h, depth: 1)
        computeEncoder.dispatchThreads(threadsPerGrid, threadsPerThreadgroup: threadsPerThreadGroup)
 
        //Render And Animate Dots
        computeEncoder.setComputePipelineState(dotPass)
        computeEncoder.setBuffer(particleBuffer, offset: 0, index: 0)
        
        threadsPerGrid = MTLSize(width: particleCount, height: 1, depth: 1)
        threadsPerThreadGroup = MTLSize(width: w, height: 1, depth: 1)
        computeEncoder.dispatchThreads(threadsPerGrid, threadsPerThreadgroup: threadsPerThreadGroup)
        
        computeEncoder.endEncoding()
    }
    
    
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable else { return }
        
        modelConstants.modelMatrix.rotate(angle: 0.0005, axis: Z_AXIS)
        
        let commandbuffer = commandQueue.makeCommandBuffer()
        let computeEncoder = commandbuffer?.makeComputeCommandEncoder()
        doComputePass(computeEncoder: computeEncoder!, drawable: drawable)
        
        commandbuffer?.present(drawable)
        commandbuffer?.commit()

    }
    
    @IBAction func sldParticleCountUpdate(_ sender: NSSlider) {
        txtParticleCount.stringValue = String(Int(sender.floatValue))
    }
    
    @IBAction func btnUpdate(_ sender: NSButton) {
        particleCount = Int(txtParticleCount.stringValue)!
        sldParticleCount.floatValue = Float(txtParticleCount.stringValue)!
        createParticles()
    }
    
}


