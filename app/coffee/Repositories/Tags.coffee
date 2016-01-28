Settings = require 'settings-sharelatex'
logger = require('logger-sharelatex')
db = require('mongojs').connect(Settings.mongo?.url, ['tags'])
ObjectId = require('mongojs').ObjectId
metrics = require('../Metrics')

# Note that for legacy reasons, user_id and project_ids are plain strings,
# not ObjectIds.

module.exports =

	getUserTags: (user_id, callback = (err, user)->)->
		db.tags.find {"user_id" : user_id}, (err, user)->
			callback err, user

	getUserTagByName: (user_id, tag_name, callback = (err, tag)->)->
		db.tags.findOne {"user_id" : user_id, "name":tag_name}, callback

	addProjectToTag: (user_id, project_id, tag_name, callback)->
		searchOps = 
			user_id:user_id
			name:tag_name
		insertOperation = 
			"$addToSet": {project_ids:project_id}
		db.tags.update(searchOps, insertOperation, {upsert:true}, callback)

	removeProjectFromTag: (user_id, project_id, tag_name, callback)->
		searchOps = 
			user_id:user_id
			name:tag_name
		deleteOperation = 
			"$pull": {project_ids:project_id}
		db.tags.update searchOps, deleteOperation, callback

	removeProjectFromAllTags: (user_id, project_id, callback)->
		searchOps = 
			user_id:user_id
		deleteOperation = 
			"$pull": {project_ids:project_id}
		db.tags.update searchOps, deleteOperation, multi:true, callback
	
	deleteTag: (user_id, tag_id, callback = (error) ->) ->
		try
			tag_id = ObjectId(tag_id)
		catch e
			return callback(e)
		db.tags.remove {
			_id: tag_id,
			user_id: user_id
		}, callback
	
	renameTag: (user_id, tag_id, name, callback = (error) ->) ->
		try
			tag_id = ObjectId(tag_id)
		catch e
			return callback(e)
		db.tags.update {
			_id: tag_id,
			user_id: user_id
		}, {
			$set:
				name: name
		}, callback
