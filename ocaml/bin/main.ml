let rec get_non_zero_int prompt =
  print_string prompt; print_newline ();
  flush stdout;
  match read_int_opt() with
    | Some n -> n
    | None -> get_non_zero_int prompt

let rec get_non_empty_str prompt =
  print_string prompt; print_newline ();
  flush stdout;
  match read_line() with
    | "" -> get_non_empty_str prompt
    | s -> s
    
let get_players_names player_count =
  print_newline();
  List.init player_count (fun i ->
    let prompt = Printf.sprintf "What is Player %d's name?" (i+1) in
    (get_non_empty_str prompt, 0)
  )

let get_players_scores score_type players =
  print_newline();
  List.map (fun p ->
    let prompt = Printf.sprintf "%s, enter your %s, score" (fst p) score_type in
    let score = (snd p) + (get_non_zero_int prompt) in
    (fst p, score)
  ) players

let pad_left str len chr =
  let pad_len = len - (String.length str) in
  if pad_len <= 0 then
    str
  else
    (String.make pad_len chr) ^ str

let pad_right str len chr =
  let pad_len = len - (String.length str) in
  if pad_len <= 0 then
    str
  else
    str ^ (String.make pad_len chr)

let rec print_players rank players =
  match players with
    | [] -> print_newline
    | head :: tail ->
      Printf.printf "%s%s%s" (pad_right (string_of_int rank) 2 ' ') (pad_right (fst head) 16 ' ') (pad_left (string_of_int (snd head)) 5 ' ');
      print_newline ();
      print_players (rank + 1) tail

let () =
  print_string ":::: DOOMLINGS SCORE CALCULATOR ::::"; print_newline ();
  print_newline ();
  let player_count = get_non_zero_int "How many people are playing?" in
  let players = get_players_names player_count
    |> get_players_scores "World's End"
    |> get_players_scores "Face Value"
    |> get_players_scores "Bonus"
    |> List.sort (fun a b -> 
      compare (snd b) (snd a)
    )
  in
  print_newline();
  print_newline();
  Printf.printf "%s%s%s" (pad_right "#" 2 ' ') (pad_right "PLAYER" 16 ' ') (pad_right "SCORE" 5 ' ');
  print_newline();
  print_players 1 players
  ()