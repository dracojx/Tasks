import tasks.User

class BootStrap {

    def init = { servletContext ->
		environments {
			development {
				User user1 = new User(username:'jingxuan', password:'123456', name:'景轩', role: '1', reset:false, enabled:true)
				user1.save()
				
				User user2 = new User(username:'admin', password:'123', name:'Administrator', role: '0', reset:false, enabled:true)
				user2.save()
				
				User user3 = new User(username:'test', password:'123', name:'test', role:'2', reset:false, enabled:false)
				user3.save()
			}
		}
    }
    def destroy = {
    }
}
