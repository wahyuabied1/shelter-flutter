//example
const String promotion = 'promotion';
const String enableListFeature = 'enable_list_feature';

//always add default value, in case error fetch data
final defaults = <String, dynamic>{
  promotion: '[]',
  enableListFeature: '''
    {
      {
        "hadirqu": true,
        "cleaningqu": false,
        "issuequ": false,
        "guard": false
      }
    }
  '''
};
