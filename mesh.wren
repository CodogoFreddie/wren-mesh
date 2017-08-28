class Mesh {
	verts { _verts }
	norms { _norms }

	name { _name }

	toString { "
o %(name)
%(_verts.join("\n"))
%(_norms.join("\n"))
%(_faces.join("\n"))
" }

	construct new(name){
		_name = name
	}

	addVertex(v){
		_verts = _verts || []

		_verts.add(v)
	}

	addNormal(n){
		_norms = _norms || []

		_norms.add(n)
	}

	addFace(f){
		_faces = _faces || []

		_faces.add(f)
	}
}
