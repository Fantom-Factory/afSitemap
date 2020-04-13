using xml::XElem
using xml::XText

** The main Sitemap URL entity.
const class SitemapUrl {
	
	** URL of the page. This URL must begin with the protocol (such as 'http').
	** 
	** @see `http://www.sitemaps.org/protocol.html#locdef`
	const Uri			loc
	
	** The date of last modification of the file.
	** 
	** @see `http://www.sitemaps.org/protocol.html#lastmoddef`
	const DateTime?		lastMod
	
	** How frequently the page is likely to change.
	** 
	** @see `http://www.sitemaps.org/protocol.html#changefreqdef`
	const SitemapFreq?	changefreq
	
	** The priority of this URL relative to other URLs on your site. 
	** Valid values range from '0.0' to '1.0'. 
	** 
	** @see `http://www.sitemaps.org/protocol.html#prioritydef`
	const Float?		priority
	
	new make(Uri loc, |This|? in := null) {
		this.loc = loc
		in?.call(this)
		
		if (!loc.isAbs || loc.host == null)
			throw Err("Sitemap location `$loc` must have a scheme and a host, e.g. http://example.com/")
	}
	
	XElem toXml() {
		url := XElem("url")

		url.add(XElem("loc") {
			XText(loc.toStr),
		})

		if (lastMod != null)
			url.add(XElem("lastmod") {
				XText(lastMod.toLocale("YYYY-MM-DD")),
			})

		if (changefreq != null)
			url.add(XElem("changefreq") {
				XText(changefreq.toStr),
			})

		if (priority != null)
			url.add(XElem("priority") {
				XText(priority.toLocale("0.0")),
			})
		
		return url
	}
}

** Describes how frequently the page is likely to change. 
** Note that the value of this tag is considered a *hint* and not a command.
** 
** @see `http://www.sitemaps.org/protocol.html#changefreqdef`
enum class SitemapFreq {
	
	** Use to describe documents that change each time they are accessed
    always,
    hourly,
    daily,
    weekly,
    monthly,
    yearly,
	
	** Use to describe archived URLs
    never
}
