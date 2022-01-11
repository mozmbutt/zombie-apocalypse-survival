# frozen_string_literal: true

module ApplicationHelper
  # show image of user or placeholder image instead
  def show_image_if_present(resource)
    if resource.photo.record.photo.present?
      img = resource.photo
      image_tag img
    else
      image_tag image_path('no-image-found.jpg')
    end
  end
end
