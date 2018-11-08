require 'csv'

class Preparation
  include ActiveModel::Model

  attr_accessor :content
  attr_reader :sanitized_rows

  validates :content, presence: true

  FILE_EXTENSION = %w(
    .png
    .mp4
    .mp3
    .bmp
    .gif
    .jpeg
    .svg
    .mp4
    .jpg
    .jpeg
    .pdf
    .zip
    .rar
  )

  def prepare
    return unless valid?
    @sanitized_rows = sanitize(csv: content)
  end

  private

  def sanitize(csv:)
    rows = CSV.parse(csv)

    # Remove screaming frog non-sense title and CSV headers
    rows.shift(2)

    addresses = rows.map(&:first)

    # Filter out file URLs
    addresses = addresses.reject do |address|
      address.split("?").first.end_with? *FILE_EXTENSION
    end

    # Remove domains and duplicates
    addresses = addresses.map do |address|
      Domainatrix.parse(address).path
    end.uniq

    # Sort "?"
    addresses = addresses.sort.partition do |address|
      address.split("?").second.blank?
    end.reverse.flatten

    rows = addresses.map do |source|
      [source, "", "0", "301", "0"]
    end

    rows.unshift(%w(source target regex code order))
  end
end
