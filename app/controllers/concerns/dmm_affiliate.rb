module DmmAffiliate
  extend ActiveSupport::Concern

  def idol_dmm_afi(num, sort = "rank", keyword = nil)
    client = set_dmm_client

    client.product(
      site: 'DMM.com',
      service: 'digital',
      floor: 'idol',
      keyword: keyword,
      sort: sort,
      hits: num
    ).result[:items]
  end

  private
    def set_dmm_client
      DMM.new(
        api_id: Rails.application.secrets.dmm_api_id, 
        affiliate_id: Rails.application.secrets.dmm_afi_id
      )
    end
end
