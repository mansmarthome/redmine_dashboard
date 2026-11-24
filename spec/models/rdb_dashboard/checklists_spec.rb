# frozen_string_literal: true

require File.expand_path('../../spec_helper', __dir__)

describe RdbDashboard do
  fixtures :projects

  subject(:dashboard) { described_class.new(project, options, params) }

  let(:project) { Project.find(1) }
  let(:options) { {} }
  let(:params) { {} }

  describe '.use_checklist?' do
    it 'is false without the checklists plugin' do
      skip 'checklists plugin is loaded' if Object.const_defined?(:Checklist)

      expect(described_class.use_checklist?).to be false
    end
  end

  describe '#show_checklists?' do
    it 'is false when the checklists plugin is not available' do
      allow(described_class).to receive(:use_checklist?).and_return(false)

      expect(dashboard.show_checklists?).to be false
    end

    it 'defaults to shown when checklists are available' do
      allow(described_class).to receive(:use_checklist?).and_return(true)

      expect(dashboard.show_checklists?).to be true
    end

    context 'when disabled in options' do
      let(:options) { {show_checklists: false} }

      it 'is false' do
        allow(described_class).to receive(:use_checklist?).and_return(true)

        expect(dashboard.show_checklists?).to be false
      end
    end
  end
end
