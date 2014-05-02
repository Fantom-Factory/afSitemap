using afBounce
using afBedSheet
using afIoc
using afIocConfig
using afPillow
using afEfanXtra
using afButter

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
	static Void bind(ServiceBinder binder) {
		binder.bind(T_PageService#)
	}
}

@SubModule { modules=[SitemapModule#] }
internal class T_AppModuleOverride {
	@Contribute { serviceType=ApplicationDefaults# }
	internal static Void contributeApplicationDefaults(MappedConfig config) {
		config[SitemapConfigIds.scanIocServices] = false
		config[SitemapConfigIds.scanPillowPages] = false
	}
}

internal const class T_PageService : SitemapSource {
	override SitemapUrl[] sitemapUrls() {
		[SitemapUrl(`http://iocService`)]
	}
}

@NoDoc
@Page { uri=`/standardPillowPage`; template=`fan://afEfanXtra/res/viaRenderMethod.efan` }
const mixin T_Page1 : EfanComponent {
	Str render() { "wotever" }
}

@NoDoc
@Page { template=`fan://afEfanXtra/res/viaRenderMethod.efan`}
const mixin T_Page2 : EfanComponent, SitemapSource {
	override SitemapUrl[] sitemapUrls() {
		[SitemapUrl(`http://pillowSource-1`), SitemapUrl(`http://pillowSource-2`)]
	}
	Str render() { "wotever" }
}

@NoDoc
@Page { uri=`/pillowDirPage`; template=`fan://afEfanXtra/res/viaRenderMethod.efan` }
const mixin T_Page3 : EfanComponent {
	@InitRender
	Void initRender(Str stuff) { }
	Str render() { "wotever" }
}
