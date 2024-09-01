const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "vma",
        .target = target,
        .optimize = optimize,
    });

    lib.linkLibC();
    lib.linkLibCpp();
    lib.linkSystemLibrary("vulkan");
    lib.addCSourceFile(.{ .file = b.path("src/vk_mem_alloc.cc"), .flags = &.{"-Wno-nullability-completeness"} });
    lib.installHeader(b.path("src/vk_mem_alloc.h"), "vk_mem_alloc.h");
    b.installArtifact(lib);
}
