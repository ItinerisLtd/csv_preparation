require 'csv'

class KinstaEscape
  include ActiveModel::Model

  attr_accessor :content
  attr_reader :sanitized_rows

  validates :content, presence: true

  def prepare
    return unless valid?
    @sanitized_rows = sanitize(csv: content)
  end

  private

  def sanitize(csv:)
    rows = CSV.parse(csv)

    rows = rows.reject do |row|
      row.size != 4
    end

    rows = rows.reject do |row|
      row.third.include? "?"
    end

    rows = rows.reject do |row|
      row&.third.include? ","
    end

    rows = rows.reject do |row|
      row&.fourth.include? ","
    end

    # Escape `redirect_from`
    rows = rows.map do |row|
      row[2] = row.third.tr('"', '')
      row[2] = row.third.chomp("/")
      row[2] = row.third + "/?"

      row[2] = '^' + row.third + '$'

      row
    end

    # Escape `redirect_from`
    froms = rows.map(&:third)
    rows.reject do |row|
      froms.count(row.third) > 1
    end
  end
end
