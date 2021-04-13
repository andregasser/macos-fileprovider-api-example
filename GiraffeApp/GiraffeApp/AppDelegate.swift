//
//  AppDelegate.swift
//  GiraffeApp
//
//  Created by André Gasser on 12.04.21.
//

import Cocoa
import FileProvider
import os.log

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        os_log(.info, "GiraffeApp starting")
  
        // List registered domains
        NSFileProviderManager.getDomainsWithCompletionHandler() { domains, error in
            if (error != nil) {
                os_log(.error, "%{public}@", error!.localizedDescription)
            } else {
                for domain in domains {
                    os_log(.info, "Registered domain: %{public}@", domain.identifier.rawValue)
                }
            }
        }
        
        // Remove all domains
        NSFileProviderManager.removeAllDomains { (error) in
            if (error != nil) {
                os_log(.error, "Unable to remove all domains")
            } else {
                os_log(.info, "Successfully removed all domains")
            }
        }
        
        // Register domain
        let domainIdentifier = "GiraffeDomain"
        let domainDisplayName = "Giraffe Photos"
        let domain = NSFileProviderDomain(identifier: NSFileProviderDomainIdentifier(domainIdentifier), displayName: domainDisplayName)
        NSFileProviderManager.add(domain) { error in
            if (error != nil) {
                os_log(.error, "Unable to add file provider domain: %{public}@", error!.localizedDescription)
            } else {
                os_log(.info, "Successfully added file provider domain: %{public}@", domainIdentifier)
            }
        }
        
        let manager = NSFileProviderManager(for: domain)
        manager?.signalEnumerator(for: .rootContainer) { error in
            if (error != nil) {
                os_log(.error, "signalEnumerator failed: %{public}@", error!.localizedDescription)
            } else {
                os_log(.info, "signalEnumerator succeeded")
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

