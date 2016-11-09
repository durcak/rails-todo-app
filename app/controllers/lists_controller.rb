class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, :show_completed]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all.sort_by(&:name)
    set_important
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    if @list.update(list_params)
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.tasks.unscoped.where(list_id: @list.id).each(&:destroy)

    @list.destroy
    redirect_to lists_url, notice: 'List was successfully destroyed.'
  end

  def show_completed
    # @tasks = @list.tasks
    @completed_tasks = @list.tasks.unscoped.where(list_id: @list.id).completed.sort_by(&:priority)

    render :show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = List.find(params[:id])
  end

  def set_important
    @important = []
    List.all.each do |list|
      @important.concat list.tasks.important
    end
    @important.sort_by!(&:priority)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def list_params
    params.require(:list).permit(:name, :description)
  end
end
