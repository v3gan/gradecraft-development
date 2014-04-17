class ExistingMetricSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :max_points, :rubric_id, :order
  has_many :tiers, serializer: ExistingTierSerializer

  def tiers
    object.tiers.order("points DESC, created_at ASC")
  end
end
