require "rails_helper"

describe "API::V1 Movies list request", type: :request do
  context "when format is json" do
    let!(:movies) { create_list(:movie, 2) }
    let(:params) { {} }

    before do
      get "/api/v1/movies", params: params
    end

    it "succeeds" do
      expect(response).to be_successful
    end

    it "returns movies basic data" do
      expect(response.parsed_body)
        .to eq("movies" => [{ "id" => movies[0].id, "title" => movies[0].title },
                            { "id" => movies[1].id, "title" => movies[1].title }])
    end

    context "when with_genre option set to true" do
      let(:params) { { with_genre: true } }
      let(:expected_result) do
        {
          "movies" => [
            {
              "id" => movies[0].id,
              "title" => movies[0].title,
              "genre" => {
                "id" => movies[0].genre.id,
                "name" => movies[0].genre.name,
                "movies_count" => movies[0].genre.movies_count
              }
            },
            {
              "id" => movies[1].id,
              "title" => movies[1].title,
              "genre" => {
                "id" => movies[1].genre.id,
                "name" => movies[1].genre.name,
                "movies_count" => movies[1].genre.movies_count
              }
            }
          ]
        }
      end

      it "returns movie and genre data" do
        expect(response.parsed_body).to eq(expected_result)
      end
    end
  end

  context "when it is not json request" do
    it "returns" do
      get "/api/v1/movies.html"
      expect(response.status).to eq(406)
    end
  end
end
