
import './index.styl'

import Aside as WidgetsAside, Navigation as WidgetsNavigation, Article as WidgetsArticle from '../widgets'
import Aside as TemplatesAside, Navigation as TemplatesNavigation, Article as TemplatesArticle from '../templates'
import Aside as ProjectsAside, Navigation as ProjectsNavigation, Article as ProjectsArticle from '../projects'
import Aside as StoresAside, Navigation as StoresNavigation, Article as StoresArticle from '../stores'

export tag Sketch < main
	@classes = []
	def render
		<self>
			<WidgetsNavigation route="/widgets/*:document*/*">
			<WidgetsArticle route="/widgets/*:document*/*">
			<WidgetsAside route="/widgets/*:document*/*">
			<TemplatesNavigation route="/templates/*:document*/*">
			<TemplatesArticle route="/templates/*:document*/*">
			<TemplatesAside route="/templates/*:document*/*">
			<ProjectsNavigation route="/projects/*:document*/*">
			<ProjectsArticle route="/projects/*:document*/*">
			<ProjectsAside route="/projects/*:document*/*">
			<StoresNavigation route="/stores/*:part*/*:document*/*">
			<StoresArticle route="/stores/*:part*/*:document*/*">
			<StoresAside route="/stores/*:part*/*:document*/*">
