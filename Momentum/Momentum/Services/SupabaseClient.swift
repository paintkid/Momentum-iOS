import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        let supabaseURL = URL(string: "https://wxynvqlvsnfnjnexmudq.supabase.co")!
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind4eW52cWx2c25mbmpuZXhtdWRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA3OTE5NjEsImV4cCI6MjA2NjM2Nzk2MX0.DMeeZ32rsEyLhY9XNQG2mwnrdzKMDoFEC2o7A8TuO2g"

        self.client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    }
}
