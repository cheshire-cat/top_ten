# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authorize, only: [:index]
  before_action :set_no_cache, only: [:top_ten]

  def index
  end

  def top_ten
    top_ten_resp = CoinMarket.new.top_ten

    @top_ten_table =
      TopTenTableBuilder.new.create_from_top_ten_resp!(top_ten_resp)
  end
end
