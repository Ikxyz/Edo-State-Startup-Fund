 

class StartupClass {
    String name, teamLeader, stage, status, desc,category,hash,body;
    List<dynamic> image;

    double fundRaised, softCap, hardCap;
    int temperature;
    List<dynamic> ideas;
    List<dynamic> teamMembers;

  StartupClass(
      {this.teamLeader,
      this.stage,this.category,
      this.status,
      this.fundRaised,
      this.softCap,
      this.hardCap,
      this.teamMembers,
      this.name,
      this.image,
      this.desc,
      this.hash,
      this.body,
      this.temperature,
      this.ideas});

  factory StartupClass.fromJson(Map<String, dynamic> map) {
    return StartupClass(
        ideas: map['ideas'],
        desc: map['desc'],
        body: map['body'],
        image: map['image'],
        stage: map['stage'],
        status: map['status'],
        teamLeader: map['teamLeader'],
        teamMembers: map['teamMembers'],
        name: map['name'],
        fundRaised: map['fundRaised'],
        softCap: map['softCap'],
        hardCap: map['hardCap'],
        hash: map['hash'],
        category:map['category'],
        temperature: map['temperature']);
  }

  static Map<String, dynamic> toJson(StartupClass e) {
    return {
      'teamLeader': e.teamLeader,
      'stage': e.stage,
      'status': e.status,
      'teamMembers': e.teamLeader,
      'name': e.name,
      'image': e.image,
      'desc': e.desc,
      'body': e.body,
      'fundRaised': e.fundRaised,
      'temperature': e.temperature,
      'ideas': e.ideas,
      'category': e.category
    };
  }
}
