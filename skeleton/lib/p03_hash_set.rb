class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(item)
    return false if include?(item) 
  
    @count +=1
    resize! if count >= @store.length
    self[item.hash] << item
    true
  end

  def remove(item)
    if include?(item)
      self[item.hash].delete(item)
      @count -= 1 
    end
  end

  def include?(item)
   return true if self[item.hash].include?(item)
   false
  end

  private

  def [](item)
    @store[item.hash % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    if count == @store.length
      old = @store.map do |bucket|
        bucket
      end
    end
      @store = Array.new(count * 2) {Array.new(0)}
      old.each do |bucket|
        bucket.each {|val| self[val % @store.length] << val }
      end
    end

end
