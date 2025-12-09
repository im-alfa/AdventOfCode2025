const std = @import("std");
const input = @embedFile("input.txt");
//const input = @embedFile("my-input.txt");

const VECTOR: []const [2]i32 = &.{
    .{ -1, -1 }, .{ 0, -1 }, .{ 1, -1 },
    .{ -1, 0 },  .{ 1, 0 },  .{ -1, 1 },
    .{ 0, 1 },   .{ 1, 1 },
};

const SIZE: u32 = 10;
//const SIZE: u32 = 140;

pub fn main() !void {
    var lines = std.mem.tokenizeSequence(u8, input, "\n");

    var data = [_]u32{0} ** (SIZE * SIZE);

    var counter: usize = 0;

    var write_idx: usize = 0;
    while (lines.next()) |line| {
        for (line) |ch| {
            data[write_idx] = ch;
            write_idx += 1;
        }
    }

    for (0..SIZE * SIZE) |idx| {
        if (data[idx] != '@') continue;

        const column = @mod(idx, SIZE);
        const row = idx / SIZE;

        const col_i32 = @as(i32, @intCast(column));
        const row_i32 = @as(i32, @intCast(row));

        var neighbours_with_rolls: u32 = 0;

        for (VECTOR) |vec| {
            const new_col = col_i32 + vec[0];
            const new_row = row_i32 + vec[1];

            if (new_row < 0 or new_row >= @as(i32, SIZE)) continue;
            if (new_col < 0 or new_col >= @as(i32, SIZE)) continue;

            const new_idx: usize =
                @as(usize, @intCast(new_row)) * SIZE +
                @as(usize, @intCast(new_col));

            if (data[new_idx] == '@') {
                neighbours_with_rolls += 1;
            }
        }

        if (neighbours_with_rolls < 4) {
            counter += 1;
        }
    }

    std.debug.print("Counter={d}\n", .{counter});
}
