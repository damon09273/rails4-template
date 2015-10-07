module HtmlMatchers
  def response_meta(matchers_hash)
    match_meta = {}
    matchers_hash.each |k, v|
      case k
      when "title"
        match_meta[k] = response_meta_title.to_s.match(v).present?
      else
        match_meta[k] = attr_meta_tag[k].present? ? (response_meta_tags(attr_meta_tag[k]).to_s.match(v).present?) : nil
      end
    end
    match_meta
  end

  def attr_meta_tag
    {
      description: /name="description"/,
      image: /name="image"/,
      og_site_name: /property="og:site_name"/,
      og_title: /property="og:title"/,
      og_description: /property="og:description"/,
      og_url: /property="og:url"/,
      og_type: /property="og:type"/,
      og_image: /property="og:image"/,
    }
  end

  def response_meta_tags(meta_attr)
    response.body.scan(/<meta (.*?)>/).select { |m| m[0].scan(meta_attr).present? }[0][0].scan(/content="(.*?)"/)[0][0] rescue nil
  end

  def response_meta_title
    response.body.scan(/<title>(.+)<\/title>/)[0][0] rescue ""
  end

  def response_meta_desc
    response.body.scan(/<meta content="(.*?)" name="description" \/>/)[0][0] rescue ""
  end

  def response_meta_canonical
    response.body.scan(/<link href="(.+?)" rel="canonical" \/>/)[0][0] rescue ""
  end

  def response_flash_message(klass = nil)
    response.body.scan(/(<div class=\"alert fade in alert-#{klass}\">)/)[0][0] rescue ""
  end
end
