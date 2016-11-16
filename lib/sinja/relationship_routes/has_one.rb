# frozen_string_literal: true
module Sinja
  module RelationshipRoutes
    module HasOne
      ACTIONS = %i[pluck prune graft].freeze
      CONFLICT_ACTIONS = %i[graft].freeze

      def self.registered(app)
        app.def_action_helpers(ACTIONS, app)

        app.get '', :actions=>:pluck do
          serialize_model(*pluck)
        end

        app.patch '', :nullif=>proc(&:nil?), :actions=>:prune do
          serialize_linkage?(*prune)
        end

        app.patch '', :actions=>:graft do
          serialize_linkage?(*graft(data))
        end
      end
    end
  end
end