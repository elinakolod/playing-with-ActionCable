class CreateFaqs < ActiveRecord::Migration[6.0]
  def change
    create_table :faqs do |t|
      t.string :title
      t.text :descr

      t.timestamps
    end
  end
end
