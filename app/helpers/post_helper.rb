module PostHelper

  def show_content(content, post)
    truncate(content, length: 250, separator: ' ', omission: '') { link_to  ' more...',  post_path(post.id) }
  end

  def content_analysis(post)
     @img_arr = Array.new
     @text_arr = ""

     sub_img_arr = Array.new
     content_arr = post.content.split(" ")

     content_arr.each do |tmp|
       if tmp.match('https?:\/\/[\S]+')
         sub_img_arr.push(tmp)
       else
         @text_arr += " " + tmp
       end
       if sub_img_arr.length == 2 || content_arr.last == tmp
         @img_arr.push(Array.new(sub_img_arr))
         sub_img_arr.clear
       end
     end
  end
end