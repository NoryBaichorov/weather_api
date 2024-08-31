# frozen_string_literal: true

module ArrayExtensions
  def avg_by(collection, &block)
    return nil if collection.empty?
    
    total = collection.sum(&block)
    total.to_f / collection.size
  end
end
