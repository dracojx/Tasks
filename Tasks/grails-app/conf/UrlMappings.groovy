class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/user/login")
		"/index"(view:"/index")
        "500"(view:'/error')
	}
}
