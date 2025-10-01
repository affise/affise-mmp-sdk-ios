import Foundation
import UIKit 


internal class AffiseModuleManager {

    private let bundle: Bundle
    private let logsManager: LogsManager
    private let postBackModelFactory: PostBackModelFactory
    private let initProperties: AffiseInitProperties

    private var modules: [AffiseModules:AffiseModule] = [:]
    private lazy var disabledModules: [AffiseModules] = {
        initProperties.disableModules
    }()

    init(
        bundle: Bundle,
        logsManager: LogsManager,
        postBackModelFactory: PostBackModelFactory,
        initProperties: AffiseInitProperties
    ) {
        self.bundle = bundle
        self.logsManager = logsManager
        self.postBackModelFactory = postBackModelFactory
        self.initProperties = initProperties
    }

    func initialize(
        app: UIApplication,
        dependencies: [Any]
    ) {
        initAffiseModules { module in
            module.dependencies(
                app: app,
                logsManager: logsManager,
                dependencies: dependencies,
                providers: postBackModelFactory.getProviders()
            )
            
            moduleStart(module)
        }
    }

    func getModulesNames() -> [AffiseModules] {
        return Array(modules.keys)
    }

    func status(_ moduleName: AffiseModules, _ onComplete: @escaping OnKeyValueCallback) {
        getModule(moduleName)?.status(onComplete) ?? onComplete([AffiseKeyValue(moduleName.className(), "not found")])
    }
    
    private func moduleStart(_ module: AffiseModule) {
        module.start()
        postBackModelFactory.addProviders(module.providers())
    }

    func updateProviders(_ moduleName: AffiseModules) {
        if let providers = getModule(moduleName)?.providers() {
            postBackModelFactory.addProviders(providers)
        }
    }
    
    private func classType(_ moduleName: AffiseModules) -> AffiseModule.Type? {
        let aClass: AnyClass? = NSClassFromString(moduleName.className()) ?? NSClassFromString(moduleName.classNameModule())
        guard let aClass = aClass else { return nil }  
        guard let cls = aClass as? AffiseModule.Type else { return nil }
        return cls
    }
    
    func getModule(_ moduleName: AffiseModules) -> AffiseModule? {
        modules[moduleName]
    }
    
    func hasModule(_ moduleName: AffiseModules) -> Bool {
        return getModule(moduleName) != nil
    }
    
    private func initAffiseModules(_ callback: (_ module: AffiseModule) -> Void) {
        for moduleName in AffiseModules.values() {
            if disabledModules.contains(moduleName) { continue }

            guard let cls = classType(moduleName) else { continue }
            let module = cls.init()
            if module.version == BuildConfig.AFFISE_VERSION {
                modules[moduleName] = module
                callback(module)
            } else {
                print(AffiseModuleError.version(name: moduleName, module: module).localizedDescription)
            }
        }
    }

    func api(_ moduleName: AffiseModules) -> AffiseModuleApi? {
        return getModule(moduleName) as? AffiseModuleApi
    }
}
