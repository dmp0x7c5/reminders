class SpreadsheetsController < ApplicationController
  expose(:spreadsheets_repository) do
    SpreadsheetsRepository.new session[:google_token]
  end
  expose(:spreadsheets) do
    SpreadsheetDecorator.decorate_collection spreadsheets_repository.all
  end
end
