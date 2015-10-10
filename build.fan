using build

class Build : BuildPod {

	new make() {
		podName = "afSitemap"
		summary = "A library for creating XML sitemaps for your Bed Application"
		version = Version("1.1.0")

		meta = [
			"proj.name"		: "Sitemap",
			"afIoc.module"	: "afSitemap::SitemapModule",
			"repo.internal"	: "true",
			"repo.tags"		: "web",
			"repo.public"	: "false"
		]

		depends = [
			"sys 1.0",
			"xml 1.0",
			
			// ---- Core ------------------------
			"afIoc       3.0.0 - 3.0", 
			
			// ---- Web -------------------------
			"afBedSheet  1.4.0 - 1.5",
			"afEfanXtra  1.2.0 - 1.2",
			"afPillow    1.1.0 - 1.1",
			
			// ---- Test ------------------------
			"afBounce    1.1.0 - 1.1",
			"afSizzle    1.0.2 - 1.0"
		]

		srcDirs = [`test/`, `fan/`, `fan/public/`, `fan/internal/`]
		resDirs = [`doc/`]
	}
	
	override Void compile() {
		// remove test pods from final build
		testPods := "afBounce afButter afSizzle".split
		depends = depends.exclude { testPods.contains(it.split.first) }
		super.compile
	}
}
