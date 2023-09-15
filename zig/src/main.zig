const std = @import("std");

const Player = struct {
    name: [16]u8,
    score: i64,
};

fn get_int(comptime int_type: type) int_type {
    const stdin = std.io.getStdIn().reader();

    var buf: [16]u8 = undefined;

    if (stdin.readUntilDelimiterOrEof(buf[0..], '\n') catch "0") |input| {
        return std.fmt.parseInt(int_type, input, 10) catch 0;
    } else {
        return 0;
    }
}

fn get_name(n: u64, out: *[16]u8) !void {
    const stdin = std.io.getStdIn().reader();

    var defaultPlayerName: [16]u8 = undefined;
    _ = try std.fmt.bufPrint(&defaultPlayerName, "{d}", .{n});

    var buf: [16]u8 = undefined;
    var input = (stdin.readUntilDelimiterOrEof(&buf, '\n') catch &defaultPlayerName) orelse &defaultPlayerName;

    _ = try std.fmt.bufPrint(out, "{s}", .{input});
}

pub fn get_score(score_type: []const u8, player_name: []const u8) !i64 {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("What is {s}'s {s} score?\n", .{ player_name, score_type });
    return get_int(i64);
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("\n", .{});
    try stdout.print(":::: DOOOMLINGS SCORE CALCULATOR\n", .{});

    try stdout.print("\n", .{});
    try stdout.print("How many people are playing?\n", .{});

    var num_players: usize = 0;
    while (num_players < 1) {
        num_players = get_int(usize);
    }

    try stdout.print("\n", .{});
    var players = std.ArrayList(Player).init(std.heap.page_allocator);
    for (0..num_players) |n| {
        const playerNumber = n + 1;
        try stdout.print("What is player {d}'s name?\n", .{playerNumber});
        var player = Player{ .name = undefined, .score = 0 };
        try get_name(playerNumber, &player.name);
        try players.append(player);
    }

    try stdout.print("\n", .{});
    for (0..num_players) |n| {
        players.items[n].score += try get_score("World's End", &players.items[n].name);
    }

    try stdout.print("\n", .{});
    for (0..num_players) |n| {
        players.items[n].score += try get_score("Face Value", &players.items[n].name);
    }

    try stdout.print("\n", .{});
    for (0..num_players) |n| {
        players.items[n].score += try get_score("Bonus Points", &players.items[n].name);
    }

    try stdout.print("\n", .{});
    try stdout.print("\n", .{});
    try stdout.print("{s:<2}{s:<16}{s:>5}\n", .{ "#", "PLAYER", "SCORE" });
    try stdout.print("\n", .{});

    for (0..num_players) |n| {
        const player = players.items[n];
        try stdout.print("{d:<2}{s:<16}{d:>5}\n", .{ n + 1, player.name, player.score });
    }
    try stdout.print("\n", .{});
}
