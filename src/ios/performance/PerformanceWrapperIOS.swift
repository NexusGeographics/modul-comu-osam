import Foundation
import OSAMCommon

class PerformanceWrapperIOS: PerformanceWrapper {
    func createMetric(url: String, httpMethod: String) -> PerformanceMetric? {
        do {
            print("PerformanceWrapperIOS createMetric start")
        } catch {
            print("PerformanceWrapperIOS Unknown error: \(error)")
        }
        
        return nil
    }
}
