using afIoc::Inject
using afIocConfig::Config
using afBedSheet::Text
using afEfanXtra
using afPillow
using xml::XDoc
using xml::XElem
using xml::XText

const class SitemapPage {	
	private const SitemapSource[] sitemapSources
	
	new make(SitemapSource[] sitemapSources,|This| in) {
		this.sitemapSources = sitemapSources
		in(this)
	} 
	
	Text get() {
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
