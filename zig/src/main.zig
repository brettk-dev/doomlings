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

fn get_name(n: u64) [16]u8 {
    const stdin = std.io.getStdIn().reader();

    var buf: [16]u8 = undefined;

    const defaultPlayerName = std.fmt.allocPrint(std.heap.page_allocator, "Player {d}", .{n}) catch "";

    if (stdin.readUntilDelimiterOrEof(buf[0..], '\n') catch "0") |input| {
        if (input.len == 0) {
            return @as([16]u8, defaultPlayerName);
        }

        return @as([16]u8, input);
    } else {
        return @as([16]u8, defaultPlayerName);
    }
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

    try stdout.print("Player count: {d}\n", .{num_players});

    const players = std.ArrayList(Player);
    for (1..num_players) |n| {
        const name = get_name(n);
        players.addOne(Player{ .name = name, .score = 0 });
    }

    try stdout.print("Player 1's name: {s}", .{players[0].name});
}
