class QuoteElementsController < ApplicationController
  before_action :set_quote_element, only: [:show, :edit, :update, :destroy]

  # GET /quote_elements
  # GET /quote_elements.json
  def index
    @quote_elements = QuoteElement.all
  end

  # GET /quote_elements/1
  # GET /quote_elements/1.json
  def show
  end

  # GET /quote_elements/new
  def new
    @quote_element = QuoteElement.new
  end

  # GET /quote_elements/1/edit
  def edit
  end

  # POST /quote_elements
  # POST /quote_elements.json
  def create
    @quote_element = QuoteElement.new(quote_element_params)

    respond_to do |format|
      if @quote_element.save
        format.html { redirect_to @quote_element, notice: 'Quote element was successfully created.' }
        format.json { render :show, status: :created, location: @quote_element }
      else
        format.html { render :new }
        format.json { render json: @quote_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quote_elements/1
  # PATCH/PUT /quote_elements/1.json
  def update
    respond_to do |format|
      if @quote_element.update(quote_element_params)
        format.html { redirect_to @quote_element, notice: 'Quote element was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote_element }
      else
        format.html { render :edit }
        format.json { render json: @quote_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quote_elements/1
  # DELETE /quote_elements/1.json
  def destroy
    @quote_element.destroy
    respond_to do |format|
      format.html { redirect_to quote_elements_url, notice: 'Quote element was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote_element
      @quote_element = QuoteElement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_element_params
      params.require(:quote_element).permit(:content, :quantity, :price, :total)
    end
end
