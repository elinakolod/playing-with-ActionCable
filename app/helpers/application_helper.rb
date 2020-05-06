module ApplicationHelper
  def online_status(user)
    content_tag :span, user.name,
                id: "user-#{user.id}",
                class: "online_status #{'online' if user.online?}"
  end
end
