module PostHelper

  def show_content(post)
    truncate(post.content, length: 250, separator: ' ', omission: '') { link_to  ' more...',  post_path(post.id) }
  end
end