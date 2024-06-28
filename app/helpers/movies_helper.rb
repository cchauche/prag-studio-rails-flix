module MoviesHelper
  def total_gross(movie)
    movie.flop? ? "Flop!" : number_to_currency(movie.total_gross, precision: 0)
  end

  def year_of(movie)
    movie.released_on.year
  end

  def average_stars(movie)
    if movie.average_stars.zero?
      content_tag(:strong, "No reviews")
    else
      pluralize(movie.average_stars, "star")
    end
  end

  def nav_link_to(label, path)
    if current_page?(path)
      link_to(label, path, class: "active")
    else
      link_to(label, path)
    end
  end

  def main_image(movie)
    if movie.main_image.attached?
      image_tag(movie.main_image)
    else
      image_tag("placeholder.png")
    end
  end
end
