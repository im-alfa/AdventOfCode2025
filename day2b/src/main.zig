const std = @import("std");
const input = @embedFile("input.txt");
//const input = @embedFile("my-input.txt");

fn isInvalidId(n: u64) bool {
    var buf: [20]u8 = undefined;
    const s = std.fmt.bufPrint(&buf, "{}", .{n}) catch unreachable;

    if (s.len <= 1) return false;

    const ns = s.len;
    var doubled: [40]u8 = undefined;
    @memcpy(doubled[0..ns], s);
    @memcpy(doubled[ns .. ns * 2], s);

    const mid = doubled[1 .. s.len * 2 - 1];
    return std.mem.indexOf(u8, mid, s) != null;
}

pub fn main() !void {
    var ranges = std.mem.tokenizeAny(u8, input, ",\n");
    var sum: u64 = 0;

    while (ranges.next()) |r| {
        const pos = std.mem.indexOf(u8, r, "-") orelse continue;
        const start = try std.fmt.parseInt(u64, r[0..pos], 10);
        const end = try std.fmt.parseInt(u64, r[pos + 1 ..], 10);

        var idx = start;
        while (idx <= end) : (idx += 1) {
            if (isInvalidId(idx)) sum += idx;
        }
    }

    std.debug.print("Sum: {}\n", .{sum});
}
