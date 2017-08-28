import "./wren-vector/main" for Vector

class Vertex is Vector {
	toString { "v %(x) %(y) %(z)" }

	construct new(x, y, z){
		super(x, y, z)
	}
}
