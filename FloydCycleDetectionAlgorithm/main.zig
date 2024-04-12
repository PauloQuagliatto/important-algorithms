const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

pub fn SinglyLinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            next: ?*Node = null,
            data: T,
        };

        head: ?*Node = null,

        pub fn add(self: *Self, new_node: *Node) void {
            new_node.next = null;
            if (self.head == null) {
                self.head = new_node;
            } else {
                var aux: ?*Node = self.head;
                while (aux) |auxNode| {
                    if (auxNode.next == null) {
                        auxNode.next = new_node;
                        break;
                    }
                    aux = auxNode.next;
                }
            }
        }

        pub fn printList(self: *Self) void {
            var current = self.head;
            while (current) |cur| {
                if (cur.next != null) {
                    std.debug.print("{}, ", .{cur.data});
                } else {
                    std.debug.print("{}.\n", .{cur.data});
                }

                current = cur.next;
            }
        }

        pub fn findLoop(self: *Self) bool {
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
    };
}

pub fn main() !void {
    const L = SinglyLinkedList(u32);
    var list = L{};

    var one = L.Node{ .data = 1 };
    var ten = L.Node{ .data = 10 };
    var five = L.Node{ .data = 5 };
    var seven = L.Node{ .data = 7 };
    var eight = L.Node{ .data = 8 };

    list.add(&ten);
    list.add(&five);
    list.add(&seven);
    list.add(&one);
    list.add(&eight);

    var temp = list.head;
    while (temp.?.next) |t| {
        temp = t.next;
    }

    temp.?.next = list.head;

    if (list.findLoop()) {
        std.debug.print("has loop\n", .{});
    } else {
        std.debug.print("has no loop\n", .{});
    }
}
