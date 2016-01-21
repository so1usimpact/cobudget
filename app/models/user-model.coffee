null

### @ngInject ###
global.cobudgetApp.factory 'UserModel', (BaseModel) ->
  class UserModel extends BaseModel
    @singular: 'user'
    @plural: 'users'

    @serializableAttributes: [
      'email',
      'subscribedToPersonalActivity',
      'subscribedToDailyDigest',
      'subscribedToParticipantActivity',
      'confirmationToken'
    ]

    relationships: ->
      @hasMany 'memberships', with: 'memberId'

    groups: ->
      groupIds = _.map @memberships(), (membership) ->
        membership.groupId
      @recordStore.groups.find(groupIds)

    primaryGroup: ->
      @groups()[0]

    isMemberOf: (group) ->
      _.find @memberships(), (membership) ->
        membership.groupId == group.id

    isAdminOf: (group) ->
      _.find @memberships(), (membership) ->
        membership.groupId == group.id && membership.isAdmin

    isActive: ->
      !@archivedAt

    isConfirmed: ->
      !!@confirmedAt
