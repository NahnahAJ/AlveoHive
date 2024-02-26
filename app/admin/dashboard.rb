# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Welcome Alveo Hive Admin"
        # small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do

      column do
        panel "Properties pending for approval" do
          ul do
            Property.where(is_property_live: false).order(created_at: :desc).map do |property|
              li link_to(property.name, admin_property_path(property))
            end
          end
        end
      end

      column do
    panel "Recent Live Properties" do
      ul do
        Property.where(is_property_live: true).order(created_at: :desc).limit(5).map do |property|
          li link_to(property.name, admin_property_path(property))
        end
      end
    end
  end

  column do
    panel "Recent Premium Subscribers" do
      ul do
        UserDetail.where(subscription: "subscribed").joins(:user).order("users.created_at DESC").limit(5).map do |user_detail|
          li link_to(user_detail.user.username, admin_user_path(user_detail.user))
        end
      end
    end
  end
  

  column do
    panel "Recent Users" do
      ul do
        User.order(created_at: :desc).limit(5).map do |user|
          li link_to(user.firstname + " " + user.lastname, admin_user_path(user))
        end
      end
    end
  end






end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
