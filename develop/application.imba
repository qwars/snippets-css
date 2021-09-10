
import firebase from "@firebase/app"
import "@firebase/firestore"
import "@firebase/storage"

const Firestore = require './classes/firebase-google-cloud/src'

const firestore = Firestore.default.new process:env:API_KEYS, Imba:commit

import Widget as FormAuthentication from './widgets/authentication-firebase'
import Authentication from './widgets/authentication-firebase/authentication-class'

const authentication = Authentication.new firebase

export tag Application < output
	prop loading default: false
	prop waiting default: true
	prop messages default: []

	def setup

		# Добавляем классу 'authentication' событие получения текущего пользователя
		authentication:setProfile = do |value|
			authentication:_profile = value
			if value and value:emailVerified then @testimony = firestore.collection('users').doc( value:uid ) if firestore.destroy
			else if value then authentication.emailVerified
			else @testimony = firestore.destroy and value
			Imba.commit @waiting = undefined
		# Расширяем теги 'application' - будет доступно из любого тега
		const datastate = self

		extend tag element
			def application
				datastate

	def message
		@messages

	def message= v
		const idx = @messages.push v
		setTimeout(&, 20000) do Imba.commit @messages.splice( idx - 1, 1)

	def invalidCompletion e
		if e then message = Object.assign e,
			name:  'invalid',
			message: Messages[ e:message ] or e:message

	def warningCompletion e
		if e then message = Object.assign e,
			name:  'warning',
			message: Messages[ e:message ] or e:message

	def announcementCompletion e
		if e then message = Object.assign e,
			name:  'announcement',
			message: Messages[ e:message ] or e:message

	# testimony - аутентифицированный пользователь, ссылка на документ с данными пользователя
	def testimony
		@testimony

	def testimony= dataset
		@testimony.update( dataset ).catch( do |error| console.log 'error update testimony',  error )

	def render
		<self .authentication=!testimony .waiting=waiting>
			if waiting then <.loading>
			elif not testimony then <FormAuthentication@Authentication>