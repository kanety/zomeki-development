class PortalCalendar::Admin::StatusesController < Cms::Controller::Admin::Base
  include Sys::Controller::Scaffold::Base
  
  def pre_dispatch
    return error_auth unless @content = Cms::Content.find(params[:content])
#    default_url_options :content => @content
    @parent = 0
  end
  
  def index
    item = PortalCalendar::Status.new#.readable
    item.and :content_id, @content
    item.page  params[:page], params[:limit]
    item.order params[:sort], :sort_no
    @items = item.find(:all)
    _index @items
  end
  
  def show
    @item = PortalCalendar::Status.new.find(params[:id])
    _show @item
  end

  def new
    @item = PortalCalendar::Status.new({
      :state      => 'public',
      :sort_no    => 1
    })
  end
  
  def create
    @item = PortalCalendar::Status.new(params[:item])
    @item.content_id = @content.id
    _create @item
  end
  
  def update
    @item = PortalCalendar::Status.new.find(params[:id])
    @item.attributes = params[:item]
    _update @item
  end
  
  def destroy
    @item = PortalCalendar::Status.new.find(params[:id])
    _destroy @item
  end
end
