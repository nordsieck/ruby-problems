class Heap
  # @clazz

  def initialize(min = true, *vals)
    @data = []
    if min
      @fn = :<
    else
      @fn = :>
    end

    vals = vals[0] if vals.size == 1 && vals[0].class == Array
    vals.each { |v| push(v) }
  end

  def raw() @data end
  
  def pretty_print(pp) pp.text "#{@data}" end
  
  def push(e)
    @clazz = e.class unless defined?(@clazz)
    raise ArgumentError.new("wrong class") unless e.class == @clazz
    raise ArgumentError.new("incomperable") unless e.respond_to?(@fn) # <=> is a default method which alreays returns 0

    @data.push(e)

    # balance
    n = size() - 1
    p = (n + 1) / 2 - 1

    while (p >= 0) and (@data[n].send(@fn, @data[p]))
      @data[n], @data[p] = @data[p], @data[n]
      n = p
      p = (n + 1) / 2 - 1
    end
  end

  def size() @data.size end

  def is_empty?() size() == 0 end

  def pop
    return nil if size() == 0

    ret = @data[0]
    val = @data.pop
    @data[0] = val unless size() == 0

    # balance
    n = 0
    while size() > n * 2 + 2
      child = n * 2 + 1
      if @data[child + 1].send(@fn, @data[child])

        break unless @data[child + 1].send(@fn, @data[n])

        @data[n], @data[child + 1] = @data[child + 1], @data[n]
        n = child + 1
      else
        
        break unless @data[child].send(@fn, @data[n])
        
        @data[n], @data[child] = @data[child], @data[n]
        n = child
      end
    end

    child = n * 2 + 1
    if size() == child + 1 && @data[child].send(@fn, @data[n])
      @data[n], @data[child] = @data[child], @data[n]
    end

    ret
  end
end
