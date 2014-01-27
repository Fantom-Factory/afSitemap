using build

class Build : BuildPod {

	new make() {
		podName = "afSitemap"
		summary = "(Internal) A library for creating XML sitemaps for your Bed App"
		version = Version("0.0.3")

		meta = [
			"org.name"		: "Alien-Factory",
			"org.uri"		: "http://www.alienfactory.co.uk/",
			"vcs.uri"		: "https://bitbucket.org/AlienFactory/afsitemap",
			"proj.name"		: "Sitemap",
			"license.name"	: "The MIT License",
			"repo.private"	: "true",

			"afIoc.module"	: "afSitemap::SitemapModule"
		]

		depends = [
			"sys 1.0",
			"xml 1.0",
			
			"afIoc 1.5.2+", 
			"afIocConfig 1.0.2+", 
			"afBedSheet 1.3.0+",
			"afEfanXtra 1.0.8+",
			"afPillow 0+",
			
			"afButter 0+",
			"afBounce 0+"
		]

		srcDirs = [`test/`, `fan/`, `fan/public/`, `fan/internal/`]
		resDirs = [`doc/`]

		docApi = true
		docSrc = true
	}

	@Target { help = "Compile to pod file and associated natives" }
	override Void compile() {
		// exclude test code when building the pod
		srcDirs = srcDirs.exclude { it.toStr.startsWith("test/") }
		resDirs = resDirs.exclude { it.toStr.startsWith("res/test/") }
		
		super.compile
		
		// copy src to %FAN_HOME% for F4 debugging
		log.indent
		destDir := Env.cur.homeDir.plus(`src/${podName}/`)
		destDir.delete
		destDir.create		
		`fan/`.toFile.copyInto(destDir)		
		log.info("Copied `fan/` to ${destDir.normalize}")
		log.unindent
	}
}
