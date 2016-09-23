module DmmAffiliate
  extend ActiveSupport::Concern

  def global_dmm_afi(num)
    client = set_dmm_client

    client.product(
      site: 'DMM.com',
      service: 'digital',
      floor: 'idol',
      sort: 'rank',
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
