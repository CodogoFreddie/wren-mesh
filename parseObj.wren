import "io" for File

import "./face" for Face
import "./material" for Material
import "./mesh" for Mesh
import "./normal" for Normal
import "./vertex" for Vertex

class ParseObj {

	construct fromFile(filename){
		_filename = filename
		_vertBaseIndex = 0
		_normBaseIndex = 0

		var sourceLines = File.read(filename).split("\n")

		for(line in sourceLines){
			if(line.startsWith("mtllib ")){
				parseMaterial(line)
			}

			if(line.startsWith("usemtl ")){
				parseUseMaterial(line)
			}

			if(line.startsWith("o ")){
				parseMesh(line)
			}

			if(line.startsWith("v ")){
				parseVertex(line)
			}

			if(line.startsWith("vn ")){
				parseNormal(line)
			}

			if(line.startsWith("s ")){
				parseSmoothing(line)
			}

			if(line.startsWith("f ")){
				parseFace(line)
			}
		}

		System.print(_meshes)
	}

	parseMaterial(line){
		/*System.print("parse material: %(line)")*/
		var materialSourceLines = File.read(line[7..-1]).split("\n")

		for(line in materialSourceLines){
			if(line.startsWith("newmtl ")){
				var newMaterial = Material.new(line[7..-1])
				_materials = _materials || {}
				_materials[newMaterial.name] = newMaterial
			}
		}
	}

	parseUseMaterial(line){
		System.print("parse use material: %(line)")
	}

	parseMesh(line){
		System.print("parse mesh: %(line)")
		var newMesh = Mesh.new(line[2..-1])

		_meshes = _meshes || []
	
		if(!_meshes.isEmpty){
			System.print("dwdwadwd%(_meshes)")
			_vertBaseIndex = _vertBaseIndex + _meshes[-1].verts.count
			_normBaseIndex = _normBaseIndex + _meshes[-1].norms.count
		}
		_meshes.add(newMesh)
	}

	parseVertex(line){
		System.print("parse vertex: %(line)")

		var values = line.split(" ")[1..-1].map { |s| Num.fromString(s) }.toList

		var newVertex = Vertex.new(values[0], values[1], values[2])

		_meshes[-1].addVertex(newVertex)
	}

	parseNormal(line){
		System.print("parse vertex normal: %(line)")
		var values = line.split(" ")[1..-1].map { |s| Num.fromString(s) }.toList

		var newNormal = Normal.new(values[0], values[1], values[2])

		_meshes[-1].addNormal(newNormal)
	}

	parseSmoothing(line){
		System.print("parse smoothing: %(line)")
	}

	parseFace(line){
		System.print("parse face: %(line)")
		var faceStrings = line[2..-1].split(" ")
		
		var face = Face.new()
		for( faceString in faceStrings ){
			var vals = faceString.split("/").map { |s| Num.fromString(s) }.toList

			face.addPoint(
				vals[0] - 1 - _vertBaseIndex,
				vals[2] - 1 - _normBaseIndex
			)
		}

		_meshes[-1].addFace(face)
	}

}
