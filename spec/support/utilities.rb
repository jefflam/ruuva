def full_title(page_title)
  base_title = "Socializing and simplifying online shopping - Ruuva"
  if page_title.empty?
    base_title
  else
    "#{page_title}"
  end
end