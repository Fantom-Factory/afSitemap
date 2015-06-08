using afIoc
using afBedSheet

** The [IoC]`pod:afIoc` module class.
** 
** This class is public so it may be referenced explicitly in test code.
@NoDoc
class SitemapModule {
	
	static Void defineServices(ServiceDefinitions defs) {
		defs.add(SitemapPage#)
	}

	@Contribute { serviceType=Routes# }
	internal static Void contributeRoutes(Configuration config) {
		config["afSitemap.sitemap"] = Route(`/sitemap.xml`, SitemapPage#render)
	}

	@Contribute { serviceType=SitemapPage# }
	internal static Void contributeSitemapPage(Configuration config) {
		config["afSitemap.fromPillowPages"]	= config.autobuild(FromPillowPages#)
		config["afSitemap.fromServices"] 	= config.autobuild(FromServices#)
	}	
}
