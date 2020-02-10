ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  action_item :lang, only: [:index] do
    link_to t(:lang_switch), admin_dashboard_lang_path, method: :patch
  end

  page_action :lang, method: :patch do
    if current_admin_user.locale == 'ru'
      current_admin_user.update(locale: 'en')
    else
      current_admin_user.update(locale: 'ru')
    end

    redirect_to admin_root_path(locale: current_admin_user.locale)
  end

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end
  end
end
