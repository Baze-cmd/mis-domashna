
class Match
{
    String team1;
    String team2;
    int team1Score;
    int team2Score;
    Match({
        required this.team1,
        required this.team2,
        required this.team1Score,
        required this.team2Score
    });

    String getWinner()
    {
        if (this.team1Score > this.team2Score)
        {
            return this.team1;
        }
        else if (this.team2Score > this.team1Score)
        {
            return this.team2;
        }
        return "TBD";
    }

    String getLoser()
    {
        if (this.team1Score < this.team2Score)
        {
            return this.team1;
        }
        else if (this.team2Score < this.team1Score)
        {
            return this.team2;
        }
        return "TBD";
    }
}
