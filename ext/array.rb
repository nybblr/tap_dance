class Array
  # Simple implementation of hash
  # squash for Hash#squash. See the
  # Hash notes for more explanation.
  #
  # For Array, we simply call squash
  # on each item.

  def squash(separator=" ")
    map do |m|
      if m.respond_to? :squash
        m.squash(separator)
      else
        m.to_s
      end
    end.flatten
  end
end
