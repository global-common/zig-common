const std = @import("std");

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});

    // create a module to be used internally.
    var console_module = b.createModule(.{
        .source_file = .{ .path = if (target.isWindows()) "src/console/windows.zig" else "src/console/default.zig" },
    });

    // register the module so it can be referenced
    // using the package manager.
    try b.modules.put(b.dupe("console"), console_module);
}
