using afIoc
using afIocConfig
using afBedSheet

** The [Ioc]`http://www.fantomfactory.org/pods/afIoc` module class.
** 
** This class is public so it may be referenced explicitly in test code.
@NoDoc
class SitemapModule {
	
	internal static Void bind(ServiceBinder binder) {
		binder.bind(SitemapPage#)		.withoutProxy
		binder.bind(FromPillowPages#)	.withoutProxy
		binder.bind(FromServices#)		.withoutProxy
	}

	@Contribute { serviceType=Routes# }
	internal static Void contributeRoutes(OrderedConfig config) {
		config.add(Route(`/sitemap.xml`, SitemapPage#render))
	}

	@Contribute { serviceType=SitemapPage# }
	internal static Void contributeSitemapPage(OrderedConfig config, FromPillowPages fromPillowPages, FromServices fromServices) {
		config.add(fromPillowPages)
		config.add(fromServices)
	}
	
	@Contribute { serviceType=FactoryDefaults# }
	internal static Void contributeFactoryDefaults(MappedConfig config) {
		config[SitemapConfigIds.scanIocServices] = true
		config[SitemapConfigIds.scanPillowPages] = true
	}	
}
