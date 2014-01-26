using afIoc
using afIocConfig
using afPillow
using afEfanXtra

@NoDoc
const mixin FromPillowPages : SitemapSource { }

internal const class FromPillowPagesImpl : FromPillowPages {
	
	@Inject private const Pages 				pages
	@Inject private const ComponentMeta 		componentMeta
	@Inject private const EfanTemplateFinders 	templateFinder
	
	@Config { id="afBedSheet.host" }
	@Inject private const Uri host

	new make(|This|in) { in(this) }
	
	override SitemapUrl[] sitemapUrls() {
		sitemapUrls := SitemapUrl[,]

		pages.pageTypes.each |pageType| {
			
			if (pageType.fits(SitemapSource#)) {
				sitemapSrc := (SitemapSource) pages[pageType]
				sitemapUrls.addAll(sitemapSrc.sitemapUrls)
				return
			}
			
			initMethod := componentMeta.findMethod(pageType, InitRender#) 
			if (initMethod != null && initMethod.params.size > 0) {
				// if the page take args, we don't know what they should be
				return
			}
			
			// basic pillow page with no render args
			clientUri	:= pages.clientUri(pageType)
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
