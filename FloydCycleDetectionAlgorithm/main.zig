const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

const LinkedList = struct {
    head: ?*Node,
    allocator: Allocator,
    size: u32,
    const Node = struct { data: u32, next: ?*Node };

    pub fn init(allocator: Allocator) LinkedList {
        return .{
            .head = null,
            .allocator = allocator,
            .size = 0,
        };
    }

    pub fn deinit(self: *LinkedList) void {
        var current = self.head;
        const loop = self.findLoop();
        if (loop) {
            self.destroyLoop();
        }
        while (current) |cur| {
            current = cur.next;
            self.allocator.destroy(cur);
        }
        self.head = undefined;
        self.size = 0;
    }

    pub fn add(self: *LinkedList, data: u32) !void {
        const node = try self.allocator.create(Node);
        node.* = .{
            .next = null,
            .data = data,
        };
        if (self.head == null) {
            self.head = node;
        } else {
            var aux: ?*Node = self.head;
            while (aux) |auxNode| {
                if (auxNode.next == null) {
                    auxNode.next = node;
                    break;
                }
                aux = auxNode.next;
            }
        }
        self.size += 1;
    }

    pub fn findLoop(self: *LinkedList) bool {
        var slowPointer: ?*Node = self.head;
        var fastPointer: ?*Node = self.head;

        while (slowPointer != null and fastPointer != null and fastPointer.?.next != null) {
            slowPointer = slowPointer.?.next;
            fastPointer = fastPointer.?.next.?.next;
            if (slowPointer == fastPointer) {
                return true;
            }
        }

        return false;
    }

    pub fn destroyLoop(self: *LinkedList) void {
        var prev = self.head;
        var next = self.head.?.next;

        while (prev) |prevNode| {
            var i: u32 = 0;
            while (i < self.size) : (i += 1) {
                if (next.?.next == prev) {
                    next.?.next = null;
                    break;
                } else {
                    next = next.?.next;
                }
            }
            prev = prevNode.next;
            next = prev.?.next;
        }
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();
    var list = LinkedList.init(allocator);
    defer list.deinit();

    try list.add(10);
    try list.add(5);
    try list.add(7);
    try list.add(1);
    try list.add(8);

    var temp = list.head;
    while (temp.?.next) |t| {
        temp = t.next;
    }

    temp.?.next = list.head;

    if (list.findLoop()) {
        std.debug.print("has loop", .{});
    } else {
        std.debug.print("has no loop", .{});
    }
}
