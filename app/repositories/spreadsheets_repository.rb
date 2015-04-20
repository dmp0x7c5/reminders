class SpreadsheetsRepository
  attr_accessor :google_session

  def initialize(access_token)
    init_google_session access_token
  end

  def all
    @all ||= google_session.spreadsheets.sort_by(&:title)
  end

  def find(id)
    google_session.file_by_id id
  end

  private

  def init_google_session(access_token)
    self.google_session ||= GoogleDrive.login_with_oauth(access_token)
  end
end
