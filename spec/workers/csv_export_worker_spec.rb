require 'rails_helper'

RSpec.describe CsvExportWorker, type: :worker do
  subject(:worker) { described_class.new }

  let(:user) { create(:user) }
  let(:exporter) { instance_double(MovieExporter, call: nil) }

  before do
    allow(MovieExporter).to receive(:new).and_return(exporter)
  end

  describe "#perform" do
    it "calls MovieExporter" do
      worker.perform(user.id, "path/to/file.csv")
      expect(exporter).to have_received(:call).with(User, "path/to/file.csv")
    end
  end
end
