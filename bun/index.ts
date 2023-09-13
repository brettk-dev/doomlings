type Player = {
  name: string;
  score: number;
};

const reader = Bun.stdin.stream().getReader();

const getLine = async (prompt: string): Promise<string> => {
  console.log(prompt);
  const input = await reader.read();
  if (input.value == null) return '';
  return Buffer.from(input.value).toString().trim();
};

const getInt = async (prompt: string): Promise<number> => {
  try {
    return parseInt(await getLine(prompt), 10);
  } catch (_error) {
    return getInt(prompt);
  }
};

const getNonZeroInt = async (prompt: string): Promise<number> => {
  let n = 0;
  while (n <= 0 || Number.isNaN(n)) {
    n = await getInt(prompt);
  }
  return n;
};

const getScore = async (scoreType: string, player: Player): Promise<number> => {
  return await getInt(`What is ${player.name}'s ${scoreType} points?`);
};

console.log('');
console.log(':::: DOOMLINGS SCORE CALCULATOR ::::');

console.log('');
const playerCount = await getNonZeroInt('How many people are playing?');
const players: Player[] = Array(playerCount)
  .fill(null)
  .map(() => ({ name: '', score: 0 }));

console.log('');
for (const i in players) {
  const playerNumber = Number(i) + 1;
  players[i].name =
    (await getLine(`What is player ${playerNumber}'s name?`)) ||
    `Player ${playerNumber}`;
}

console.log('');
for (const i in players) {
  players[i].score += await getScore("World's End", players[i]);
}

console.log('');
for (const i in players) {
  players[i].score += await getScore('Face Value', players[i]);
}

console.log('');
for (const i in players) {
  players[i].score += await getScore('Bonus', players[i]);
}

players.sort((a, b) => b.score - a.score);

console.log('');
console.log('');
console.log(`# ${'PLAYER'.padEnd(16)}SCORE`);
console.log('');
players.forEach((p, i) => {
  const rankStr = (i + 1).toString();
  const scoreStr = p.score.toString();
  console.log(
    `${rankStr.padEnd(2)}${p.name.padEnd(16)}${scoreStr.padStart(5)}`
  );
});
console.log('');
