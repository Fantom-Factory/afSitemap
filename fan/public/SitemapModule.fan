using afIoc
using afBedSheet

** The [Ioc]`http://www.fantomfactory.org/pods/afIoc` module class.
** 
** This class is public so it may be referenced explicitly in test code.
class SitemapModule {
	
	internal static Void bind(ServiceBinder binder) {
		binder.bind(SitemapPages#)
		binder.bind(FromPillowPages#)
		binder.bind(FromServices#)
	}

	@Contribute { serviceType=Routes# }
	internal static Void contributeRoutes(OrderedConfig config) {
		config.add(Route(`/sitemap.xml`, SitemapPages#get))
	}

	@Contribute { serviceType=SitemapPages# }
	internal static Void contributeSitemapPages(OrderedConfig config, FromPillowPages fromPillowPages, FromServices fromServices) {
		config.add(fromPillowPages)
		config.add(fromServices)
	}
}
