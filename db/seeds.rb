# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

if Rails.env.development? || Rails.env.production?
  # score types
  ScoreType.create! title: "Try", url: "", points: 5
  ScoreType.create! title: "Penalty Try", url: "", points: 5
  ScoreType.create! title: "Conversion", url: "", points: 2
  ScoreType.create! title: "Penalty", url: "", points: 3
  ScoreType.create! title: "Drop Goal", url: "", points: 3
  # event types
  # roles
  Role.create! title: "Physio", url: ""
  Role.create! title: "Manager", url: ""
  Role.create! title: "Coach", url: ""
  Role.create! title: "Referee", url: ""
  Role.create! title: "Assistant Judge", url: ""
  Role.create! title: "Touch Judge", url: ""
  Role.create! title: "Television Match Official", url: ""
  Role.create! title: "Substitution Controller", url: ""
  # player positions
end
