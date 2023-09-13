int GetNumber(string prompt)
{
  var value = 0;

  Console.WriteLine(prompt);

  while (true)
  {
    try
    {
      value = Convert.ToInt32(Console.ReadLine());
      break;
    }
    catch (Exception)
    {
      Console.WriteLine("I had trouble converting that to a number. Try again.");
      Console.WriteLine(prompt);
    }
  }

  return value;
}

Console.WriteLine("");
Console.WriteLine(":::: DOOMLINGS SCORE CALCULATOR ::::");
Console.WriteLine("");
var playerCount = GetNumber("How many players?");

(string name, int score)[] players = new (string, int)[playerCount];

Console.WriteLine("");
for (int i = 0; i < playerCount; i++)
{
  Console.WriteLine($"What is player {i + 1}'s name?");
  players[i] = (Console.ReadLine() ?? $"Player {i + 1}", 0);
}

Console.WriteLine("");
for (int i = 0; i < playerCount; i++)
{
  players[i].score += GetNumber($"[{players[i].name}] Enter your World's End Points: ");
}

Console.WriteLine("");
for (int i = 0; i < playerCount; i++)
{
  players[i].score += GetNumber($"[{players[i].name}] Enter your Face Value Points: ");
}

Console.WriteLine("");
for (int i = 0; i < playerCount; i++)
{
  players[i].score += GetNumber($"[{players[i].name}] Enter your Bonus Points: ");
}

Array.Sort(players, (a, b) => b.score.CompareTo(a.score));

Console.WriteLine("");
Console.WriteLine("");
Console.WriteLine("PLAYER".PadRight(16) + "SCORE".PadLeft(5));
Console.WriteLine("");
foreach (var player in players)
{
  Console.WriteLine(player.name.PadRight(16) + player.score.ToString().PadLeft(5));
}