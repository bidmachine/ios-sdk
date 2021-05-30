import Foundation

public
class File {
    
}

public
extension File {
    
    static
    func path(with components: String...) -> String {
        return components.joined(separator: "/").replacingOccurrences(of: "//", with: "/")
    }
    
    @discardableResult static
    func exist(_ absolutePath: String) -> Bool {
        guard FileManager.default.fileExists(atPath: absolutePath) else {
            return false
        }
        return true
    }
    
    @discardableResult static
    func copy(_ fromAbsolutePath: String, _ toAbsolutePath: String) -> Bool {
        Log.println("- Try copy file \n-- From: \(fromAbsolutePath) \n-- To: \(toAbsolutePath)", .verbose)
        guard self.exist(fromAbsolutePath) else {
            Log.println("Non existent copying file at path: \(fromAbsolutePath)", .failure)
            return false
        }
        
        guard
            let result = URL(string: toAbsolutePath)
                .flatMap({ $0.deletingLastPathComponent()})
                .flatMap ({ $0.absoluteString })
                .flatMap({ self.create($0) }),
            result == true
        else {
            Log.println("Root file not exist for direct path: \(toAbsolutePath)", .failure)
            return false
        }
        
        guard !self.exist(toAbsolutePath) else {
            Log.println("Copy target allready contain same file at path: \(toAbsolutePath)", .failure)
            return false
        }
        
        do {
            try FileManager.default.copyItem(atPath: fromAbsolutePath, toPath: toAbsolutePath)
            Log.println("-- Complete copy files", .verbose)
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult static
    func create(_ absolutePath: String) -> Bool {
        Log.println("- Try create direcrory at path: \(absolutePath)", .verbose)
        guard !self.exist(absolutePath) else {
            Log.println("  -- Directory at this path allready exist", .verbose)
            return true
        }
        
        do {
            try FileManager.default.createDirectory(atPath: absolutePath, withIntermediateDirectories: true)
            Log.println("  -- Complete create directory", .verbose)
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult static
    func remove(_ absolutePath: String) -> Bool {
        Log.println("- Try remove file at path: \(absolutePath)", .verbose)
        guard self.exist(absolutePath) else {
            Log.println("  -- File at this path allready not exist", .verbose)
            return true
        }
        
        do {
            try FileManager.default.removeItem(atPath: absolutePath)
            Log.println("  -- Complete remove file", .verbose)
            return true
        } catch {
            return false
        }
    }
}