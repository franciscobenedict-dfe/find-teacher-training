require 'rails_helper'

describe Courses::EntryRequirementsComponent, type: :component do
  context 'when the provider accepts pending GCSEs' do
    it 'renders correct message' do
      course = build(
        :course,
        accept_pending_gcse: true,
      )
      result = render_inline(described_class.new(course: course))

      expect(result.text).to include(
        'We will consider candidates with pending GCSEs.',
      )
    end
  end

  context 'when the provider does NOT accept pending GCSEs' do
    it 'renders correct message' do
      course = build(
        :course,
        accept_pending_gcse: false,
      )
      result = render_inline(described_class.new(course: course))

      expect(result.text).to include(
        'We will not consider candidates with pending GCSEs.',
      )
    end
  end

  context 'when the provider requires grade 4 and the course is secondary' do
    it 'renders correct message' do
      course = build(
        :course,
        provider: build(:provider, provider_code: 'ABC'),
        level: 'primary',
      )
      result = render_inline(described_class.new(course: course))

      expect(result.text).to include(
        'Grade 4 (C) or above in English, maths and science, or equivalent qualification.',
      )
    end
  end

  context 'when the provider requires grade 5 and the course is secondary' do
    it 'renders correct message' do
      course = build(
        :course,
        provider: build(:provider, provider_code: 'U80'),
        level: 'secondary',
      )
      result = render_inline(described_class.new(course: course))

      expect(result.text).to include(
        'Grade 5 (C) or above in English and maths, or equivalent qualification.',
      )
    end

    context 'when the accrediting provider requires grade 5 and the course is secondary' do
      it 'renders correct message' do
        accrediting_provider = build(:provider, provider_code: 'U80')
        course = build(
          :course,
          provider: build(:provider),
          accrediting_provider: accrediting_provider,
          level: 'secondary',
        )

        result = render_inline(described_class.new(course: course))

        expect(result.text).to include(
          'Grade 5 (C) or above in English and maths, or equivalent qualification.',
        )
      end
    end
  end

  context 'when the provider does not accept equivalant GCSE grades' do
    it 'renders correct message' do
      course = build(
        :course,
        accept_gcse_equivalency: false,
        accept_english_gcse_equivalency: false,
        accept_maths_gcse_equivalency: false,
        accept_science_gcse_equivalency: false,
      )
      result = render_inline(described_class.new(course: course))

      expect(result.text).to include(
        'We do not accept equivalency tests.',
      )
    end
  end

  context 'when the provider accepts equivalant GCSE grades for Maths and science' do
    it 'renders correct message' do
      course = build(
        :course,
        accept_gcse_equivalency: true,
        accept_english_gcse_equivalency: false,
        accept_maths_gcse_equivalency: true,
        accept_science_gcse_equivalency: true,
      )
      result = render_inline(described_class.new(course: course))

      expect(result.text).to include(
        'We will accept equivalency tests in maths and science.',
      )
    end
  end

  context 'when the provider requires a 2:2 and specifies additional requirements' do
    it 'renders correct message' do
      course = build(
        :course,
        degree_grade: 'two_two',
        additional_degree_subject_requirements: true,
        degree_subject_requirements: 'Certificate must be printed on green paper.',
      )
      result = render_inline(described_class.new(course: course))

      expect(result.text).to include(
        '2:2 or above, or equivalent.',
      )
      expect(result.text).to include(
        'Certificate must be printed on green paper.',
      )
    end
  end
end
