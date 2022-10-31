class MaxIntSet

  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise 'Out of bounds' if num > @store.count or num < 0
    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
   return true if self[num].include?(num)
   false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num) 
  
    @count +=1
    resize! if count >= @store.length
    self[num] << num
    true
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1 
    end
  end

  def include?(num)
   return true if self[num].include?(num)
   false
  end

  private

  def [](num)
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    if count == @store.length
      old = @store.map do |bucket|
        bucket
      end
      @store = Array.new(count * 2) {Array.new(0)}
      old.each do |bucket|
        bucket.each {|val| self[val % @store.length] << val }
      end
    end
  end
end
