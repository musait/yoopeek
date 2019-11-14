class Admin::RoomMessagesController <  AdminController
  before_action :set_room_message, only: [:show, :edit, :update, :destroy]

  # GET /room_messages
  # GET /room_messages.json
  def index
    @room_messages = RoomMessage.order(:created_at).all
    @room_message = RoomMessage.new
  end

  # GET /room_messages/1
  # GET /room_messages/1.json
  def show
  end

  # GET /room_messages/new
  def new
    @room_message = RoomMessage.new
  end

  # GET /room_messages/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /room_messages
  # POST /room_messages.json
  def create
    @room_message = RoomMessage.new(room_message_params)
    respond_to do |format|
      if @room_message.save
        format.html { redirect_to admin_room_messages_path, notice: 'RoomMessage was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.json { render json: @room_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_messages/1
  # PATCH/PUT /room_messages/1.json
  def update
    respond_to do |format|
      if @room_message.update(room_message_params)
        format.html { redirect_to admin_room_messages_path, notice: 'RoomMessage was successfully updated.' }
        format.json { render :show, status: :ok, location: @room_message }
      else
        format.html { render :edit }
        format.json { render json: @room_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_messages/1
  # DELETE /room_messages/1.json
  def destroy
    @room_message.destroy
    respond_to do |format|
      format.html { redirect_to admin_room_messages_url, notice: 'RoomMessage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_message
      @room_message = RoomMessage.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_message_params
      params.require(:room_message).permit(:is_valid, :unvalid_reason)
    end
end
