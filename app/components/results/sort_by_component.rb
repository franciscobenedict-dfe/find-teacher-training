module Results
  class SortByComponent < ViewComponent::Base
    include ViewHelper

    attr_reader :results

    def initialize(results:)
      @results = results
    end

    def render?
      !results.provider_filter?
    end
  end
end
