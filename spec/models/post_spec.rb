require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "scopes" do
    let!(:cat1)   { create(:post_category, position: 1) }
    let!(:cat2)   { create(:post_category, position: 2) }
    let!(:theme1) { create(:theme) }
    let!(:theme2) { create(:theme) }

    let!(:published_post_1) {
      create(:post, post_category_id: cat1.id, published_at: Time.zone.now)
    }

    let!(:published_post_2) {
      create(:post, post_category_id: cat2.id, published_at: Time.zone.now)
    }

    let!(:draft_post_1) {
      create(:post, post_category_id: cat1.id, published_at: Time.zone.now+10.days)
    }

    let!(:expired_post_1) {
      create(:post, post_category_id: cat1.id, published_at: Time.zone.now-10.days, expired_at: Time.zone.now-1.day)
    }

    before do
      published_post_1.themes.push(theme1)
      published_post_2.themes.push(theme2)
      expired_post_1.themes.push(theme2)
    end

    context "published" do
      it "returns posts published" do
        posts = Post.published
        expect(posts.count).to eq(2)
      end
    end

    context "published by theme" do
      it "returns posts published by theme" do
        posts = Post.published.by_theme(theme2)
        expect(posts.count).to eq(1)
        expect(posts.first).to eq(published_post_2)
      end
    end

    context "published by category" do
      it "returns posts published by category" do
        posts = Post.published.by_post_category(cat1)
        expect(posts.count).to eq(1)
        expect(posts.first).to eq(published_post_1)
      end
    end

  end

end
