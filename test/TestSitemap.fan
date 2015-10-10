using afBounce
using afBedSheet
using afIoc
using afPillow
using afEfanXtra

class TestSitemap : Test {
	
	Void testSitemapGenerates() {
		// given
		server := BedServer(T_AppModule#).startup
		client := server.makeClient
		
		// when
		res := client.get(`/sitemap.xml`)
		
		// then
		loc := Element("urlset url loc")
		
		verifyNotNull(loc.list.find { it.text.contains("/iocService"		) })
		verifyNotNull(loc.list.find { it.text.contains("/standardPillowPage") })
		verifyNotNull(loc.list.find { it.text.contains("/pillowSource-1"	) })
		verifyNotNull(loc.list.find { it.text.contains("/pillowSource-2"	) })
		verifyNull   (loc.list.find { it.text.contains("/pillowDirPage"		) })
		
		client.shutdown
	}

	Void testDisableScanning() {
		// given
		server := BedServer(T_AppModule#).addModule(T_AppModuleOverride#).startup
		client := server.makeClient
		
		// when
		res := client.get(`/sitemap.xml`)
		
		// then
		Element("urlset url loc").verifySizeEq(0)
		
		client.shutdown
	}
}

@SubModule { modules=[SitemapModule#] }
internal class T_AppModule {
	static Void defineServices(RegistryBuilder defs) {
		defs.addService(T_PageService#)
	}
}

@SubModule { modules=[SitemapModule#] }
internal class T_AppModuleOverride {
	@Contribute { serviceType=SitemapPage# }
	internal static Void contributeSitemapPage(Configuration config) {
		config.remove("afSitemap.fromPillowPages")
		config.remove("afSitemap.fromServices")
	}
}

internal const class T_PageService : SitemapSource {
	override SitemapUrl[] sitemapUrls() {
		[SitemapUrl(`http://iocService`)]
	}
}

@NoDoc
@Page { url=`/standardPillowPage` }
const mixin T_Page1 : EfanComponent {
	override Str renderTemplate() { "wotever" }
}

@NoDoc
@Page
const mixin T_Page2 : EfanComponent, SitemapSource {
	override SitemapUrl[] sitemapUrls() {
		[SitemapUrl(`http://pillowSource-1`), SitemapUrl(`http://pillowSource-2`)]
	}
	override Str renderTemplate() { "wotever" }
}

@NoDoc
@Page { url=`/pillowDirPage` }
const mixin T_Page3 : EfanComponent {
	@InitRender
	Void initRender(Str stuff) { }
	override Str renderTemplate() { "wotever" }
}
