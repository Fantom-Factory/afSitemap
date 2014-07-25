using afIoc
using afIocConfig
using afBedSheet

** The [Ioc]`http://www.fantomfactory.org/pods/afIoc` module class.
** 
** This class is public so it may be referenced explicitly in test code.
@NoDoc
class SitemapModule {
	
	internal static Void bind(ServiceBinder binder) {
		binder.bind(SitemapPage#)
		binder.bind(FromPillowPages#)
		binder.bind(FromServices#)
	}

	@Contribute { serviceType=Routes# }
	internal static Void contributeRoutes(Configuration config) {
		config["afSitemap.sitemap"] = Route(`/sitemap.xml`, SitemapPage#render)
	}

	@Contribute { serviceType=SitemapPage# }
	internal static Void contributeSitemapPage(Configuration config, FromPillowPages fromPillowPages, FromServices fromServices) {
		config["afSitemap.fromPillowPages"]	= fromPillowPages
		config["afSitemap.fromServices"] 	= fromServices
	}
	
	@Contribute { serviceType=FactoryDefaults# }
	internal static Void contributeFactoryDefaults(Configuration config) {
		config[SitemapConfigIds.scanIocServices] = true
		config[SitemapConfigIds.scanPillowPages] = true
	}	
}
