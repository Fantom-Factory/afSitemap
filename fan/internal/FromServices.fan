using afIoc
using afIocConfig

@NoDoc
const mixin FromServices : SitemapSource { }

internal const class FromServicesImpl : FromServices {
	@Inject private const Registry		registry
	
	@Config { id="afSitemap.scanIocServices" }
	@Inject private const Bool enabled

	new make(|This|in) { in(this) }
	
	override SitemapUrl[] sitemapUrls() {
		sitemapUrls := SitemapUrl[,]
		if (!enabled)
			return sitemapUrls

		registry.serviceDefinitions.each |def| {
			if (def.serviceType.fits(SitemapSource#) && !def.serviceType.fits(FromPillowPages#) && !def.serviceType.fits(FromServices#)) {
				src := (SitemapSource) registry.serviceById(def.serviceId)
				sitemapUrls.addAll(src.sitemapUrls)
			}
		}
		
		return sitemapUrls
	}
}
