require 'rails_helper'

RSpec.describe MovieInfoSender, type: :worker do
  subject(:worker) { described_class.new }

  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:mailer) { double(deliver_now: nil) }

  before do
    allow(MovieInfoMailer).to receive(:send_info).and_return(mailer).with(User, Movie)
  end

  describe "#perform" do
    it "calls MovieExporter" do
      worker.perform(user.id, movie.id)
      expect(mailer).to have_received(:deliver_now)
    end
  end
end
