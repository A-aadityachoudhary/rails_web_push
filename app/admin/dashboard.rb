# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    stats = DashboardStat.first_or_create!

    # Dashboard Cards
    columns do
      column do
        panel "Total Subscribers" do
          div style: "font-size:40px; text-align:center; font-weight:bold; padding:20px;" do
            stats.subscriber_count
          end
        end
      end

      column do
        panel "Chrome Subscribers" do
          div style: "font-size:40px; text-align:center; font-weight:bold; padding:20px;" do
            PushSubscription.where(browser: "Chrome").count
          end
        end
      end

      column do
        panel "Firefox Subscribers" do
          div style: "font-size:40px; text-align:center; font-weight:bold; padding:20px;" do
            PushSubscription.where(browser: "Firefox").count
          end
        end
      end

      column do
        panel "Safari Subscribers" do
          div style: "font-size:40px; text-align:center; font-weight:bold; padding:20px;" do
            PushSubscription.where(browser: "Safari").count
          end
        end
      end
    end

    hr

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