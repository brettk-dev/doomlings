#include "doomlings_calculator.hpp"

#include "player.hpp"
#include <algorithm>
#include <iomanip>
#include <iostream>

DoomlingsCalculator::DoomlingsCalculator() {
  player_count_ = 0;
  players_ = nullptr;
}

void DoomlingsCalculator::Start() {
  std::cout << std::endl;
  std::cout << ":::: DOOMLINGS SCORE CALCULATOR ::::" << std::endl;
  std::cout << std::endl;
  std::cout << "How many players are there? " << std::endl;
  player_count_ = GetInt();

  players_ = new Player[player_count_];

  std::cout << std::endl;
  for (int i = 0; i < player_count_; i++) {
    std::cout << "What is the name of player " << i + 1 << "?" << std::endl;
    players_[i].SetName(GetPlayerName(i));
  }

  for (int i = 0; i < SCORE_TYPES_LENGTH; i++) {
    std::cout << std::endl;
    for (int j = 0; j < player_count_; j++) {
      std::cout << "How many points did player " << players_[j].GetName()
                << " get for " << SCORE_TYPES[i] << "? " << std::endl;
      players_[j].AddPoints(GetPlayerScore(SCORE_TYPES[i], j));
    }
  }

  std::sort(players_, players_ + player_count_,
            [](Player &a, Player &b) { return a.GetScore() > b.GetScore(); });

  DisplayResults();
}

int DoomlingsCalculator::GetInt() {
  std::string input;
  try {
    std::cin >> input;
    return std::stoi(input);
  } catch (...) {
    std::cout << "Invalid input. Please try again." << std::endl;
    return GetInt();
  }
}

std::string DoomlingsCalculator::GetPlayerName(int playerIndex) {
  try {
    std::string name;
    std::cin >> name;
    if (name.compare("") == 0) {
      throw std::exception();
    }
    return name;
  } catch (...) {
    return "Player " + std::to_string(playerIndex);
  }
}

int DoomlingsCalculator::GetPlayerScore(std::string score_type,
                                        int playerIndex) {
  int n = 0;
  while (n == 0) {
    try {
      std::cin >> n;
    } catch (...) {
      std::cout << "Invalid input. Please try again." << std::endl;
    }
  }
  return n;
}

void DoomlingsCalculator::DisplayResults() {
  std::cout << std::endl << std::endl;
  std::cout << std::setw(2) << std::left << "#" << std::setw(16) << "PLAYER"
            << "SCORE";
  std::cout << std::endl;
  for (int i = 0; i < player_count_; i++) {
    std::cout << std::setw(2) << std::left << i + 1 << std::setw(16)
              << players_[i].GetName() << std::setw(5) << std::right
              << players_[i].GetScore();
    std::cout << std::endl;
  }
  std::cout << std::endl;
}