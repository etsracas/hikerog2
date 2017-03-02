class YamalogsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @yamalogs = Yamalog.search(params[:search])
  end

  def show
    @yamalog = Yamalog.find(params[:id])
  end

  def new
    #インスタンス変数にからのオブジェクトを入れておく。
    @yamalog = current_user.yamalogs.build
  end

  def create
    @yamalog = current_user.yamalogs.new(yamalog_params)
    if @yamalog.save
      redirect_to @yamalog, notice: 'はいくログを投稿しました'
    else
      render :new
    end
  end

  def edit
    @yamalog = current_user.yamalogs.find(params[:id])
    @yamalog.yamalog_pics.build
  end

  def update
    @yamalog = current_user.yamalogs.find(params[:id])
    if @yamalog.update(yamalog_params)
      redirect_to @yamalog, notice: 'はいくログを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @yamalog = current_user.yamalogs.find(params[:id])
    @yamalog.destroy!
    redirect_to root_path, notice: 'はいくログを削除しました'
  end

  private

  def yamalog_params
    params.require(:yamalog).permit(
      :yama_date, :yama_name, :weather, :member, :route, :gpslog, :yamalog_pic1
    )
  end
end
