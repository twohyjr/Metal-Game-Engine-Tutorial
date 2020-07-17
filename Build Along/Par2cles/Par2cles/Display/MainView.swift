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
    
    @IBOutlet weak var txtDotCount: NSTextField!
    @IBOutlet weak var sldDotCount: NSSlider!
    
    var commandQueue: MTLCommandQueue!
    var clearPass: MTLComputePipelineState!
    var drawDotPass: MTLComputePipelineState!
    
    var particleBuffer: MTLBuffer!
    
    var screenSize: Float {
        return Float(self.bounds.width * 2)
    }
    
    var particleCount: Int = 1000
    
    override func viewDidMoveToWindow() {
        txtDotCount.stringValue = String(particleCount)
        sldDotCount.floatValue = Float(particleCount)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.framebufferOnly = false
        
        self.device = MTLCreateSystemDefaultDevice()
        
        self.commandQueue = device?.makeCommandQueue()
        
        let library = device?.makeDefaultLibrary()
        let clearFunc = library?.makeFunction(name: "clear_pass_func")
        let drawDotFunc = library?.makeFunction(name: "draw_dots_func")
        
        do{
            clearPass = try device?.makeComputePipelineState(function: clearFunc!)
            drawDotPass = try device?.makeComputePipelineState(function: drawDotFunc!)
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
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable else { return }
        
        let commandbuffer = commandQueue.makeCommandBuffer()
        let computeCommandEncoder = commandbuffer?.makeComputeCommandEncoder()
        
        computeCommandEncoder?.setComputePipelineState(clearPass)
        computeCommandEncoder?.setTexture(drawable.texture, index: 0)

        let w = clearPass.threadExecutionWidth
        let h = clearPass.maxTotalThreadsPerThreadgroup / w
        
        var threadsPerThreadGroup = MTLSize(width: w, height: h, depth: 1)
        var threadsPerGrid = MTLSize(width: drawable.texture.width, height: drawable.texture.height, depth: 1)
        computeCommandEncoder?.dispatchThreads(threadsPerGrid, threadsPerThreadgroup: threadsPerThreadGroup)

        computeCommandEncoder?.setComputePipelineState(drawDotPass)
        computeCommandEncoder?.setBuffer(particleBuffer, offset: 0, index: 0)
        threadsPerGrid = MTLSize(width: particleCount, height: 1, depth: 1)
        threadsPerThreadGroup = MTLSize(width: w, height: 1, depth: 1)
        computeCommandEncoder?.dispatchThreads(threadsPerGrid, threadsPerThreadgroup: threadsPerThreadGroup)

        computeCommandEncoder?.endEncoding()
        commandbuffer?.present(drawable)
        commandbuffer?.commit()
    }
    
    @IBAction func sldParticleCountUpdate(_ sender: NSSlider) {
        txtDotCount.stringValue = String(Int(sender.floatValue))
    }
    
    @IBAction func btnUpdate(_ sender: NSButton) {
        particleCount = Int(txtDotCount.stringValue)!
        sldDotCount.floatValue = Float(txtDotCount.stringValue)!
        createParticles()
    }
    
}


