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
  PlayerPosition.create title: "Loose Head Prop", position_number: 1, url: ""
  PlayerPosition.create title: "Hooker", position_number: 2, url: ""
  PlayerPosition.create title: "Tight Head Prop", position_number: 3, url: ""
  PlayerPosition.create title: "Second Row", position_number: 4, url: ""
  PlayerPosition.create title: "Second Row", position_number: 5, url: ""
  PlayerPosition.create title: "Blind Side Flanker", position_number: 6, url: ""
  PlayerPosition.create title: "Open Side Flanker", position_number: 7, url: ""
  PlayerPosition.create title: "Number 8", position_number: 8, url: ""
  PlayerPosition.create title: "Scrum-Half", position_number: 9, url: ""
  PlayerPosition.create title: "Out-Half", position_number: 10, url: ""
  PlayerPosition.create title: "Left Wing", position_number: 11, url: ""
  PlayerPosition.create title: "Inside Centre", position_number: 12, url: ""
  PlayerPosition.create title: "Outside Centre", position_number: 13, url: ""
  PlayerPosition.create title: "Right Wing", position_number: 14, url: ""
  PlayerPosition.create title: "Full-Back", position_number: 15, url: ""
  # match state
  MatchState.create title: "Kick Off"
  MatchState.create title: "In Play"
  MatchState.create title: "Half Time"
  MatchState.create title: "Time Out"
  MatchState.create title: "Full Time"
  MatchState.create title: "Abandoned"
  # player state
  PlayerState.create title: "Active"
  PlayerState.create title: "Suspended"
  PlayerState.create title: "Retired"
  PlayerState.create title: "Ineligible"
end
