#ifndef DOOMLINGS_CALCULATOR_HPP_
#define DOOMLINGS_CALCULATOR_HPP_

#include "player.hpp"

const int SCORE_TYPES_LENGTH = 3;

class DoomlingsCalculator {
public:
  DoomlingsCalculator();
  void Start();

private:
  const std::string SCORE_TYPES[SCORE_TYPES_LENGTH] = {"World's End",
                                                       "Face Value", "Bonus"};
  int player_count_;
  Player *players_;
  int GetInt();
  std::string GetPlayerName(int playerIndex);
  int GetPlayerScore(std::string score_type, int playerIndex);
  void DisplayResults();
};

#endif