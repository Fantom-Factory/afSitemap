using afIoc::Inject
using afIocConfig::Config
using afBedSheet::Text
using afEfanXtra
using afPillow
using xml::XDoc
using xml::XElem
using xml::XText

internal const mixin SitemapPages {
	abstract Text get()
}

internal const class SitemapPagesImpl : SitemapPages {
	private const SitemapSource[] sitemapSources
	
	internal new make(SitemapSource[] sitemapSources,|This| in) {
		this.sitemapSources = sitemapSources
		in(this)
	} 
	
	override Text get() {
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
