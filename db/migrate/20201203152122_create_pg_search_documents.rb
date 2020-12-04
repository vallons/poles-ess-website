class CreatePgSearchDocuments < ActiveRecord::Migration[6.0]
  def up
    say_with_time("Creating table for pg_search multisearch") do
      create_table :pg_search_documents do |t|
        t.text :content
        t.belongs_to :searchable, polymorphic: true, index: true
        t.timestamps null: false
      end
    end
    execute 'CREATE EXTENSION IF NOT EXISTS unaccent'
    execute 'CREATE EXTENSION IF NOT EXISTS pg_trgm'
    PgSearch::Multisearch.rebuild(Activity)
    PgSearch::Multisearch.rebuild(BasicPage)
    PgSearch::Multisearch.rebuild(Formation)
    PgSearch::Multisearch.rebuild(KeyNumber)
    PgSearch::Multisearch.rebuild(MainPage)
    PgSearch::Multisearch.rebuild(Post)
    PgSearch::Multisearch.rebuild(Theme)

  end

  def down
    say_with_time("Dropping table for pg_search multisearch") do
      drop_table :pg_search_documents
    end
    execute 'DROP EXTENSION IF EXISTS unaccent'
    execute 'DROP EXTENSION IF EXISTS pg_trgm'
  end
end
