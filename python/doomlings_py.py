class Player:
    def __init__(self):
        self.name = ""
        self.score = 0


def get_player_count():
    print("How many people are playing?")
    player_count = 0
    while player_count <= 0:
        try:
            player_count = int(input())
        except Exception:
            player_count = 0
    return player_count


def get_player_name(n: int):
    print(f"What is player {n}'s name?")
    player_name = input()
    if player_name.__len__() == 0:
        return f"Player {n}"
    return player_name


def get_player_score(player: Player, score_type: str):
    print(f"What is {player.name}'s {score_type} score?")
    player_score = None
    while player_score == None:
        try:
            player_score = int(input())
        except Exception:
            player_score = None
    return player_score


def main():
    print("")
    print(":::: DOOMLINGS SCORE CALCULATOR ::::")
    print("")
    player_count = get_player_count()
    players = list(map(lambda i: Player(), range(player_count)))
    print("")
    for index, player in enumerate(players):
        player.name = get_player_name(index + 1)
    print("")
    for player in players:
        player.score += get_player_score(player, "World's End")
    print("")
    for player in players:
        player.score += get_player_score(player, "Face Value")
    print("")
    for player in players:
        player.score += get_player_score(player, "Bonus")
    players.sort(key=lambda p: p.score, reverse=True)
    print("")
    print("")
    print("{0:<2}{1:<16}{2:>5}".format("#", "PLAYER", "SCORE"))
    # print("# " + "PLAYER".ljust(16) + "SCORE")
    print("")
    for index, player in enumerate(players):
        print("{0:<2}{1:<16}{2:>5}".format(index + 1, player.name, player.score))
    print("")


if __name__ == "__main__":
    main()
