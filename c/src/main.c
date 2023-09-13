#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Player {
  char name[16];
  int score;
};

void flush_input() {
  int c;
  while ((c = getchar()) != '\n' && c != EOF) {
  }
}

int get_int(char *prompt) {
  int n = 0;
  printf("%s\n", prompt);
  scanf("%d", &n);
  flush_input();
  return n;
}

int get_non_zero_int(char *prompt) {
  int n = 0;
  while (n == 0) {
    n = get_int(prompt);
  }
  return n;
}

void get_non_empty_string(char *prompt, char *out) {
  char s[16] = "";
  while (strlen(s) == 0) {
    printf("%s\n", prompt);
    scanf("%s", s);
    flush_input();
  }
  strcpy(out, s);
}

int compare_players(const void *a, const void *b) {
  const struct Player *player_a = (const struct Player *)a;
  const struct Player *player_b = (const struct Player *)b;
  return player_b->score - player_a->score;
}

int main() {
  printf(":::: DOOMLINGS SCORE CALCULATOR ::::\n");
  printf("\n");
  int player_count = get_non_zero_int("How many people are playing?");

  struct Player players[player_count];

  printf("\n");
  for (int i = 0; i < player_count; i++) {
    char prompt[51];
    sprintf(prompt, "What is player %d's name?", i + 1);
    get_non_empty_string(prompt, players[i].name);
    players[i].score = 0;
  }

  printf("\n");
  for (int i = 0; i < player_count; i++) {
    char prompt[51];
    sprintf(prompt, "%s, what are your World's End points?", players[i].name);
    players[i].score += get_int(prompt);
  }

  printf("\n");
  for (int i = 0; i < player_count; i++) {
    char prompt[51];
    sprintf(prompt, "%s, what are your Face Value points?", players[i].name);
    players[i].score += get_int(prompt);
  }

  printf("\n");
  for (int i = 0; i < player_count; i++) {
    char prompt[51];
    sprintf(prompt, "%s, what are your Bonus points?", players[i].name);
    players[i].score += get_int(prompt);
  }

  qsort(players, player_count, sizeof(struct Player), compare_players);

  printf("\n");
  printf("\n");
  printf("%-2s%-16s%-5s\n", "#", "PLAYER", "SCORE");
  printf("\n");
  for (int i = 0; i < player_count; i++) {
    char rank_str[2];
    sprintf(rank_str, "%d", i + 1);
    char score_str[5];
    sprintf(score_str, "%d", players[i].score);
    printf("%-2s%-16s%5s\n", rank_str, players[i].name, score_str);
  }
  printf("\n");

  return 0;
}