# -*- coding: utf-8 -*-
module Concerns
  module Pinyin
    extend ActiveSupport::Concern
    included do
      before_save :name_to_pinyin
      
      private
      def name_to_pinyin
        self.pinyin = HanziToPinyin.hanzi_2_py(self.name)
      end
    end
  end
end
