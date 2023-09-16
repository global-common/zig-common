const std = @import("std");

//pub fn install(step: *std.Build.CompileStep) !*std.Build.Step {
pub fn install(step: *std.Build.CompileStep, isWindows: bool) !*std.Build.Step.Run {
    const prefix = comptime std.fs.path.dirname(@src().file).? ++ std.fs.path.sep_str;
    const b = step.step.owner;
    step.subsystem = .Native;

    //const target = b.standardTargetOptions(.{});

    const console = b.createModule(.{
        .source_file = .{ .path = if (isWindows) prefix ++ "/src/console/windows.zig" else prefix ++ "/src/console/default.zig" },
    });

    step.addModule("conosole", console);

    const run_step = b.addRunArtifact(step);

    //return &run_step.step; // this works because run_step is allocated on the heap
    return run_step;
}
