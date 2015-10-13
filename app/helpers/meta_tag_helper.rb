module MetaTagHelper

  # 包含 namespace 判斷
  # EX1: PostsController#press => meta_for_posts_press
  # EX2: Admin::FlagsController#show => meta_for_admin_flags_show
  def render *args
    set_meta(send(use_method_name)) if respond_to?(use_method_name)
    super
  end

  # 使用的 method_name 組合結構
  def use_method_name
    "meta_for_#{controller_path.underscore.gsub(/\//, '_')}_#{action_name}"
  end

  # =======================
  # meta結構
  def default_meta_makeup
    {
      title: nil,
      description: nil,
      keywords: nil,
      site: nil,
      og: {
        title: nil,
        description: nil,
        url: nil,
        type: nil,
        image: nil,
      },
      fb: {
        app_id: nil,
        admins: nil,
      },
      separator: " | ",
      reverse: true,
      url: nil,
    }
  end

  # 預設值控制
  def set_meta(data = {})
    meta = {}
    meta[:url] ||= url_for(params.merge(:host => Setting.host))
    meta[:title] ||= data.fetch(:title, page_title_use)
    meta[:og] = {}
    meta[:og][:url] ||= data.fetch(:og_url, "")
    meta[:og][:title] ||= data.fetch(:og_title, "")
    meta[:og][:description] ||= data.fetch(:og_description, "")
    meta[:og][:image] ||= data.fetch(:og_image, "")

    set_meta_tags default_meta_makeup.deep_merge(meta)
  end

  # =======================
  # asset_path for image
  def asset_img(img, use_SSL = nil)
    prefix = use_SSL.nil? ? request.scheme.to_s : use_SSL.present? ? "https" : "http"
    prefix + ":" + ActionController::Base.helpers.asset_path(img)
  end

  # =======================
  # 使用 I18n 的 title 設定
  def page_title_use
    I18n.t "title.#{controller_path.underscore.gsub(/\//, '.')}.#{action_name}", { :default => :"title.default" }
  end

  # =======================
  # 沒設定的頁面用這個 & 基礎資料
  def meta_for_default
    {
      og_description: "aaaaa",
      og_image: "",
    }
  end

  def meta_for_base_index
    meta_for_default
  end

end
