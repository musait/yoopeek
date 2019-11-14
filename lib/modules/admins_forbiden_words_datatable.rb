class AdminsForbidenWordsDatatable
  delegate :params, :h, :link_to, :number_to_currency, :currency_formated, to: :@view
  include Rails.application.routes.url_helpers # for path
  include ActionView::Helpers::OutputSafetyHelper #for raw
  include ActionView::Helpers::AssetTagHelper #for image_tag

  def initialize(view, wanted_filter = nil)
    @view = view
    @forbiden_words_relations = ForbidenWord
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @forbiden_words_relations.count,
      iTotalDisplayRecords: forbiden_words.total_entries,
      aaData: data
    }
  end

private

  def data
    forbiden_words.uniq.map do |forbiden_word|
      span_delete = link_to(raw("<i class='fa fa-trash'></i>"), admin_forbiden_word_path(locale: I18n.locale, id: forbiden_word.id), method: :delete, data: {confirm: "Voulez-vous supprimer ce message ?"}, class: "btn btn-icon", id: "delete-forbiden_word-#{forbiden_word.id}", class: "btn btn-sm btn-icon btn-pure btn-default on-default remove-row" )
      span_edit = link_to(raw("<i class='icon wb-edit' aria-hidden='true'></i>"), edit_admin_forbiden_word_path(locale: I18n.locale, id: forbiden_word.id),{:remote => true, class:"btn btn-sm btn-icon btn-pure btn-default on-default edit-row"})
      [
        forbiden_word.created_at.strftime("%d/%m/%Y %H:%M"),
        forbiden_word.word,
        I18n.t(forbiden_word.is_valid_after_quote_accepted.present?),
        I18n.t(forbiden_word.is_catched_word.present?),
        "<div class=''>#{span_edit} #{span_delete}</div>"
      ]
    end
  end

  def forbiden_words
    @forbiden_words ||= fetch_forbiden_words
  end

  def fetch_forbiden_words
    forbiden_words = @forbiden_words_relations.order("#{sort_column} #{sort_direction}", :id)
    if params[:sSearch].present?
      forbiden_words = forbiden_words.where("LOWER(forbiden_words.word) like LOWER(:search)", search: "%#{params[:sSearch]}%")
    end
    forbiden_words = forbiden_words.page(page).per_page(per_page)
    forbiden_words
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[forbiden_words.created_at forbiden_words.word forbiden_words.is_valid_after_quote_accepted forbiden_words.is_catched_word forbiden_words.is_catched_word]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
