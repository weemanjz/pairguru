require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end

    context "when movie with additional data from API exists" do
      let!(:movie) { create(:movie) }

      it "displays movies' title" do
        visit "/movies"
        expect(page).to have_selector("h4", text: movie.title)
      end

      it "displays movies' plot" do
        visit "/movies"
        expect(page).to have_selector("p", text: "The aging patriarch of")
      end

      it "displays rating" do
        visit "/movies"
        expect(page).to have_selector("small", text: "Rating: 9.2")
      end
    end

    context "when movie without additional data from API exists" do
      let!(:movie) { create(:movie, title: "Unknown movie") }

      it "displays movies' title" do
        visit "/movies"
        expect(page).to have_selector("h4", text: movie.title)
      end

      it "displays movies' description" do
        visit "/movies"
        expect(page).to have_selector("p", text: movie.description)
      end

      it "displays rating Not Available" do
        visit "/movies"
        expect(page).to have_selector("small", text: "Rating: NA")
      end
    end
  end
end
