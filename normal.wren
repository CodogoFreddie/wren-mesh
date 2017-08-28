import "./wren-vector/main" for Vector

class Normal is Vector {
	toString { "vn %(x) %(y) %(z)" }

	construct new(x, y, z){
		super(x, y, z)
	}
}

