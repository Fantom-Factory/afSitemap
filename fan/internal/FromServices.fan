using afIoc

@NoDoc
const mixin FromServices : SitemapSource { }

internal const class FromServicesImpl : FromServices {
	@Inject private const ServiceStats	serviceStats
	@Inject private const Registry		registry
	
	new make(|This|in) { in(this) }
	
	override SitemapUrl[] sitemapUrls() {
		sitemapUrls := SitemapUrl[,]
		
		serviceStats.stats.each |stat| {
			if (stat.serviceType.fits(SitemapSource#) && !stat.serviceType.fits(FromPillowPages#) && !stat.serviceType.fits(FromServices#)) {
				src := (SitemapSource) registry.serviceById(stat.serviceId)
				sitemapUrls.addAll(src.sitemapUrls)
			}
		}
		
		return sitemapUrls
	}
}
