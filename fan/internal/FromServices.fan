using afIoc

internal const class FromServices : SitemapSource {
	@Inject private const Scope		scope
	
	new make(|This|in) { in(this) }
	
	override SitemapUrl[] sitemapUrls() {
		sitemapUrls := SitemapUrl[,]

		scope.registry.serviceDefs.each |def| {
			if (def.type.fits(SitemapSource#) && !def.type.fits(FromPillowPages#) && !def.type.fits(FromServices#)) {
				src := (SitemapSource) scope.serviceById(def.id)
				sitemapUrls.addAll(src.sitemapUrls)
			}
		}
		
		return sitemapUrls
	}
}
