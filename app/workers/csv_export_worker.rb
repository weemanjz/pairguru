class CsvExportWorker
  include Sidekiq::Worker

  def perform(user_id, path)
    user = User.find(user_id)
    MovieExporter.new.call(user, path)
  end
end
