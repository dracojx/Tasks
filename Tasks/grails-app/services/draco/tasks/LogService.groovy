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
					log.setType('d')
					break
				case 'd':
					log.setType('c')
					break
			}
		}
	}
}
