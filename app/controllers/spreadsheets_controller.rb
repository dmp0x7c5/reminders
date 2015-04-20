class SpreadsheetsController < ApplicationController
  expose(:spreadsheets_repository) do
    SpreadsheetsRepository.new session[:google_token]
  end
  expose(:spreadsheets) do
    SpreadsheetDecorator.decorate_collection spreadsheets_repository.all
  end
  expose(:spreadsheet) do
    SpreadsheetDecorator.decorate spreadsheets_repository.find(params[:id])
  end
end
