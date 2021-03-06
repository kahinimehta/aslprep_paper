function [V, F, Description] = read_freesurfer_surface(FileName)

if(exist(FileName, 'file') ~= 2)
	error([FileName ' is not a regular file']);
end

FID = fopen(FileName, 'r', 'b');

A = fread(FID, 1, 'bit24=>int32', 0);

if A == -2
	FileFormat = 'binary';
else
	% then we dont have a binary format surface
	% look for the ascii header
	fseek(FID, 0, 'bof');
	A = fread(FID, 2, '*char');
	if strcmp(A', '#!') == 1
		FileFormat = 'ascii';
	else
		error('File format not recognised');
	end
end

% BINARY FORMAT
%
%Location (byte)
% 	Item 	
% 
% Type
% 	Comment
% 0 	FileTypeId 	Int3 	"Magic" number identifies file format. TRIANGLE_FILE_MAGIC_NUMBER = (-2 & 0x00ffffff)
% 3 	Creator, User 	String 	"created by %s on %s\n", user, time_str (Note: this field is variable length, which means remainder of data is in positions that differ from one such file to another).
% Update 2004-02-25: I had previously thought this field was null terminated, as it's always followed by a null (0) byte. However, files I produce with this fulfilled are incorrectly read by various FreeSurfer software. It appears that files generated by FS programs have this comment terminated by two "\n" characters (0x0A), and that FS's loader must be looking for one or two of those.
% This, by the way, makes the following field more sensible.
% ? 	VertexCount 	Int4 	Count of vertices.
% Note: I previously thought this field was an Int3, preceded by the null terminator of the preceding string field. However this appears not to be the case (see description of preceding field.)
% ? 	FaceCount 	Int4 	Count of triangles
% VertexCount of 	R A S 	F4, F4, F4 	4-byte floats specifying Right, Anterior, Superior
% 
% FaceCount of v0 v1 v2 Int4, Int4, Int4 	 
	
switch(FileFormat)
	case 'binary'
		Description = fgets(FID);
		Description = deblank(Description);
		P = ftell(FID);
		Dummy = fread(FID, 1, '*char');
		if Dummy ~= 10 % newline
			fseek(FID, P, 'bof');
		end
		
		NumVertices = fread(FID, 1, 'int32');
		NumFaces = fread(FID, 1, 'int32');
		V = fread(FID, NumVertices * 3, 'single');
		V = reshape(V, 3, NumVertices);
		V = V';
		F = fread(FID, NumFaces * 3, 'int32');
		F = reshape(F, 3, NumFaces);
		F = F';
		F = F + 1;
	case 'ascii'
		Description = fgets(FID);
		Description = deblank(Description);
		A = fscanf(FID, '%d %d\n', 2);
		NumVertices = A(1);
		NumFaces = A(2);
		V = fscanf(FID, '%f %f %f %d\n', 4 * NumVertices);
		V = reshape(V, 4, NumVertices);
		V = V(1:3, :)';
		F = fscanf(FID, '%f %f %f %d\n', 4 * NumFaces);
		F = reshape(F, 4, NumFaces);
		F = F(1:3, :)';
		F = F + 1;
end
fclose(FID);