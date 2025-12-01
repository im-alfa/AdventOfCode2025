const std = @import("std");
const input = @embedFile("input.txt");
//const input = @embedFile("my-input.txt");

const MAX_SPINS: i64 = 100;

pub fn main() !void {
    var dial: i64 = 50;
    var crosses: i64 = 0;
    var dir: u8 = 'R';

    var it = std.mem.splitSequence(u8, input, "\n");
    while (it.next()) |line| {
        if (line.len == 0) continue;

        const new_dir = line[0];
        const rotation = try std.fmt.parseInt(i64, line[1..], 10);

        if (new_dir != dir) {
            dial = MAX_SPINS - dial;
            dir = new_dir;
        }

        dial = @mod(dial, MAX_SPINS) + rotation;

        crosses += @divFloor(dial, MAX_SPINS);
    }

    std.debug.print("crosses: {d}\n", .{crosses});
}

