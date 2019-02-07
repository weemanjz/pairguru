require "rails_helper"

describe MovieDataPuller do
  subject(:service) { described_class.new }

  describe "#call" do
    context "when movie data exists" do
      it "returns movies' attributes" do
        expect(service.call("Godfather")).to match("title" => "Godfather",
                                                   "rating" => 9.2,
                                                   "poster" => "/godfather.jpg",
                                                   "plot" => /^The aging patriarch of/)
      end
    end

    context "when movie data does not exist" do
      it "returns empty hash" do
        expect(service.call("Unknown movie")).to eq({})
      end
    end

    context "when empty response body returned" do
      it "returns empty hash" do
        expect(service.call("not/found")).to eq({})
      end
    end
  end
end
