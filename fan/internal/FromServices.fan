using afIoc

internal const class FromServices : SitemapSource {
	@Inject private const Registry		registry
	
	new make(|This|in) { in(this) }
	
	override SitemapUrl[] sitemapUrls() {
		sitemapUrls := SitemapUrl[,]

		registry.serviceDefinitions.each |def| {
			if (def.serviceType.fits(SitemapSource#) && !def.serviceType.fits(FromPillowPages#) && !def.serviceType.fits(FromServices#)) {
				src := (SitemapSource) registry.serviceById(def.serviceId)
				sitemapUrls.addAll(src.sitemapUrls)
			}
		}
		
		return sitemapUrls
	}
}
