#ifndef CPP_SRC_PLAYER_HPP_
#define CPP_SRC_PLAYER_HPP_

#include <string>

class Player {
public:
  Player();
  void SetName(const std::string &name);
  std::string GetName() const;
  void AddPoints(const int points);
  int GetScore() const;

private:
  std::string name_;
  int score_;
};

#endif // CPP_SRC_PLAYER_HPP_