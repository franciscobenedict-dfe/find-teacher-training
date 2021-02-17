require 'rails_helper'

RSpec.feature 'Results page new SEND filter' do
  include StubbedRequests::Courses
  include StubbedRequests::Subjects

  let(:results_page) { PageObjects::Page::ResultsWithNewFilters.new }
  let(:base_parameters) { results_page_parameters }

  before do
    activate_feature(:new_filters)

    stub_subjects
    stub_courses(query: base_parameters, course_count: 10)
  end

  describe 'viewing results without explicitly selecting a filter' do
    it 'show courses with or without a SEND specialism' do
      results_page.load

      expect(results_page.send_filter.legend.text).to eq('Special educational needs')
      expect(results_page.send_filter.checkbox.checked?).to be(false)
    end
  end

  describe 'applying the filter' do
    before do
      stub_courses(
        query: base_parameters.merge(
          'filter[send_courses]' => 'true',
          'filter[study_type]' => 'full_time,part_time',
        ),
        course_count: 10,
      )
    end

    context 'selecting courses with a SEND specialism' do
      it 'list the filtered courses' do
        results_page.load

        results_page.send_filter.checkbox.check
        results_page.apply_filters_button.click

        expect(results_page.send_filter.legend.text).to eq('Special educational needs')
        expect(results_page.send_filter.checkbox.checked?).to be(true)
      end
    end
  end
end
