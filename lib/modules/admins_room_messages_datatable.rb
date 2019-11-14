class AdminsRoomMessagesDatatable
  delegate :params, :h, :link_to, :number_to_currency, :currency_formated, to: :@view
  include Rails.application.routes.url_helpers # for path
  include ActionView::Helpers::OutputSafetyHelper #for raw
  include ActionView::Helpers::AssetTagHelper #for image_tag

  def initialize(view, wanted_filter = nil)
    @view = view
    if RoomMessage::FILTERS.include? wanted_filter
      @room_messages_relations = RoomMessage.try("#{wanted_filter.underscore.pluralize}").includes(:author, :receiver).references(:author, :receiver)
    else
      @room_messages_relations = RoomMessage.includes(:author, :receiver).references(:author, :receiver)
    end
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @room_messages_relations.count,
      iTotalDisplayRecords: room_messages.total_entries,
      aaData: data
    }
  end

private

  def data
    room_messages.uniq.map do |room_message|
      span_delete = link_to(raw("<i class='fa fa-trash'></i>"), admin_room_message_path(locale: I18n.locale, id: room_message.id), method: :delete, data: {confirm: "Voulez-vous supprimer ce message ?"}, class: "btn btn-icon", id: "delete-room_message-#{room_message.id}", class: "btn btn-sm btn-icon btn-pure btn-default on-default remove-row" )
      span_edit = link_to(raw("<i class='icon wb-edit' aria-hidden='true'></i>"), edit_admin_room_message_path(locale: I18n.locale, id: room_message.id),{:remote => true, class:"btn btn-sm btn-icon btn-pure btn-default on-default edit-row"})
      [
        room_message.created_at.strftime("%d/%m/%Y %H:%M"),
        room_message.try("author").try("full_name"),
        room_message.try("receiver").try("full_name"),
        room_message.message,
        I18n.t(room_message.is_valid.present?),
        I18n.t(room_message.is_catched.present?),
        "<div class=''>#{span_edit} #{span_delete}</div>"
      ]
    end
  end

  def room_messages
    @room_messages ||= fetch_room_messages
  end

  def fetch_room_messages
    room_messages = @room_messages_relations.order("#{sort_column} #{sort_direction}", :id)
    if params[:sSearch].present?
      room_messages = room_messages.where("LOWER(users.firstname ||' '|| users.lastname) like LOWER(:search) OR LOWER(receivers_room_messages.firstname ||' '|| receivers_room_messages.lastname) like LOWER(:search) OR LOWER(room_messages.message) like LOWER(:search)", search: "%#{params[:sSearch]}%")
    end
    room_messages = room_messages.page(page).per_page(per_page)
    room_messages
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[room_messages.created_at users.firstname receivers_room_messages.firstname room_messages.message room_messages.is_valid room_messages.is_catched room_messages.message]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
