using afIoc
using afIocConfig

@NoDoc
const mixin FromServices : SitemapSource { }

internal const class FromServicesImpl : FromServices {
	@Inject private const ServiceStats	serviceStats
	@Inject private const Registry		registry
	
	@Config { id="afSitemap.scanIocServices" }
	@Inject private const Bool enabled

	new make(|This|in) { in(this) }
	
	override SitemapUrl[] sitemapUrls() {
		sitemapUrls := SitemapUrl[,]
		if (!enabled)
			return sitemapUrls

		serviceStats.stats.each |stat| {
			if (stat.serviceType.fits(SitemapSource#) && !stat.serviceType.fits(FromPillowPages#) && !stat.serviceType.fits(FromServices#)) {
				src := (SitemapSource) registry.serviceById(stat.serviceId)
				sitemapUrls.addAll(src.sitemapUrls)
			}
		}
		
		return sitemapUrls
	}
}
