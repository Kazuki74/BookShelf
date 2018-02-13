module SearchBook
  extend ActiveSupport::Concern
  included do
    scope :search_title, lambda { |keyword|
      table = Book.arel_table
      condition = table[:title].matches("%#{keyword}%")
      where(condition)
    }

    scope :search_category, lambda { |category_id|
      table = Category.arel_table
      condition = table[:id].eq(category_id)
      where(condition)
    }

    scope :search, lambda { |s|
      r = self
      r = r.search_title(s[:title]) if s[:title].present?
      r = r.joins(:categories).search_category(s[:category]) if s[:category].present?
      return r if r != self
      where({})
    }
  end
end