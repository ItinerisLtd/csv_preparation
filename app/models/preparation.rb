class Preparation
  include ActiveModel::Model

  attr_accessor :content
  attr_reader :sanitized_content

  validates :content, presence: true

  def sanitize
    return unless valid?
    sanitized_content = content
  end
end
