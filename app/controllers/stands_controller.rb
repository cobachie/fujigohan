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
    redirect_to stands_url(tag: params[:tag])
  end

  def remove_fav
    ids = get_redis_val.dup
    ids.delete(@stand.id.to_s)
    set_redis_val(ids)
    redirect_to stands_url(tag: params[:tag])
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
end
