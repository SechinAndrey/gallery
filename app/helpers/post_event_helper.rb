module PostEventHelper
    def post_exist?(id)
      begin
        post = Post.find(id)
      rescue
      end
      post.nil? ? false : true
    end
end