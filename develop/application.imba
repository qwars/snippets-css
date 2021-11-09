
import firebase from "@firebase/app"
import "@firebase/firestore"
import "@firebase/storage"

const Firestore = require './classes/firebase-google-cloud/src'

const firestore = Firestore.default.new process:env:API_KEYS, Imba:commit

import Widget as FormAuthentication from './widgets/authentication-firebase'
import Authentication from './widgets/authentication-firebase/authentication-class'
import Sketch as SchemeUI from './styleshets/scheme-ui'

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
	def signOut
		authentication.signOut
	def profile
		authentication:_profile

	def testimony
		@testimony

	def testimony= dataset
		@testimony.update( dataset ).catch( do |error| console.log 'error update testimony',  error )

	# Методы работы с коллекциями и документами базы
	def folders
		testimony.collection('folders').orderBy('updatedAt', 'desc')
			.where('tags', 'array-contains', params:collection )

	def removeFolder ref
		testimony.collection( params:collection ).where( 'folder', '==', ref ).catch( invalidCompletion )
			.then do|response| ref.delete if response.docs.map( do|item| item.ref.update( { foleders: item.data:folders } ).catch( invalidCompletion ) if item.data:folders.splice( item.data:folders.indexOf( ref ), 1 ) )

	def createFolder datastate
		datastate:createdAt = testimony:firestore:FieldValue.serverTimestamp
		datastate:updatedAt = testimony:firestore:FieldValue.serverTimestamp
		datastate:createdUid = testimony
		datastate:tags = [ params:collection ].concat( params:part or [] )
		testimony.collection('folders').add( datastate ).catch( invalidCompletion )

	def collection
		if params:collection === 'stores' then firestore.collection( params:collection ).limit(20).orderBy 'updatedAt', 'desc'
		elif params:collection then testimony.collection( params:collection ).limit(20).orderBy 'updatedAt', 'desc'

	def document
		if params:collection === 'stores' and params:document and params:part then firestore.collection( params:collection ).doc params:document or params:part
		elif params:collection and params:part then testimony.collection( params:collection ).doc params:document or params:part

	def createDocument datastate, callback
		datastate:createdAt = testimony:firestore:FieldValue.serverTimestamp
		datastate:updatedAt = testimony:firestore:FieldValue.serverTimestamp
		datastate:createdUid = testimony
		testimony.collection( params:collection ).add( datastate ).catch( invalidCompletion )
			.then do router.go "/{ route.params:collection }/{ $1:id }" unless callback isa Function and callback $1

	def updateDocument datastate, callback
		datastate:updatedAt = testimony:firestore:FieldValue.serverTimestamp
		datastate:updatedUid = testimony
		document.update( datastate ).catch( invalidCompletion )
			.then do callback isa Function and callback $1

	def render
		<self .authentication=!testimony .waiting=waiting>
			if process:env:NODE_ENV === 'development' and params:collection === '-' then <SchemeUI>
			else
				if waiting then <.loading>
				elif not testimony then <FormAuthentication@Authentication[ authentication ]>