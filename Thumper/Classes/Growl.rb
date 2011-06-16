framework 'Cocoa'
framework 'Foundation'

class Growl

    
    def initialize(app, notifications, icon = nil)
        @application_name = app
        @application_icon = icon || NSApplication.sharedApplication.applicationIconImage
        @notifications = notifications
        @default_notifications = notifications
        @center = NSDistributedNotificationCenter.defaultCenter
        send_registration!
    end
    
    def notify(notification, title, description, options = {})
        dict = {
            :ApplicationName => @application_name,
            #:ApplicationPID => pid,
            :NotificationName => notification,
            :NotificationTitle => title,
            :NotificationDescription => description,
            :NotificationPriority => options[:priority] || 0,
            :NotificationIcon => @application_icon.TIFFRepresentation,
        }
        dict[:NotificationSticky] = 1 if options[:sticky]
        
        @center.postNotificationName(:GrowlNotification, object:nil, userInfo:dict, deliverImmediately:false)
    end
    
    def send_registration!
        
        dict = {
            :ApplicationName => @application_name,
            :ApplicationIcon => @application_icon.TIFFRepresentation,
            :AllNotifications => @notifications,
            :DefaultNotifications => @default_notifications
        }
        
        @center.postNotificationName(:GrowlApplicationRegistrationNotification, object:nil, userInfo:dict, deliverImmediately:true)
    end
end
