//
//  HTTPBuilder.swift
//  Alamofire
//
//  Created by 孙江挺 on 2018/6/6.
//

import Foundation
import Alamofire

public class HTTPBuilder: NSObject {
    
    /// 外部可以从 Builder 访问到 Session，然后重置 Session， 弱引用
    public internal(set) weak var session: Requests.Session?
    
    internal var querySorter: ((String, String)->Bool)?
    
    #if DEBUG
    deinit {
        if printVerbose {
            print("HTTPBuilder Dealloc \(urlString)")
        }
    }
    #endif
    
    required init(url: String, session: Requests.Session) {
        urlString = url
        self.session = session
        super.init()
    }
    
    public override init() {
        fatalError()
    }
    
    @discardableResult
    public func method(_ method: Alamofire.HTTPMethod) -> Self {
        httpMethod = method
        return self
    }
    
    @discardableResult
    public func mark(_ mark: [String: Any]?) -> Self {
        requestExtra = mark
        return self
    }
    
    @discardableResult
    public func appendCommonParameters(_ append: Bool) -> Self {
        vappendCommonParameters = append
        return self
    }
    
    @discardableResult
    public func query(_ parameters: [String : Any]?) -> Self {
        queryParameters = parameters
        return self
    }
    
    @discardableResult
    public func post(_ parameters: [String : Any]?) -> Self {
        postParameters = parameters
        if let p = parameters , !p.isEmpty {
            let _ = method(.post)
        }
        return self
    }
    
    @discardableResult
    public func content(_ parameters: [String : Any]?) -> Self {
        postParameters = parameters
        return self
    }
    
    @discardableResult
    public func headers(_ headers: [String : String]?) -> Self {
        vheaders = headers
        return self
    }
    
    @discardableResult
    public func gzipEnabled(_ enabled: Bool) -> Self {
        vgzipEnabled = enabled
        return self
    }
    
    @discardableResult
    public func retry(_ retryTimes: UInt16) -> Self {
        self.retryTimes = retryTimes
        return self
    }
    
    @discardableResult
    public func timeout(_ timeout: TimeInterval) -> Self {
        timeoutInterval = timeout
        return self
    }
    
    @discardableResult
    public func cachePolicy(_ policy: NSURLRequest.CachePolicy) -> Self {
        vcachePolicy = policy
        return self
    }
    
    @discardableResult
    public func priority(_ priority: Session.Priority) -> Self {
        vpriority = priority
        return self
    }
    
    @discardableResult
    public func encoding(_ encoding: ParameterEncoding) -> Self {
        parameterEncoding = encoding
        return self
    }
    
    @discardableResult
    public func downloadProgress(on queue: DispatchQueue = DispatchQueue.main, callback:((Progress)->Void)?) -> Self {
        downloadProgressQueue = queue
        downloadProgressCallback = callback
        return self
    }
  
    func append(_ parameters: [String : Any]?, to absoluteString: String) -> String {
        guard let parameters = parameters , !parameters.isEmpty else {
            return absoluteString
        }
        var results = absoluteString
        var components: [(String, String)] = []
        let sorter: (String, String) -> Bool = querySorter ?? { (lhs: String, rhs: String) -> Bool in
            return lhs < rhs
        }
        for key in Array(parameters.keys).sorted(by: sorter) {
            let value = parameters[key]!
            components += Alamofire.URLEncoding.queryString.queryComponents(fromKey: key, value: value)
        }
        let query = (components.map { "\($0)=\($1)" } as [String]).joined(separator: "&")
        if !query.isEmpty {
            if absoluteString.contains("?") {
                results.append("&")
            } else {
                results.append("?")
            }
            results.append(query)
        }
        return results
    }
    
    public func build() -> Request? {
        return nil
    }
    
    var urlString: String
    var vheaders: [String : String]?
    var queryParameters: [String : Any]?
    var parameterEncoding: ParameterEncoding = .url
    var vappendCommonParameters = true
    var retryTimes: UInt16 = 0
    var timeoutInterval: TimeInterval = Session.client?.timeoutInterval ?? 15
    var vcachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
    var vpriority = Session.Priority.default
    
    var downloadProgressQueue: DispatchQueue?
    var downloadProgressCallback: ((Progress)->Void)?
    
    var vgzipEnabled = Session.client?.isGZipEnabled ?? false
    /// 发送请求的时间（unix时间戳）
    var requestTimestamp: TimeInterval = 0
    
    var httpMethod: AFMethod = .get
    var postParameters: [String : Any]?
    
    var requestExtra: [String : Any]?
}
