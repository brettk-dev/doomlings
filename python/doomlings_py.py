class Player:
    def __init__(self):
        self.name = ""
        self.score = 0

    def input_name(self, n: int):
        print(f"What is player {n}'s name?")
        name = input()
        if name.__len__() == 0:
            return f"Player {n}"
        self.name = name

    def input_score(self, type: str):
        print(f"What is {self.name}'s {type} score?")
        score = None
        while score == None:
            try:
                score = int(input())
            except Exception:
                score = None
        self.score += score


def get_player_count():
    print("How many people are playing?")
    player_count = 0
    while player_count <= 0:
        try:
            player_count = int(input())
        except Exception:
            player_count = 0
    return player_count


def main():
    print("")
    print(":::: DOOMLINGS SCORE CALCULATOR ::::")
    print("")
    player_count = get_player_count()
    players = list(map(lambda i: Player(), range(player_count)))
    print("")
    for index, player in enumerate(players):
        player.input_name(index + 1)
    print("")
    for player in players:
        player.input_score("World's End")
    print("")
    for player in players:
        player.input_score("Face Value")
    print("")
    for player in players:
        player.input_score("Bonus")
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
