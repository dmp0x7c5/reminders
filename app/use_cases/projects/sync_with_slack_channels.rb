module Projects
  class SyncWithSlackChannels
    attr_accessor :projects_repository, :channels_repository

    def initialize(projects_repository, channels_repository)
      self.projects_repository = projects_repository
      self.channels_repository = channels_repository
    end

    def call
      channels_repository.all_project_channels.each do |channel|
        channel_name = channel.name
        project_name = channel_name.sub("project-", "")
        if projects_repository.find_by_name(project_name).nil?
          save_project project_name, channel_name
        end
      end
    end

    private

    def save_project(name, channel_name)
      projects_repository.persist Project.new(name: name,
                                              channel_name: channel_name,
                                              email: prepare_email(name))
    end

    def prepare_email(name)
      "#{name.downcase}-team@#{AppConfig.domain}"
    end
  end
end
