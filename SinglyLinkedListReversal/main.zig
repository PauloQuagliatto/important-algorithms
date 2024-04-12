const std = @import("std");
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

        pub fn reverse(self: *Self) void {
            var current: ?*Node = self.head;
            var prev: ?*Node = null;
            var next: ?*Node = null;

            while (current != null) {
                next = current.?.next;
                current.?.next = prev;
                prev = current;
                current = next;
            }
            self.head = prev orelse null;
        }
    };
}

pub fn main() !void {
    const L = SinglyLinkedList(u32);
    var list = L{};

    var one = L.Node{ .data = 1 };
    var two = L.Node{ .data = 2 };
    var three = L.Node{ .data = 3 };
    var four = L.Node{ .data = 4 };
    var five = L.Node{ .data = 5 };
    var seven = L.Node{ .data = 7 };

    list.add(&seven);
    list.add(&two);
    list.add(&one);
    list.add(&four);
    list.add(&three);
    list.add(&five);

    list.printList();
    list.reverse();
    list.printList();
}
