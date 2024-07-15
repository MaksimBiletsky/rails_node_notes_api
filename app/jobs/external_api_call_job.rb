class ExternalApiCallJob
  @queue = :external_api_call

  def self.perform
    ExternalApiNotesCreator.call
  end
end