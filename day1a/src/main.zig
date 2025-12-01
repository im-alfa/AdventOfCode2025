const std = @import("std");
const input = @embedFile("my-input.txt");

const MAX_SPINS: u8 = 100;

pub fn main() !void {
    var dial: i32 = 50;
    var zeroes: i32 = 0;

    var it = std.mem.splitSequence(u8, input, "\n");
    while (it.next()) |line| {
        const dir = line[0];

        const spins = try std.fmt.parseInt(i32, line[1..], 10);

        if (dir == 'L') {
            dial -= spins;
        } else if (dir == 'R') {
            dial += spins;
        }

        dial = @mod(dial, MAX_SPINS);

        if (dial == 0) {
            zeroes += 1;
        }
    }

    std.debug.print("Zeroes: {d}\n", .{zeroes});
}
