module NavbarHelper
  def nav_li text, path
    active = request.path == path ? "active" : ""
    content_tag :li, link_to(text, path), class: active + " navbar-nav"
  end
end
