using afIoc
using afIocConfig
using afPillow
using afEfanXtra
using afBedSheet

@NoDoc
const mixin FromPillowPages : SitemapSource { }

internal const class FromPillowPagesImpl : FromPillowPages {
	
	@Inject private const Pages 			pages
	@Inject private const TemplateFinders 	templateFinder
	@Inject private const EfanXtra			efanXtra
	@Inject private const BedSheetServer	bedServer
	
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
			if (!pageMeta.initRender.paramTypes.isEmpty)
				// if the page takes args, we don't know what they should be
				return
			
			// basic pillow page with no render args
			clientUrl	:= pageMeta.pageUrl
			templateSrc	:= templateFinder.getOrFindTemplate(pageType)
			sitemapUrls.add(SitemapUrl(bedServer.toAbsoluteUrl(clientUrl)) {
				it.lastMod = templateSrc.lastModified
				it.priority	= 0.5f
				it.changefreq = SitemapFreq.monthly
			})
		}

		return sitemapUrls
	}
}
