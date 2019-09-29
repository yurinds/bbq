# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_photo, only: [:destroy]

  def create
    @new_photo = @event.photos.build(photo_params)

    @new_photo.user = current_user

    if @new_photo.save
      notify_subscribers(@event, @new_photo)

      redirect_to @event, notice: I18n.t('.photos.created')
    else
      render 'events/show', alert: I18n.t('.photos.error')
    end
  end

  def destroy
    message = { notice: I18n.t('.photos.destroyed') }

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = { alert: I18n.t('.photos.error') }
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end

  def notify_subscribers(event, photo)
    emails = (event.subscribers.map(&:email) + [event.user.email] - [photo.user.email]).uniq

    emails.each do |mail|
      SendEmailPhotoJob.set(wait: 10.seconds).perform_later(event, photo, mail)
    end
  end
end
