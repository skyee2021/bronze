module MissionsHelper
  def tag_items_view(mission)
    mission.tags.map do |tag|
      %Q(<span class="tag">#{tag.category}</span>)
    end.join(' ')
  end
end
