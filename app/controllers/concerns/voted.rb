module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:vote_up, :cancel_vote, :vote_down]
    respond_to :json, :html, :js
  end

  def vote_up
    vote('up')
  end

  def vote_down
    vote('down')
  end

  def cancel_vote
    @votable.cancel_vote(current_user) if @votable.already_voted?(current_user)
    success_respond
  end

  private

  def set_votable
    klass = controller_name.classify.constantize
    @votable = klass.find(params[:id])
  end

  def vote(direction)
    return already_voted_respond if @votable.already_voted?(current_user)
    return author_vote_respond if current_user.author_of?(@votable)
    @votable.vote(current_user, direction)
    success_respond
  end

  def already_voted_respond
    error_respond('You can vote only once')
  end

  def success_respond
    json_respond(@votable.rating)
  end

  def author_vote_respond
    error_respond("Author can't vote")
  end

  def json_respond(object, status = 200)
    render json: { id: @votable.id, object: object, controller: controller_name.singularize }, status: status
  end

  def error_respond(message)
    json_respond(message, 403)
  end
end
