class StandsController < ApplicationController
  before_action :set_stand, only: [:add_fav, :remove_fav]

  # GET /stands
  # GET /stands.json
  def index
    stands = Stand.includes(:tags)
    stands = stands.select_by_tag(params[:tag]) if params[:tag]
    ids = stands.ids.uniq

    # favされたstands
    @fav_ids = get_redis_val&.select {|id| ids&.include?(id.to_i) }
    fav_stands = Stand.includes(:tags).where(id: @fav_ids).order(:order, :id)

    # それ以外のstands
    ids = ids.delete_if { |id| @fav_ids&.include?(id.to_s) }
    stands = Stand.includes(:tags).where(id: ids).order(:order, :id)

    @stands = fav_stands + stands
  end

  def add_fav
    ids = get_redis_val || []
    ids << params[:id]
    set_redis_val(ids)
    redirect_to stands_url
  end

  def remove_fav
    ids = get_redis_val.dup
    ids.delete(@stand.id.to_s)
    set_redis_val(ids)
    redirect_to stands_url
  end

  # GET /stands/1
  # GET /stands/1.json
  def show
  end

  # GET /stands/new
  def new
    @stand = Stand.new
  end

  # GET /stands/1/edit
  def edit
  end

  # POST /stands
  # POST /stands.json
  def create
    @stand = Stand.new(stand_params)

    respond_to do |format|
      if @stand.save
        format.html { redirect_to @stand, notice: 'Stand was successfully created.' }
        format.json { render :show, status: :created, location: @stand }
      else
        format.html { render :new }
        format.json { render json: @stand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stands/1
  # PATCH/PUT /stands/1.json
  def update
    respond_to do |format|
      if @stand.update(stand_params)
        format.html { redirect_to @stand, notice: 'Stand was successfully updated.' }
        format.json { render :show, status: :ok, location: @stand }
      else
        format.html { render :edit }
        format.json { render json: @stand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stands/1
  # DELETE /stands/1.json
  def destroy
    @stand.destroy
    respond_to do |format|
      format.html { redirect_to stands_url, notice: 'Stand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_stand
    @stand = Stand.find(params[:id])
  end

  def redis_key
    "fav/#{session.id}"
  end

  def get_redis_val
    value = REDIS.get redis_key
    value.split(',') if value
  end

  def set_redis_val(ids)
    REDIS.set redis_key, ids.join(',')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def stand_params
    params.require(:stand).permit(:area, :name, :description)
  end
end
