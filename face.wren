class FaceVertex {
	toString { "%(_posI + 1)//%(_norI + 1)" }

	construct new(posI, norI){
		_posI = posI
		_norI = norI
	}
}

class Face {
	toString { "f %(_verts.join(" "))" }
	construct new(){ }

	addPoint(posI, norI){
		_verts = _verts || []

		_verts.add( FaceVertex.new( posI, norI ) )
	}
}
