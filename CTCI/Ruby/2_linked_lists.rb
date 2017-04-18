class Node
  attr_accessor :value, :next, :prev

  def initialize(value = nil)
    @value = value
    @next = nil
    @prev = nil
  end
end

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def append(node)
    @tail.prev.next = node
    node.prev = @tail.prev
    node.next = @tail
    @tail.prev = node
  end

  def delete(node)
    node.prev.next = node.next
    node.next.prev = node.prev
  end

  def values
    string = ""
    node = @head.next
    count = 0

    while node.value
      string += "(Node #{count}: #{node.value}) "
      count += 1
      node = node.next
    end

    string.strip!
  end
end

a = LinkedList.new
b = Node.new(1)
c = Node.new(11)
d = Node.new(10)
e = Node.new(5)
f = Node.new(7)
g = Node.new(3)
h = Node.new(1)

a.append(b)
a.append(c)
a.append(d)
a.append(e)
a.append(f)
a.append(g)
a.append(h)

# p a.values

# Time O(N)
# Space O(N)
def remove_dups(linked_list)
  node = linked_list.head.next
  seen = {}

  until node == linked_list.tail
    linked_list.delete(node) if seen[node.value]
    seen[node.value] = true

    node = node.next
  end

  linked_list
end

p remove_dups(a).values == "(Node 0: 1) (Node 1: 11) (Node 2: 10) (Node 3: 5) (Node 4: 7) (Node 5: 3)"

# Time O(N)
# Space O(1)
def kth_to_last(linked_list, k)
  current_node = linked_list.head.next
  kth_node = current_node

  k.times do
    kth_node = kth_node.next
  end

  until kth_node.next == @tail
    current_node = current_node.next
    kth_node = kth_node.next
  end

  current_node
end

p kth_to_last(a, 2).value == 7

# Time O(1)
# Space O(1)
def delete_middle_node(node)
  temp = node.prev
  temp.next = node.next
  node.next.prev = temp
end

delete_middle_node(d)
p a.values == "(Node 0: 1) (Node 1: 11) (Node 2: 5) (Node 3: 7) (Node 4: 3)"

# Time O(N)
# Space O(N)
def partition(linked_list, x)
  left_partition = LinkedList.new
  right_partition = LinkedList.new

  current_node = linked_list.head.next

  until current_node == linked_list.tail
    if current_node.value < x
      next_node = current_node.next
      linked_list.delete(current_node)
      left_partition.append(current_node)
    else
      next_node = current_node.next
      linked_list.delete(current_node)
      right_partition.append(current_node)
    end

    current_node = next_node
  end

  right_head = right_partition.head.next
  left_tail = left_partition.tail.prev

  left_tail.next = right_head
  right_head.prev = left_tail

  left_partition
end

new_list = LinkedList.new
n1 = Node.new(3)
n2 = Node.new(5)
n3 = Node.new(8)
n4 = Node.new(5)
n5 = Node.new(10)
n6 = Node.new(2)
n7 = Node.new(1)

new_list.append(n1)
new_list.append(n2)
new_list.append(n3)
new_list.append(n4)
new_list.append(n5)
new_list.append(n6)
new_list.append(n7)

p partition(new_list, 5).values == "(Node 0: 3) (Node 1: 2) (Node 2: 1) (Node 3: 5) (Node 4: 8) (Node 5: 5) (Node 6: 10)"

# Time O(N)
# Space O(N)
def sum_lists(list1, list2)
  num = 0
  factor = 1

  list1_node = list1.head.next
  list2_node = list2.head.next

  while list1_node.value
    num += (list1_node.value * factor)
    num += (list2_node.value * factor)
    list1_node = list1_node.next
    list2_node = list2_node.next
    factor *= 10
  end

  string_num = num.to_s
  new_list = LinkedList.new

  (string_num.length - 1).downto(0).each do |idx|
    new_node = Node.new(string_num[idx].to_i)
    new_list.append(new_node)
  end

  new_list
end

list1_sum_list = LinkedList.new
list1a = Node.new(7)
list1b = Node.new(1)
list1c = Node.new(6)
list1_sum_list.append(list1a)
list1_sum_list.append(list1b)
list1_sum_list.append(list1c)

list2_sum_list = LinkedList.new
list2a = Node.new(5)
list2b = Node.new(9)
list2c = Node.new(2)
list2_sum_list.append(list2a)
list2_sum_list.append(list2b)
list2_sum_list.append(list2c)

p sum_lists(list1_sum_list, list2_sum_list).values == "(Node 0: 2) (Node 1: 1) (Node 2: 9)"
