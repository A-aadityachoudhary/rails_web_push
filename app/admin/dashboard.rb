# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    stats = DashboardStat.first_or_create!

    # Global Component Styles Injection
    div style: "margin: -10px -20px 0 -20px; padding: 24px; background-color: #f8fafc; min-height: 85vh; font-family: system-ui, -apple-system, sans-serif;" do
      
      # Step 1: Analytical Metric KPI Cards Grid
      div style: "display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; margin-bottom: 28px;" do
        
        # Metric Card 1: Total Platform Users
        div style: "background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 24px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);" do
          div style: "display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;" do
            span "Total Subscribers", style: "font-size: 14px; font-weight: 600; color: #64748b;"
            span "📊", style: "font-size: 20px;"
          end
          div stats.subscriber_count, style: "font-size: 32px; font-weight: 800; color: #0f172a;"
        end

        # Metric Card 2: Chrome Platform Users
        div style: "background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 24px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);" do
          div style: "display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;" do
            span "Chrome Subscribers", style: "font-size: 14px; font-weight: 600; color: #64748b;"
            span "🌐", style: "font-size: 20px;"
          end
          div PushSubscription.where(browser: "Chrome").count, style: "font-size: 32px; font-weight: 800; color: #0f172a;"
        end

        # Metric Card 3: Firefox Platform Users
        div style: "background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 24px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);" do
          div style: "display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;" do
            span "Firefox Subscribers", style: "font-size: 14px; font-weight: 600; color: #64748b;"
            span "🔥", style: "font-size: 20px;"
          end
          div PushSubscription.where(browser: "Firefox").count, style: "font-size: 32px; font-weight: 800; color: #0f172a;"
        end

        # Metric Card 4: Safari Platform Users
        div style: "background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 24px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);" do
          div style: "display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;" do
            span "Safari Subscribers", style: "font-size: 14px; font-weight: 600; color: #64748b;"
            span "🧭", style: "font-size: 20px;"
          end
          div PushSubscription.where(browser: "Safari").count, style: "font-size: 32px; font-weight: 800; color: #0f172a;"
        end

      end

      # Step 2: Main Filter and Action Panel Container
      div style: "background: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 24px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);" do
        
        # Section Header
        div style: "margin-bottom: 20px;" do
          h3 "Quick Filter Navigation", style: "font-size: 16px; font-weight: 700; color: #1e293b; margin: 0 0 4px 0;"
          p "Instantly jump to pre-filtered subscriber directories by engine type.", style: "font-size: 13px; color: #64748b; margin: 0;"
        end

        # FIXED Ribbon Box: Every button is wrapped in its own 'div' to prevent render overwrites
        div style: "display: flex; flex-wrap: wrap; gap: 12px; border-bottom: 1px solid #f1f5f9; padding-bottom: 24px; margin-bottom: 20px;" do
          
          div do
            link_to(
              "🟢 Chrome (#{PushSubscription.where(browser: 'Chrome').count})",
              admin_push_subscriptions_path(q: { browser_eq: "Chrome" }),
              class: "button",
              style: "background: #ffffff; border: 1px solid #cbd5e1; color: #334155; padding: 10px 20px; border-radius: 8px; font-weight: 600; text-decoration: none; font-size: 13px; box-shadow: 0 1px 2px rgba(0,0,0,0.05); display: inline-block;"
            )
          end

          div do
            link_to(
              "🟠 Firefox (#{PushSubscription.where(browser: 'Firefox').count})",
              admin_push_subscriptions_path(q: { browser_eq: "Firefox" }),
              class: "button",
              style: "background: #ffffff; border: 1px solid #cbd5e1; color: #334155; padding: 10px 20px; border-radius: 8px; font-weight: 600; text-decoration: none; font-size: 13px; box-shadow: 0 1px 2px rgba(0,0,0,0.05); display: inline-block;"
            )
          end

          div do
            link_to(
              "🔵 Safari (#{PushSubscription.where(browser: 'Safari').count})",
              admin_push_subscriptions_path(q: { browser_eq: "Safari" }),
              class: "button",
              style: "background: #ffffff; border: 1px solid #cbd5e1; color: #334155; padding: 10px 20px; border-radius: 8px; font-weight: 600; text-decoration: none; font-size: 13px; box-shadow: 0 1px 2px rgba(0,0,0,0.05); display: inline-block;"
            )
          end

        end

        # Primary Campaign Automation Hub Link (Recurring Button)
        div style: "display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; gap: 16px;" do
          div style: "flex: 1; min-width: 250px;" do
            span "Campaign Engine", style: "font-size: 14px; font-weight: 700; color: #1e293b; display: block; margin-bottom: 2px;"
            span "Manage, sequence, and verify automated subscription dispatch cycles.", style: "font-size: 12px; color: #64748b;"
          end

          div do
            link_to(
              "Manage Recurring Notifications →",
              admin_recurrings_path,
              class: "button",
              style: "background-color: #2563eb; color: #ffffff; border: none; padding: 12px 24px; border-radius: 8px; font-weight: 600; text-decoration: none; font-size: 13px; box-shadow: 0 4px 6px -1px rgba(37,99,235,0.2); display: inline-block;"
            )    
          end
        end

      end
    end
  end
end
