require "rails_helper"

describe "API::V1 Movies show request", type: :request do
  context "when movie exists" do
    let(:movie) { create(:movie) }
    let(:params) { {} }

    before do
      get "/api/v1/movies/#{movie.id}", params: params
    end

    it "succeeds" do
      expect(response).to be_successful
    end

    it "returns movie basic data" do
      expect(response.parsed_body).to eq("movie" => { "id" => movie.id, "title" => movie.title })
    end

    context "when with_genre option set to true" do
      let(:genre) { movie.genre }
      let(:params) { { with_genre: true } }
      let(:expected_result) do
        {
          "movie" => {
            "id" => movie.id,
            "title" => movie.title,
            "genre" => {
              "id" => genre.id,
              "name" => genre.name,
              "movies_count" => genre.movies_count
            }
          }
        }
      end

      it "returns movie and genre data" do
        expect(response.parsed_body).to eq(expected_result)
      end
    end
  end

  context "when movie does not exist" do
    before do
      get "/api/v1/movies/not_found"
    end

    it "returns not found" do
      expect(response).to be_not_found
    end

    it "returns error message" do
      expect(response.parsed_body).to eq("message" => "Movie not found")
    end
  end
end
