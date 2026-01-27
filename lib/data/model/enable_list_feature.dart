class EnableListFeature {
  bool hadirqu;
  bool cleaningqu;
  bool issuequ;
  bool guard;

  EnableListFeature({
    required this.hadirqu,
    required this.cleaningqu,
    required this.issuequ,
    required this.guard,
  });

  // Factory method to create a Promotion object from JSON
  factory EnableListFeature.fromJson(Map<String, dynamic> json) {
    return EnableListFeature(
      hadirqu: json['hadirqu'],
      cleaningqu: json['cleaningqu'],
      issuequ: json['issuequ'],
      guard: json['guard'],
    );
  }

  // Convert a Promotion object to JSON
  Map<String, dynamic> toJson() {
    return {
      'hadirqu': hadirqu,
      'cleaningqu': cleaningqu,
      'issuequ': issuequ,
      'guard': guard,
    };
  }

}
