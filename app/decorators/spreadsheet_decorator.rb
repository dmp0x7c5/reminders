class SpreadsheetDecorator < Draper::Decorator
  delegate :title, :id, :human_url
end
