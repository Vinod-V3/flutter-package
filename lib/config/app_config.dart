// class AppConfig {
//   static final AppConfig instance = AppConfig._internal();
//   AppConfig._internal();

//   late final String baseUrl;
//   late final Map<String, dynamic> profileData;
//   late final int maxFileSize;
//   late final Map<String, dynamic> projectData;

//   bool _initialized = false;

//   void initialize(Map<String, dynamic> config) {
//     if (_initialized) return;
//     baseUrl = config['baseUrl'] ?? '';
//     profileData = Map<String, dynamic>.from(config['profileData'] ?? {});
//     maxFileSize = config['maxFileSize'] ?? 0;
//     projectData = Map<String, dynamic>.from(config['projectData'] ?? {});
//     _initialized = true;
//   }
// }

class AppConfig {
  static final AppConfig instance = AppConfig._internal();
  AppConfig._internal();

  Map<String, dynamic> _config = {};
  bool _initialized = false;

  void initialize(Map<String, dynamic> config) {
    if (_initialized) return;
    _config = Map<String, dynamic>.from(config);
    _initialized = true;
  }

  dynamic get(String key) => _config[key];
  Map<String, dynamic> get all => _config;

  void update(String key, dynamic value) {
    _config[key] = value;
  }

  void merge(Map<String, dynamic> newConfig) {
    _config.addAll(newConfig);
  }
}
