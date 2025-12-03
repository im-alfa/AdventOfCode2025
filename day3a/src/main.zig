const std = @import("std");
const input = @embedFile("input.txt");
//const input = @embedFile("my-input.txt");

const ASCII_BASE: u8 = 48;

pub fn main() !void {
    var joltages = std.mem.tokenizeSequence(u8, input, "\n");
    var sum: u64 = 0;

    while (joltages.next()) |j| {
        std.debug.print("Joltage: {s}\n", .{j});
        var maxJoltage: u64 = 0;

        for (j, 0..) |first_letter, i| {
            const first = first_letter - ASCII_BASE;
            for (j[i + 1 ..]) |second_letter| {
                const second = second_letter - ASCII_BASE;
                const joltage = first * 10 + second;
                if (joltage > maxJoltage) {
                    maxJoltage = joltage;
                }
            }
        }

        std.debug.print("Max joltage={}\n", .{maxJoltage});
        sum += maxJoltage;
    }

    std.debug.print("Sum: {}\n", .{sum});
}
