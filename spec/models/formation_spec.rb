require 'rails_helper'

RSpec.describe Formation, type: :model do

  describe "ordering scopes" do
    let!(:cat1) { create(:formation_category, position: 2) }
    let!(:cat2) { create(:formation_category, position: 1) }
    let!(:ref_date) { Time.zone.now }

    let!(:formation_cat1_2) {
      Formation.create(title: "1", formation_category_id: cat1.id, schedules_attributes: 
        [{ time_range: (ref_date+1.month..ref_date+1.month+2.hours) }])
    }

    let!(:formation_cat1_last_year) {
      Formation.create(title: "Last year", formation_category_id: cat1.id, schedules_attributes: 
        [{ time_range: (ref_date-1.year..ref_date-1.year+2.hours) }])
    }

    let!(:formation_cat1_3) {
      Formation.create(title: "3", formation_category_id: cat1.id, schedules_attributes: 
        [{ time_range: (ref_date+2.month..ref_date+2.month+2.hours) }])
    }

    let!(:formation_cat1_1) {
      Formation.create(title: "1", formation_category_id: cat1.id, schedules_attributes: 
        [{ time_range: (ref_date+1.week..ref_date+1.week+2.hours) }])
    }

    let!(:formation_cat2_1) {
      Formation.create(title: "cat2", formation_category_id: cat2.id, schedules_attributes: 
        [{ time_range: (ref_date+2.week..ref_date+2.week+2.hours) }])
    }

    context "sort_by_start_date" do
      it "returns formations in correct order" do
        formations = Formation.all.sort_by_start_date
        expect(formations.count).to eq(5)
        expect(formations.first).to eq(formation_cat1_last_year)
        expect(formations.last).to eq(formation_cat1_3)
      end
    end

    context "sort_by_future" do
      it "returns formations in correct order" do
        formations = Formation.all.sort_by_future
        expect(formations.count).to eq(4)
      end
    end

    context "sort_by_future & sort_by_start_date" do
      it "returns formations in correct order" do
        formations = Formation.all.sort_by_future.sort_by_start_date
        expect(formations.count).to eq(4)
        expect(formations.first).to eq(formation_cat1_1)
        expect(formations.last).to eq(formation_cat1_3)
      end
    end

    context "sort_by_formation_category" do
      it "returns formations in correct order" do
        formations = Formation.all.sort_by_formation_category.map{|cat, f| f}.flatten
        expect(formations.count).to eq(5)
        expect(formations.first).to eq(formation_cat2_1)
        expect(formations.second).to eq(formation_cat1_last_year)
        expect(formations.last).to eq(formation_cat1_3)
      end
    end

  end

  describe "in_most_recent_year" do
    let!(:cat1) { create(:formation_category, position: 2) }
    let!(:cat2) { create(:formation_category, position: 1) }
    let!(:ref_date) { Time.zone.now.beginning_of_year }

    let!(:formation_cat1_2) {
      Formation.create(title: "1", formation_category_id: cat1.id, schedules_attributes: 
        [{ time_range: (ref_date+1.month..ref_date+1.month+2.hours) }])
    }

    let!(:formation_cat1_last_year) {
      Formation.create(title: "Last year", formation_category_id: cat1.id, schedules_attributes: 
        [{ time_range: (ref_date-1.year..ref_date-1.year+2.hours) }])
    }

    let!(:formation_cat1_1) {
      Formation.create(title: "1", formation_category_id: cat1.id, schedules_attributes: 
        [{ time_range: (ref_date+1.week..ref_date+1.week+2.hours) }])
    }

    context "in_most_recent_year" do
      it "returns only 2020 formations" do
        formations = Formation.all.in_most_recent_year
        expect(formations.count).to eq(2)
        expect(formations).not_to include(formation_cat1_last_year)
      end
    end
  end
end
