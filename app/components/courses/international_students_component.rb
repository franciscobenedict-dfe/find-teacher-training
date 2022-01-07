module Courses
  class InternationalStudentsComponent < ViewComponent::Base
    include ViewHelper

    TRAIN_TO_TEACH_URL = 'https://www.gov.uk/government/publications/train-to-teach-in-england-non-uk-applicants/train-to-teach-in-england-non-uk-applicants#visas-and-immigration'.freeze
    VISA_GUIDANCE_URL = 'https://www.gov.uk/government/publications/train-to-teach-in-england-non-uk-applicants/train-to-teach-in-england-if-youre-a-non-uk-citizen#visa'.freeze
    OTHER_VISA_GUIDANCE_URL = 'https://www.gov.uk/government/publications/train-to-teach-in-england-non-uk-applicants/train-to-teach-in-england-if-youre-a-non-uk-citizen#studying-and-working-as-a-teacher-in-the-uk-without-a-skilled-worker-visa-or-a-student-visa'.freeze

    def initialize(course:)
      @course = course
    end

    def provider
      @provider ||= @course.provider
    end

    def visa_sponsorship_status
      if !@course.salaried? && provider.can_sponsor_student_visa
        "<p class=\"govuk-body\">You’ll need the right to study in the UK. You already have this if you:</p>
        <ul class=\"govuk-list govuk-list--bullet\">
          <li>are an Irish citizen</li>
          <li>have settled or pre-settled status under the EU Settlement Scheme</li>
        </ul>

        <p class=\"govuk-body\">If you do not already have the right to study in the UK, you may need to apply for a Student visa. Student visa sponsorship is available for this course. If you get a place on this course, we’ll help you apply for your visa.</p>


        <p class=\"govuk-body\">Alternatively, you may be eligible for visa types that allow you to train to be a teacher without a Student visa.</p>
        <p class=\"govuk-body\">Find out more about visas and immigration statuses.</p>"
      elsif @course.salaried? && provider.can_sponsor_skilled_worker_visa
        "<p class=\"govuk-body\">You’ll need the right to work in the UK. You already have this if you:</p>
        <ul class=\"govuk-list govuk-list--bullet\">
          <li>are an Irish citizen</li>
          <li>have settled or pre-settled status under the EU Settlement Scheme</li>
        </ul>

        <p class=\"govuk-body\">If you do not already have the right to work in the UK, you may need to apply for a Skilled Worker visa. Skilled Worker visa sponsorship is available for this course. If you get a place on this course, we’ll help you apply for your visa.</p>


        <p class=\"govuk-body\">Alternatively, you may be eligible for visa types that allow you to train to be a teacher without a Skilled Worker visa.</p>"
         <p class=\"govuk-body\">Find out more about visas and immigration statuses.</p>
      elsif @course.salaried?
        "<p class=\"govuk-body\">You’ll need the right to work in the UK. You already have this if you:</p>
        <ul class=\"govuk-list govuk-list--bullet\">
          <li>are an Irish citizen</li>
          <li>have settled or pre-settled status under the EU Settlement Scheme</li>
        </ul>

        <p class=\"govuk-body\">If you do not already have the right to work in the UK, you can search for courses where visa sponsorship is available. Sponsorship is not available for this course.</p>

        <p class=\"govuk-body\">Alternatively, you may be eligible for visa types that allow you train to be a teacher without a Skilled Worker visa.</p>
        <p class=\"govuk-body\">Find out more about visas and immigration statuses.</p>
      else
        "<p class=\"govuk-body\">You’ll need the right to study in the UK. You already have this if you:</p>
        <ul class=\"govuk-list govuk-list--bullet\">
          <li>are an Irish citizen</li>
          <li>have settled or pre-settled status under the EU Settlement Scheme</li>
        </ul>

        <p class=\"govuk-body\">If you do not already have the right to study in the UK, you can search for courses where visa sponsorship is available. Sponsorship is not available for this course.</p>

        <p class=\"govuk-body\">Alternatively, you may be eligible for a visa type or immigration status that allow you to train to be a teacher without visa sponsorship.</p>
         <p class=\"govuk-body\">Find out more about visas and immigration statuses.</p>
      end
    end
  end
end
