class Article < ApplicationRecord
  before_save :create_slug
  validates :title, :description, :body, presence: true

  def to_json
    {
      **as_json({ except: %i[id created_at updated_at]}),
      createdAt: created_at,
      updatedAt: updated_at
    }
  end

  private
  def create_slug
    self.slug = title.parameterize
  end
end


