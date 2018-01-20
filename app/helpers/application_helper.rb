module ApplicationHelper
  def markdown(text)
    options = {hard_wrap: true, prettify: true}
    extensions = {
      autolink: true,
      superscript: true
    }
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
