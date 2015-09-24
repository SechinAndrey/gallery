class PostEventsController < ApplicationController
 def index
   @post_events = PostEvent.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
 end
end