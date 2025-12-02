const std = @import("std");
const input = @embedFile("input.txt");
//const input = @embedFile("my-input.txt");

pub fn main() !void {
    var ranges = std.mem.tokenizeAny(u8, input, ",\n");
    var sum: u64 = 0;

    while (ranges.next()) |r| {
        const pos = std.mem.indexOf(u8, r, "-") orelse continue;
        const start_str = r[0..pos];
        const end_str = r[pos + 1 ..];

        const start = try std.fmt.parseInt(u64, start_str, 10);
        const end = try std.fmt.parseInt(u64, end_str, 10);

        const nstart = @as(u64, @intFromFloat(@ceil(@log10(@as(f64, @floatFromInt(start))))));
        const nend = @as(u64, @intFromFloat(@ceil(@log10(@as(f64, @floatFromInt(end))))));

        if (nstart % 2 != 0 and nend % 2 != 0) continue;

        //std.debug.print("{} ({}) -- {} ({})\n", .{ start, nstart, end, nend });
        for (start..end + 1) |idx| {
            const n = @as(u64, @intFromFloat(@ceil(@log10(@as(f64, @floatFromInt(idx))))));
            if (@mod(n, 2) != 0) continue;

            const divisor = std.math.pow(u64, 10, n / 2);
            const left_half = idx / divisor;
            const right_half = idx % divisor;

            if (left_half == right_half) {
                sum += idx;
            }
        }
    }

    std.debug.print("Sum: {}\n", .{sum});
}
