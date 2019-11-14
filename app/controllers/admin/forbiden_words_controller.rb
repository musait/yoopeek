class Admin::ForbidenWordsController <  AdminController
  before_action :set_forbiden_word, only: [:show, :edit, :update, :destroy]

  # GET /forbiden_words
  # GET /forbiden_words.json
  def index
    respond_to do |format|
      format.html {@forbiden_word = ForbidenWord.new}
      format.json { render json: AdminsForbidenWordsDatatable.new(view_context, params[:wanted_filter]) }
    end
  end

  # GET /forbiden_words/1
  # GET /forbiden_words/1.json
  def show
  end

  # GET /forbiden_words/new
  def new
    @forbiden_word = ForbidenWord.new
  end

  # GET /forbiden_words/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /forbiden_words
  # POST /forbiden_words.json
  def create
    @forbiden_word = ForbidenWord.new(forbiden_word_params)
    respond_to do |format|
      if @forbiden_word.save
        format.html { redirect_to admin_forbiden_words_path, notice: 'ForbidenWord was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.json { render json: @forbiden_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forbiden_words/1
  # PATCH/PUT /forbiden_words/1.json
  def update
    respond_to do |format|
      if @forbiden_word.update(forbiden_word_params)
        format.html { redirect_to admin_forbiden_words_path, notice: 'ForbidenWord was successfully updated.' }
        format.json { render :show, status: :ok, location: @forbiden_word }
      else
        format.html { render :edit }
        format.json { render json: @forbiden_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forbiden_words/1
  # DELETE /forbiden_words/1.json
  def destroy
    @forbiden_word.destroy
    respond_to do |format|
      format.html { redirect_to admin_forbiden_words_url, notice: 'ForbidenWord was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forbiden_word
      @forbiden_word = ForbidenWord.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forbiden_word_params
      params.require(:forbiden_word).permit(:word, :is_valid_after_quote_accepted, :is_catched_word)
    end
end
