using afIoc
using afIocConfig
using afPillow
using afEfanXtra

@NoDoc
const mixin FromPillowPages : SitemapSource { }

internal const class FromPillowPagesImpl : FromPillowPages {
	
	@Inject private const Pages 				pages
	@Inject private const EfanTemplateFinders 	templateFinder
	@Inject private const EfanXtra				efanXtra
	
	@Config { id="afBedSheet.host" }
	@Inject private const Uri host

	@Config { id="afSitemap.scanPillowPages" }
	@Inject private const Bool enabled

	new make(|This|in) { in(this) }
	
	override SitemapUrl[] sitemapUrls() {
		sitemapUrls := SitemapUrl[,]
		if (!enabled)
			return sitemapUrls

		pages.pageTypes.each |pageType| {
			if (pageType.fits(SitemapSource#)) {
				sitemapSrc := (SitemapSource) efanXtra.component(pageType)
				sitemapUrls.addAll(sitemapSrc.sitemapUrls)
				return
			}
			
			pageMeta := pages.pageMeta(pageType, null)
			if (!pageMeta.contextTypes.isEmpty)
				// if the page takes args, we don't know what they should be
				return
			
			// basic pillow page with no render args
			clientUri	:= pageMeta.pageUri
			template	:= templateFinder.findTemplate(pageType)
			sitemapUrls.add(SitemapUrl(host + clientUri) {
				it.lastMod = template.modified
				it.priority	= 0.5f
				it.changefreq = SitemapFreq.monthly
			})
		}

		return sitemapUrls
	}
}
