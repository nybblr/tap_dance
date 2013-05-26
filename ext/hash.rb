class Hash
  # Converts a deeply nested hash
  # of stringish keys and values
  # to an array of flattened branches
  #
  # For example, consider:
  #
  #   hash = {
  #     :with => {
  #       :b => [1, 2]
  #     },
  #     :without => "c"
  #   }
  #
  #   hash.squash("_") =>
  #     [
  #       "with_b_1",
  #       "with_b_2",
  #       "without_c"
  #     ]
  #
  # This is useful for readable hash options, like:
  #
  #   magic :with => [ "Jack", "Giant" => { :in => "sky", :on => [ "ground", "harp" ] } ]

  def squash(separator=" ")
    inject([]) do |memo, (k, v)|
      key = if k.respond_to?(:squash) then k.squash else [ k.to_s ] end
      val = if v.respond_to?(:squash) then v.squash else [ v.to_s ] end

      # Loop over all combos
      for sk in key do
        for sv in val do
          memo << (sk + separator + sv)
        end
      end

      memo
    end

  end
end
