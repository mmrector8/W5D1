class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    length = self.length
    return 1 if length == 0
    first = self[0]
    last = self[-1]
    length + (first + last)**2
  end
end

class String
  def hash
    self.bytes.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.values.sort.join("").hash
  end
end
