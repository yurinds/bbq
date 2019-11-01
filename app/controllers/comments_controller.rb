# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_comment, only: [:destroy]

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      CommentNotifySubscribersJob.perform_later(@event, @new_comment, current_user)

      redirect_to @event, notice: I18n.t('.comments.created')
    else
      render 'events/show', alert: I18n.t('.comments.error')
    end
  end

  def destroy
    message = { notice: I18n.t('.comments.destroyed') }

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = { alert: I18n.t('.comments.error') }
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end
end
