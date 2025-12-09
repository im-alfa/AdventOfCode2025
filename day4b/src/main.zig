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

fn isRemovable(idx: usize, data: []const u8) bool {
    if (data[idx] != '@') return false;

    const row_usize = idx / SIZE;
    const col_usize = idx % SIZE;

    const row = @as(i32, @intCast(row_usize));
    const col = @as(i32, @intCast(col_usize));

    var adjacent: usize = 0;

    for (VECTOR) |vec| {
        const new_row = row + vec[1];
        const new_col = col + vec[0];

        if (new_row < 0 or new_row >= @as(i32, SIZE)) continue;
        if (new_col < 0 or new_col >= @as(i32, SIZE)) continue;

        const new_idx: usize =
            @as(usize, @intCast(new_row)) * SIZE +
            @as(usize, @intCast(new_col));

        if (data[new_idx] == '@') {
            adjacent += 1;
            if (adjacent >= 4) return false;
        }
    }

    return adjacent < 4;
}

pub fn main() !void {
    var lines = std.mem.tokenizeSequence(u8, input, "\n");
    var data = [_]u8{0} ** (SIZE * SIZE);

    var counter: usize = 0;
    while (lines.next()) |line| {
        for (line) |ch| {
            data[counter] = ch;
            counter += 1;
        }
    }

    var total_removed: usize = 0;

    var to_remove = [_]bool{false} ** (SIZE * SIZE);

    while (true) {
        var any: bool = false;

        for (0..SIZE * SIZE) |idx| {
            if (isRemovable(idx, &data)) {
                to_remove[idx] = true;
                any = true;
            } else {
                to_remove[idx] = false;
            }
        }

        if (!any) break;

        for (0..SIZE * SIZE) |idx| {
            if (to_remove[idx]) {
                data[idx] = '.';
                total_removed += 1;
            }
        }
    }

    std.debug.print("total removed: {d}\n", .{total_removed});
}
