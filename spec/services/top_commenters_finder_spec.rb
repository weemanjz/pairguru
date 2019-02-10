require "rails_helper"

describe TopCommentersFinder do
  subject(:service) { described_class.new }

  describe "#call" do
    let(:users) { [] }
    let(:movies) { [] }
    let(:expected_results) do
      [
        { "id" => users[9].id, "name" => users[9].name, "comments_count" => 10 },
        { "id" => users[8].id, "name" => users[8].name, "comments_count" => 9 },
        { "id" => users[7].id, "name" => users[7].name, "comments_count" => 8 },
        { "id" => users[6].id, "name" => users[6].name, "comments_count" => 7 },
        { "id" => users[5].id, "name" => users[5].name, "comments_count" => 6 },
        { "id" => users[4].id, "name" => users[4].name, "comments_count" => 5 },
        { "id" => users[3].id, "name" => users[3].name, "comments_count" => 4 },
        { "id" => users[2].id, "name" => users[2].name, "comments_count" => 3 },
        { "id" => users[1].id, "name" => users[1].name, "comments_count" => 2 },
        { "id" => users[0].id, "name" => users[0].name, "comments_count" => 1 }
      ]
    end

    before do
      11.times do |i|
        user = create(:user)
        users[i] = user
        movies << create(:movie)
        created_at = i == 10 ? (7.days.ago - 1.minute) : Time.current
        movies.each { |m| create(:comment, user: user, movie: m, created_at: created_at) }
      end
    end

    it "returns top 10 commenters in last 7 days" do
      results = service.call(from: 7.days.ago, limit: 10)
      expect(results).to eq(expected_results)
    end
  end
end
