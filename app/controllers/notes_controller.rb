class NotesController < ApplicationController
  # before_action :log_action
  before_action :set_note, only: [:show, :update, :destroy]

  def index
    @notes = Note.all
    render json: @notes
  end

  def show
    render json: @note
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      render json: @note, status: :created
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    head :no_content
  end

  def search
    @notes = Note.where("title LIKE ? OR content LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    render json: @notes
  end

  def import_from_external_service
    response = ExternalApiNotesCreator.call
    if response[:error]
      render json: { error: response[:error] }, status: :unprocessable_entity
    else
      render json: { message: 'Notes imported successfully', notes: response[:notes] }, status: :created
    end
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end