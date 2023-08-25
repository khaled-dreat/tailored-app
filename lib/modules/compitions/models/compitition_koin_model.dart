class CompetitionJoinModel {
    String id;
    String competitionId;
    String state;
    List<User> users;

    CompetitionJoinModel({
        required this.id,
        required this.competitionId,
        required this.state,
        required this.users,
    });

}

class User {
    int id;
    String firstName;
    String lastName;
    dynamic avatar;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        this.avatar,
    });

}
