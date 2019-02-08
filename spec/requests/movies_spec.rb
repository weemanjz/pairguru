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

  describe "movies export" do
    context "when user is signed in" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "displays success message" do
        visit "movies/export"
        expect(page).to have_selector("div", text: "Movies exported")
      end

      it "adds a job to queue with correct arguments" do
        visit "movies/export"
        expect(CsvExportWorker.jobs.size).to eq(1)
        expect(CsvExportWorker.jobs.first["args"]).to eq([user.id, "tmp/movies.csv"])
      end
    end

    context "when user is not signed in" do
      it "redirects to login page" do
        visit "movies/export"
        expect(page).to have_selector("div",
                                      text: "You need to sign in or sign up before continuing.")
      end
    end
  end

  describe "sending movie info" do
    let(:movie) { create(:movie) }

    context "when user is signed in" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "displays success message" do
        visit send_info_movie_path(id: movie.id)
        expect(page).to have_selector("div", text: "Email sent with movie info")
      end

      it "adds a job to queue with correct arguments" do
        visit send_info_movie_path(id: movie.id)
        expect(MovieInfoSender.jobs.size).to eq(1)
        expect(MovieInfoSender.jobs.first["args"]).to eq([user.id, movie.id])
      end
    end

    context "when user is not signed in" do
      it "redirects to login page" do
        visit send_info_movie_path(id: movie.id)
        expect(page).to have_selector("div",
                                      text: "You need to sign in or sign up before continuing.")
      end
    end
  end
end
