class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    return default_cover unless additional_attributes["poster"]
    "https://pairguru-api.herokuapp.com" +
      additional_attributes["poster"]
  end

  def description
    additional_attributes["plot"] || object.description
  end

  def rating
    additional_attributes["rating"] || "NA"
  end

  private

  def default_cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end

  def additional_attributes
    @additional_attributes ||= MovieDataPuller.new.call(object.title)
  end
end
