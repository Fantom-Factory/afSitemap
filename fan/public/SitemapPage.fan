using afIoc::Inject
using afBedSheet::Text
using afEfanXtra
using afPillow
using xml::XDoc
using xml::XElem
using xml::XText

** (Service) Renders the '/sitemap.xml' page as detailed by [www.sitemaps.org]`http://www.sitemaps.org/`.
const mixin SitemapPage {
	abstract Text render()
}

internal const class SitemapPageImpl : SitemapPage {
	private const SitemapSource[] sitemapSources
	
	internal new make(SitemapSource[] sitemapSources,|This| in) {
		this.sitemapSources = sitemapSources
		in(this)
	} 
	
	override Text render() {
		doc		:= XDoc()
		
		urlset	:=	XElem("urlset")
		urlset.addAttr("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9")
		doc.add(urlset)
		
		sitemapSources.each {
			it.sitemapUrls.each {
				urlset.add(it.toXml)
			}
		}
		
		xml := StrBuf()
		doc.write(xml.out)		
		return Text.fromXml(xml.toStr)
	}
}
