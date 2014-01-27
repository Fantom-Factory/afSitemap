using afBounce
using afBedSheet::Route
using afBedSheet::Routes
using afBedSheet::Text
using afBedSheet::HttpSession
using afIoc
using afIocConfig
using afPillow
using afEfanXtra
using afButter

class TestSitemap : Test {
	
	Void testSitemapGenerates() {
		// given
		server := BedServer(T_AppModule#).addModulesFromDependencies(PillowModule#.pod).startup
		client := server.makeClient
		
		// when
		res := client.get(`/sitemap.xml`)
		
		// then
		verifyNotNull(client.selectCss("urlset url loc").find { it.text.writeToStr.contains("/iocService") })
		verifyNotNull(client.selectCss("urlset url loc").find { it.text.writeToStr.contains("/standardPillowPage") })
		verifyNotNull(client.selectCss("urlset url loc").find { it.text.writeToStr.contains("/pillowSource-1") })
		verifyNotNull(client.selectCss("urlset url loc").find { it.text.writeToStr.contains("/pillowSource-2") })
		verifyNull   (client.selectCss("urlset url loc").find { it.text.writeToStr.contains("/pillowDirPage") })
		
		client.shutdown
	}

	Void testDisableScanning() {
		// given
		server := BedServer(T_AppModule#).addModulesFromDependencies(PillowModule#.pod).addModule(T_AppModuleOverride#) .startup
		client := server.makeClient
		
		// when
		res := client.get(`/sitemap.xml`)
		
		// then
		verifyEq(client.selectCss("urlset url loc").size, 0)
		
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
@PageUri { uri=`/standardPillowPage` }
@EfanTemplate { uri=`fan://afEfanXtra/res/viaRenderMethod.efan`}
const mixin T_Page1 : Page {
	Str render() { "wotever" }
}

@NoDoc
@EfanTemplate { uri=`fan://afEfanXtra/res/viaRenderMethod.efan`}
const mixin T_Page2 : Page, SitemapSource {
	override SitemapUrl[] sitemapUrls() {
		[SitemapUrl(`http://pillowSource-1`), SitemapUrl(`http://pillowSource-2`)]
	}
	Str render() { "wotever" }
}

@NoDoc
@PageUri { uri=`/pillowDirPage` }
@EfanTemplate { uri=`fan://afEfanXtra/res/viaRenderMethod.efan`}
const mixin T_Page3 : Page {
	@InitRender
	Void initRender(Str stuff) { }
	Str render() { "wotever" }
}
