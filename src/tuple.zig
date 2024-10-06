const std = @import("std");

pub const Tuple = struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,
};

pub const ZERO = Tuple{
    .x = 0.0,
    .y = 0.0,
    .z = 0.0,
    .w = 0.0,
};

pub fn isPoint(t: Tuple) bool {
    return t.w == 1.0;
}

pub fn isVector(t: Tuple) bool {
    return t.w == 0.0;
}

pub fn equals(t1: Tuple, t2: Tuple) bool {
    return std.meta.eql(t1, t2);
}

pub fn add(t1: Tuple, t2: Tuple) Tuple {
    return .{
        .x = t1.x + t2.x,
        .y = t1.y + t2.y,
        .z = t1.z + t2.z,
        .w = t1.w + t2.w,
    };
}

pub fn sub(t1: Tuple, t2: Tuple) Tuple {
    return .{
        .x = t1.x - t2.x,
        .y = t1.y - t2.y,
        .z = t1.z - t2.z,
        .w = t1.w - t2.w,
    };
}

pub fn neg(t: Tuple) Tuple {
    return sub(ZERO, t);
}
