import Control.Monad (zipWithM_)
import Data.List (sortBy)
import Text.Printf (printf)
import Text.Read (readMaybe)

type Player = (String, Int)

getInt :: String -> IO Int
getInt prompt = do
  putStrLn prompt
  input <- getLine
  case readMaybe input of
    Just n -> return n
    Nothing -> getInt prompt

getNonZeroInt :: String -> IO Int
getNonZeroInt prompt = do
  n <- getInt prompt
  case n of
    0 -> getNonZeroInt prompt
    _ -> return n

getPlayerName :: Int -> IO String
getPlayerName playerNumber = do
  putStrLn $ "What is player " ++ show playerNumber ++ "'s name?"
  name <- getLine
  case name of
    "" -> return $ "Player " ++ show playerNumber
    _ -> return name

getPlayers :: Int -> IO [Player]
getPlayers count = do
  names <- mapM getPlayerName [1 .. count]
  return (map (\n -> (n, 0)) names)

getPlayerScore :: String -> Player -> IO Player
getPlayerScore scoreType player = do
  score <- getInt $ "What is " ++ fst player ++ "'s " ++ scoreType ++ " score?"
  return (fst player, snd player + score)

getScores :: String -> [Player] -> IO [Player]
getScores scoreType players = do
  mapM (getPlayerScore scoreType) players

comparePlayers :: Player -> Player -> Ordering
comparePlayers (_, scoreA) (_, scoreB) = do
  compare scoreB scoreA

printPlayerScores :: Int -> Player -> IO ()
printPlayerScores rank (name, score) = do
  printf "%-2d%-16s%5d\n" rank name score

main :: IO ()
main = do
  putStrLn ""
  putStrLn ":::: DOOMLINGS SCORE CALCULATOR ::::"

  putStrLn ""
  playerCount <- getNonZeroInt "How many people are playing?"

  putStrLn ""
  players <- getPlayers playerCount

  putStrLn ""
  playersWorldsEnd <- getScores "World's End" players
  putStrLn ""
  playersFaceValue <- getScores "Face Value" playersWorldsEnd
  putStrLn ""
  playersBonus <- getScores "Bonus" playersFaceValue

  let playersSorted = sortBy comparePlayers playersBonus

  putStrLn ""
  putStrLn ""
  printf "%-2s%-16s%-5s\n" "#" "PLAYER" "SCORE"
  putStrLn ""
  zipWithM_ printPlayerScores [1 ..] playersSorted
  putStrLn ""
