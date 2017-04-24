# Graph
class Vertex
  attr_reader :in_edges, :out_edges, :value

  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  attr_reader :to_vertex, :from_vertex, :weight

  def initialize(from_vertex, to_vertex, weight = 1)
    @to_vertex = to_vertex
    @from_vertex = from_vertex
    @weight = weight

    @to_vertex.in_edges << self
    @from_vertex.out_edges << self
  end

  def destroy!
    self.to_vertex.in_edges.delete(self)
    self.from_vertex.out_edges.delete(self)
    self.to_vertex = nil
    self.from_vertex = nil
  end

  protected

  attr_writer :to_vertex, :from_vertex, :weight
end

# Test Graph
a = Vertex.new(1)
b = Vertex.new(2)
c = Vertex.new(3)
d = Vertex.new(4)
e = Vertex.new(5)
f = Vertex.new(6)
Edge.new(a, b)
Edge.new(c, d)
Edge.new(e, f)
Edge.new(a, d)
Edge.new(b, e)
Edge.new(a, c)

# Time O(N)
# Space O(N)
# BFS using queue!
def route_nodes(start_vertex, end_vertex)
  return true if start_vertex == end_vertex

  queue = [start_vertex]
  visited = {}

  until queue.empty?
    current = queue.shift

    current.out_edges.each do |edge|
      return true if edge.to_vertex == end_vertex

      unless visited[edge.to_vertex]
        queue << edge.to_vertex
      end
    end

    visited[current] = true
  end

  false
end

p route_nodes(c, a) == false
p route_nodes(a, c) == true

# Time O(N)
# Space O(N)
# DFS using stack!
def route_nodes_rec(start_vertex, end_vertex)
  return true if start_vertex == end_vertex

  visited ||= {}
  visited[start_vertex] = true

  start_vertex.out_edges.each do |edge|
    unless visited[edge.to_vertex]
      return true if route_nodes_rec(edge.to_vertex, end_vertex)
    end
  end

  false
end

p route_nodes_rec(c, a) == false
p route_nodes_rec(a, c) == true

class Tree
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def to_array
    queue = [self]

    array = []

    until queue.empty?
      current = queue.shift

      if current
        array << current.value
        queue << current.left
        queue << current.right
      end
    end

    array
  end
end

# Time O(N)
# Space O(N)
def minimal_tree(sorted_array)
  return if sorted_array.empty?

  mid = sorted_array.length / 2

  tree = Tree.new(sorted_array[mid])
  tree.left = minimal_tree(sorted_array[0...mid])
  tree.right = minimal_tree(sorted_array[mid + 1...sorted_array.length])

  tree
end

p minimal_tree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).to_array == [6, 3, 9, 2, 5, 8, 10, 1, 4, 7]

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
    last_node = @tail.prev

    last_node.next = node
    node.prev = last_node
    node.next = @tail
    @tail.prev = node
  end

  def delete(node)
    node.next.prev = node.prev
    node.prev.next = node.next
    node.next = nil
    node.prev = nil
  end

  def display_values
    string = ""

    current_node = @head.next

    while current_node != @tail
      string += current_node.value.to_s
      current_node = current_node.next
    end

    string
  end
end

# Time O(N) - excluding the display part
# Space O(N)
def list_of_depths(tree)
  lists = {}
  add_to_list(lists, tree, 1)

  display = []

  lists.each do |_, list|
    display << list.display_values
  end

  display
end

def add_to_list(lists, tree, depth)
  if !lists[depth]
    lists[depth] = LinkedList.new
  end

  lists[depth].append(Node.new(tree.value))

  add_to_list(lists, tree.left, depth + 1) if tree.left
  add_to_list(lists, tree.right, depth + 1) if tree.right
end


new_tree = minimal_tree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
p list_of_depths(new_tree) == ["6", "39", "25810", "147"]


def check_balanced(tree)
  
end
