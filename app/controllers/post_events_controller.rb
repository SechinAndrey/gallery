class PostEventsController < ApplicationController
 def index
   @post_events =  Kaminari.paginate_array(PostEvent.order('created_at DESC')).page(params[:page]).per(20)  #PostEvent.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
 end
end