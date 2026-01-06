import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // TODO: Replace with your actual Supabase URL and Anon Key
  static const String supabaseUrl = 'https://zgbnzytosbinokaqjork.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpnYm56eXRvc2Jpbm9rYXFqb3JrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY0OTk2ODYsImV4cCI6MjA4MjA3NTY4Nn0.zu8WgkKdfGIvdT0y4L3dgUZnhor3YUiCY6l1tF4daD8';

  static final SupabaseClient client = Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
}
