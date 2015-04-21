class SpreadsheetDecorator < Draper::Decorator
  delegate :title, :id, :human_url

  def available_columns
    worksheet_data.first[1..-1]
  end

  def row_identifiers
    worksheet_data[1..-1].map(&:first)
  end

  private

  def worksheet_data
    @worksheet_data ||= object.worksheets[0].rows
  end
end
