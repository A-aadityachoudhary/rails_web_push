# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    section "Subscribers By Browser" do

      div do

        para do
          link_to(
            "🟢 Chrome (#{PushSubscription.where(browser: 'Chrome').count})",
            admin_push_subscriptions_path(q: { browser_eq: "Chrome" }),
            class: "button"
          )
        end

        para do
          link_to(
            "🟠 Firefox (#{PushSubscription.where(browser: 'Firefox').count})",
            admin_push_subscriptions_path(q: { browser_eq: "Firefox" }),
            class: "button"
          )
        end

        para do
          link_to(
            "🔵 Safari (#{PushSubscription.where(browser: 'Safari').count})",
            admin_push_subscriptions_path(q: { browser_eq: "Safari" }),
            class: "button"
          )
        end

      end

    end

  end
end