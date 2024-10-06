const std = @import("std");
const tpl = @import("tuple.zig");
const expect = std.testing.expect;
const EPSILON = 0.00001;
const INF = 1e10;

pub fn main() !void {}

fn approxEq(comptime T: type, a: T, b: T) bool {
    return std.math.approxEqAbs(T, a, b, EPSILON);
}

fn tuple(x: f32, y: f32, z: f32, w: f32) tpl.Tuple {
    return tpl.Tuple{ .x = x, .y = y, .z = z, .w = w };
}

fn point(x: f32, y: f32, z: f32) tpl.Tuple {
    return .{ .x = x, .y = y, .z = z, .w = 1.0 };
}

fn vector(x: f32, y: f32, z: f32) tpl.Tuple {
    return .{ .x = x, .y = y, .z = z, .w = 0.0 };
}

test "approxEq should return true" {
    const f = 5.0;
    const c = 4.99999;
    try expect(approxEq(@TypeOf(f), f, c));
}

test "a tuple with w=1.0 is a point" {
    const a = tuple(4.3, -4.2, 3.1, 1.0);
    try expect(a.x == 4.3);
    try expect(a.y == -4.2);
    try expect(a.z == 3.1);
    try expect(a.w == 1.0);
    try expect(tpl.isPoint(a));
    try expect(!tpl.isVector(a));
}

test "a tuple with w=0.0 is a point" {
    const a = tuple(4.3, -4.2, 3.1, 0.0);
    try expect(a.x == 4.3);
    try expect(a.y == -4.2);
    try expect(a.z == 3.1);
    try expect(a.w == 0.0);
    try expect(!tpl.isPoint(a));
    try expect(tpl.isVector(a));
}

test "point() creates tuples with w=1" {
    const p = point(4, -4, 3);
    try expect(tpl.equals(p, tuple(4, -4, 3, 1)));
}

test "vector() creates tuples with w=0" {
    const p = vector(4, -4, 3);
    try expect(std.meta.eql(p, tuple(4, -4, 3, 0)));
}

test "adding two tuples" {
    const a1 = tuple(3, -2, 5, 1);
    const a2 = tuple(-2, 3, 1, 0);
    const expected = tuple(1, 1, 6, 1);
    try expect(tpl.equals(expected, tpl.add(a1, a2)));
}

test "subtracting two points" {
    const p1 = point(3, 2, 1);
    const p2 = point(5, 6, 7);
    const expected = vector(-2, -4, -6);
    try expect(tpl.equals(expected, tpl.sub(p1, p2)));
}

test "subtracting a vector from a point" {
    const p1 = point(3, 2, 1);
    const v1 = vector(5, 6, 7);
    const expected = point(-2, -4, -6);
    try expect(tpl.equals(expected, tpl.sub(p1, v1)));
}

test "subtracting two vectors" {
    const p1 = vector(3, 2, 1);
    const v1 = vector(5, 6, 7);
    const expected = vector(-2, -4, -6);
    try expect(tpl.equals(expected, tpl.sub(p1, v1)));
}

test "subtracting a vector from the zero vector" {
    const v = vector(1, -2, 3);
    const expected = vector(-1, 2, -3);

    try expect(tpl.equals(expected, tpl.sub(tpl.ZERO, v)));
}

test "negating a tuple" {
    const t = tuple(1, -2, 3, -4);
    const expected = tuple(-1, 2, -3, 4);
    try expect(tpl.equals(expected, tpl.neg(t)));
}
