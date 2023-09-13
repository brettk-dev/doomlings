#include "player.hpp"

Player::Player() {
  name_ = "";
  score_ = 0;
}

void Player::SetName(const std::string &name) { name_ = name; }

std::string Player::GetName() const { return name_; }

void Player::AddPoints(const int points) { score_ += points; }

int Player::GetScore() const { return score_; }