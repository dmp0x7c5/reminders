module Projects
  class SyncWithSlackChannels
    attr_accessor :projects_repository, :channels_repository

    def initialize(projects_repository, channels_repository)
      self.projects_repository = projects_repository
      self.channels_repository = channels_repository
    end

    def call
      channels_repository.all.each do |channel_name|
        if projects_repository.find_by_name(channel_name).nil?
          save_project channel_name
        end
      end
    end

    private

    def save_project(name)
      projects_repository.persist Project.new(name: name)
    end
  end
end
