const std = @import("std");
const input = @embedFile("input.txt");
//const input = @embedFile("my-input.txt");

const ASCII_BASE: u8 = 48;

pub fn main() !void {
    var joltages = std.mem.tokenizeSequence(u8, input, "\n");
    var sum: u64 = 0;

    while (joltages.next()) |j| {
        std.debug.print("Joltage: {s}\n", .{j});

        const k = 12;
        var result: u64 = 0;
        var selected: usize = 0;
        var start: usize = 0;

        while (selected < k) {
            const remaining = k - selected;
            const search_end = j.len - remaining + 1;

            var max_digit: u8 = 0;
            var max_index: usize = start;

            for (j[start..search_end], start..) |letter, i| {
                const digit = letter - ASCII_BASE;
                if (digit > max_digit) {
                    max_digit = digit;
                    max_index = i;
                }
            }

            std.debug.print("start={} search_end={}\n", .{ start, search_end });

            result = result * 10 + max_digit;
            selected += 1;
            start = max_index + 1;
        }

        std.debug.print("max joltage={}\n", .{result});
        sum += result;
    }

    std.debug.print("Sum: {}\n", .{sum});
}
