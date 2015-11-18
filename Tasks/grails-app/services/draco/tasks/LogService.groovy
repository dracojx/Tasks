package draco.tasks

import grails.transaction.Transactional

@Transactional
class LogService {
	
	def changeLogType(def lId) {
		Log log = Log.get(lId as long)
		if(log) {
			switch(log.getType()) {
				case 'c':
					log.setType('u')
					break
				case 'u':
					log.setType('c')
					break
//				case 'd':
//					log.setType('c')
//					break
			}
		}
	}
}
