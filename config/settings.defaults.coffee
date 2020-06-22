module.exports = Settings =
	internal:
		tags:
			port: 3012
			host: process.env["LISTEN_ADDRESS"] or "localhost"

	mongo:
		url: 
      "mongodb://172.17.0.1:27017/sharelatex"

	tags:
		healthCheck:
			user_id: "5620bece05509b0a7a3cbc62"


