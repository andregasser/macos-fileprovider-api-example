//
//  FileProviderItem.swift
//  GiraffeFileProvider
//
//  Created by André Gasser on 12.04.21.
//

import FileProvider
import UniformTypeIdentifiers

class FileProviderItem: NSObject, NSFileProviderItem {

    // TODO: implement an initializer to create an item from your extension's backing model
    // TODO: implement the accessors to return the values from your extension's backing model
    
    private let identifier: NSFileProviderItemIdentifier
    
    init(identifier: NSFileProviderItemIdentifier) {
        self.identifier = identifier
    }
    
    // Required
    var itemIdentifier: NSFileProviderItemIdentifier {
        return identifier
    }
    
    // Required
    var parentItemIdentifier: NSFileProviderItemIdentifier {
        return .rootContainer
    }
    
    var capabilities: NSFileProviderItemCapabilities {
        return .allowsAll
    }
    
    var itemVersion: NSFileProviderItemVersion {
        NSFileProviderItemVersion(contentVersion: "a content version".data(using: .utf8)!, metadataVersion: "a metadata version".data(using: .utf8)!)
    }
    
    // Required
    var filename: String {
        return identifier.rawValue
    }
    
    var contentType: UTType {
        return identifier == NSFileProviderItemIdentifier.rootContainer ? .folder : .plainText
    }
}
