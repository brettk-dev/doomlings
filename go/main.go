package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

type Player struct {
	Name  string
	Score int
}

func getInt(prompt string) int {
	var n int
	fmt.Println(prompt)
	reader := bufio.NewReader(os.Stdin)
	for {
		line, err := reader.ReadString('\n')
		if err == nil {
			n, err = strconv.Atoi(strings.TrimSpace(line))
			if err == nil {
				break
			}
		}
	}
	return n
}

func getNonZeroInt(prompt string) int {
	count := 0
	for {
		count = getInt(prompt)
		if count > 0 {
			break
		}
	}
	return count
}

func getPlayerName(playerNumber int) string {
	var name string
	reader := bufio.NewReader(os.Stdin)
	for {
		fmt.Printf("What is player %d's name?\n", playerNumber)
		line, err := reader.ReadString('\n')
		if err == nil {
			name = strings.TrimSpace(line)
			break
		}
	}
	if len(name) == 0 {
		return fmt.Sprintf("Player %d", playerNumber)
	}
	return name
}

func getPlayerScore(scoreType string, player Player) int {
	score := getInt(fmt.Sprintf("What is %s's %s score?", player.Name, scoreType))
	return score
}

func main() {
	fmt.Println("")
	fmt.Printf(":::: DOOMLINGS SCORE CALCULATOR ::::\n")

	fmt.Println("")
	playerCount := getNonZeroInt("How many people are playing?")

	fmt.Println("")
	players := make([]Player, playerCount)
	for i := range players {
		players[i].Name = getPlayerName(i + 1)
		players[i].Score = 0
	}

	fmt.Println("")
	for i, p := range players {
		players[i].Score += getPlayerScore("World's End", p)
	}
	fmt.Println("")
	for i, p := range players {
		players[i].Score += getPlayerScore("Face Value", p)
	}
	fmt.Println("")
	for i, p := range players {
		players[i].Score += getPlayerScore("Bonus", p)
	}

	sort.Slice(players, func(i, j int) bool {
		return players[i].Score > players[j].Score
	})

	fmt.Println("")
	fmt.Println("")
	fmt.Printf("%-2s%-16s%-5s\n", "#", "PLAYER", "SCORE")
	fmt.Println("")
	for i, p := range players {
		fmt.Printf("%-2d%-16s%5d\n", i+1, p.Name, p.Score)
	}
	fmt.Println("")
}
