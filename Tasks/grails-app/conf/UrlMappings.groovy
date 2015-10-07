class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/user/login")
		"/index"(view:"/index")
		"/setting"(view:"/setting/index")
        "500"(view:'/error')
	}
}
