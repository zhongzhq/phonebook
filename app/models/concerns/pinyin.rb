# -*- coding: utf-8 -*-
require 'hanzi_to_pinyin'

module Concerns
  module Pinyin
    extend ActiveSupport::Concern
    included do
      before_save :name_to_pinyin
      
      private
      def name_to_pinyin
        self.pinyin = HanziToPinyin.hanzi_2_py(self.name).join
      end
    end
  end
end
