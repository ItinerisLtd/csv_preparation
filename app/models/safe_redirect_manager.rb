require 'csv'

class SafeRedirectManager
  include ActiveModel::Model

  attr_accessor :content
  attr_reader :sanitized_rows

  validates :content, presence: true

  def prepare
    return unless valid?
    @sanitized_rows = sanitize(csv: content)
  end

  private

  # TODO: Remove double slashes
  def sanitize(csv:)
    rows = CSV.parse(csv)

    # Remove safe redirection manager header
    header = rows.shift(1).first

    # Normalize rows
    rows = rows.map do |row|
      row.map do |element|
        element.tr('"', '')
      end
    end

    # Remove empty source or empty target
    rows = rows.reject do |row|
      row.first.blank? || row.second.blank?
    end

    # Remove level-1 redirection loop
    rows = rows.reject do |row|
      row.first&.chomp("/") == row.second&.chomp("/")
    end

    # Add back header
    rows.unshift(header)

    # Normalize rows
    rows = rows.map do |row|
      row.map do |element|
        '"' + element.tr('"', '') + '"'
      end
    end
  end
end
