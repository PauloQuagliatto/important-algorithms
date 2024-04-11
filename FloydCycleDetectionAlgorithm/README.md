# Floyd Cycle Detection Algorithm

The Floyd Cycle Detection algorithm or Hare-Tortoise algorithm is a pointer algorithm that uses only two pointers, moving through the sequence at different speeds.

This algorithm is used to find a loop in a linked list.

It uses two pointers one moving twice as fast as the other one.

The faster one is called the fast pointer and the other one is called the slow pointer.

Here is a basic outline of how the Floyd Cycle Detection algorithm typically works:

1. **Initialize two pointers:** Slow (`slow`) and Fast (`fast`). Initially, `slow` and `fast` are set to the `head` of the list.

2. **Iterate through the list:** For each node in the list, set the `slow` to the first `next` node and the `fast` to the second node.

3. **Check if the pointers are the same:** Inside the iteration, if both `slow` and `fast` nodes are the same, you'll find there is a loop in the list.
