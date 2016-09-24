module RelationHelper
  def count_relation(relation)
    count = relation.count
    if count.is_a? Hash
      count.count
    else
      count
    end
  end
end
