use std::io;

struct Player {
    name: String,
    score: i32,
}

impl Player {
    fn new(name: String, score: i32) -> Player {
        Player {
            name: name.to_owned(),
            score: score,
        }
    }
}

fn get_input(prompt: String) -> String {
    println!("{}", prompt);
    let mut input = String::new();
    match io::stdin().read_line(&mut input) {
        Ok(_) => {}
        Err(_) => {}
    }
    input.trim().to_string()
}

fn get_scores(score_type: String, players: &mut Vec<Player>) {
    println!("");
    for player in players {
        let prompt = format!("{} has how many {} points?", player.name, score_type);
        player.score += get_input(prompt).parse().unwrap_or(0);
    }
}

fn main() {
    println!(":::: DOOMLINGS SCORE CALCULATOR ::::");
    println!("");

    let mut player_count: usize = 0;
    while player_count == 0 {
        player_count = get_input(String::from("How many players are there?"))
            .parse()
            .unwrap_or(0);
    }

    let mut players: Vec<Player> = Vec::with_capacity(player_count);

    println!("");
    for player_index in 0..player_count {
        let prompt = format!("What is Player {}'s name?", player_index + 1);
        let name_from_user = get_input(prompt);
        let name = if !name_from_user.is_empty() {
            name_from_user
        } else {
            (player_index + 1).to_string()
        };
        players.push(Player::new(name, 0));
    }

    get_scores("World's End".to_string(), &mut players);
    get_scores("Face Value".to_string(), &mut players);
    get_scores("Bonus".to_string(), &mut players);

    players.sort_by(|a, b| b.score.cmp(&a.score));

    println!("");
    println!("");
    println!("{:2}{:16}{:5}", "#", "PLAYER", "SCORE");
    println!("");
    for (i, player) in players.iter().enumerate() {
        println!("{:<2}{:16}{:>5}", i + 1, player.name, player.score);
    }
    println!("");
}
