classdef (CaseInsensitiveProperties) IYMatrix < DSS_MATLAB.Base
    % IYMatrix: DSS MATLAB interface class to DSS C-API
    % 
    % Properties:
    %    SystemYChanged - 
    %    UseAuxCurrents - 
    % 
    % Methods:
    %    GetCompressedYMatrix - Returns the circuit's YMatrix as a sparse MATLAB matrix
    %    ZeroInjCurr - 
    %    GetSourceInjCurrents - 
    %    GetPCInjCurr - 
    %    BuildYMatrixD - 
    %    AddInAuxCurrents - 
    %    GetIPointer - Get access to the internal Current pointer
    %    GetVPointer - Get access to the internal Voltage pointer
    %    SolveSystem - 
    %    getI - Get the data from the internal Current pointer
    %    getV - Get the data from the internal Voltage pointer

    properties
        SystemYChanged
        UseAuxCurrents
    end

    methods (Access = public)
        function obj = IYMatrix(apiutil)
            obj@DSS_MATLAB.Base(apiutil);
        end

        function result = GetCompressedYMatrix(obj, factor)
            % Returns the circuit's YMatrix as a sparse MATLAB matrix
            if (nargin < 2)
                factor = 0;
            end
            
            nBus = libpointer('uint32Ptr', 0);
            nNz = libpointer('uint32Ptr', 0);
            ColPtr = libpointer('int32PtrPtr');
            RowIdxPtr = libpointer('int32PtrPtr');
            cValsPtr = libpointer('doublePtrPtr');
            calllib(obj.libname, 'YMatrix_GetCompressedYMatrix', factor, nBus, nNz, ColPtr, RowIdxPtr, cValsPtr);
            obj.CheckForError;
            if ((~nBus.Value(1) || ~nNz.Value(1)))
                result = 0;
                return
            else
                setdatatype(ColPtr.Value, 'int32Ptr', 1, nBus.Value(1) + 1);
                setdatatype(RowIdxPtr.Value, 'int32Ptr', 1, nNz.Value(1));
                setdatatype(cValsPtr.Value, 'doublePtr', 1, nNz.Value(1) * 2);
                vals = cValsPtr.Value(1:2:end) + 1j * cValsPtr.Value(2:2:end);

                % We need to decompress the columns
                ColPtrValues = ColPtr.Value + 1;
                cols = zeros(1, nNz.Value(1));
                for col=1:nBus.Value(1)
                    cols(ColPtrValues(col):ColPtrValues(col+1)-1) = col;
                end
                
                result = sparse(double(RowIdxPtr.Value) + 1, cols, vals);
                calllib(obj.libname, 'DSS_Dispose_PInteger', ColPtr);
                calllib(obj.libname, 'DSS_Dispose_PInteger', RowIdxPtr);
                calllib(obj.libname, 'DSS_Dispose_PDouble', cValsPtr);
            end
        end

        function obj = ZeroInjCurr(obj)
            calllib(obj.libname, 'YMatrix_ZeroInjCurr');
        end

        function obj = GetSourceInjCurrents(obj)
            calllib(obj.libname, 'YMatrix_GetSourceInjCurrents');
        end

        function obj = GetPCInjCurr(obj)
            calllib(obj.libname, 'YMatrix_GetPCInjCurr');
        end

        function obj = BuildYMatrixD(obj, BuildOps, AllocateVI)
            calllib(obj.libname, 'YMatrix_BuildYMatrixD', BuildOps, AllocateVI);
        end

        function obj = AddInAuxCurrents(obj, SType)
            calllib(obj.libname, 'YMatrix_AddInAuxCurrents', SType);
        end

        function result = GetIPointer(obj)
            % Get access to the internal Current pointer
            IvectorPtr = libpointer('doublePtrPtr');
            numNodes = (calllib(obj.libname, 'Circuit_Get_NumNodes') + 1) * 2;
            calllib(obj.libname, 'YMatrix_getIpointer', IvectorPtr);
            setdatatype(IvectorPtr.Value, 'doublePtr', 1, numNodes);
            result = IvectorPtr;
        end
 
        function result = GetVPointer(obj)
            % Get access to the internal Voltage pointer
            VvectorPtr = libpointer('doublePtrPtr');
            numNodes = (calllib(obj.libname, 'Circuit_Get_NumNodes') + 1) * 2;
            calllib(obj.libname, 'YMatrix_getVpointer', VvectorPtr);
            setdatatype(VvectorPtr.Value, 'doublePtr', 1, numNodes);
            result = VvectorPtr;
        end
 
        function result = SolveSystem(obj, NodeV)
            result = calllib(obj.libname, 'YMatrix_SolveSystem', NodeV);
            obj.CheckForError();
        end

        function result = getYSparse(obj)
            result = obj.GetCompressedYMatrix;
        end

        function result = getI(obj)
            % Get the data from the internal Current pointer
            result = obj.IPointer.Value;
        end

        function result = getV(obj)
            % Get the data from the internal Voltage pointer
            result = obj.VPointer.Value;
        end
    end
    
    methods
        
        function result = get.SystemYChanged(obj)
            result = calllib(obj.libname, 'YMatrix_Get_SystemYChanged') ~= 0;
        end
        function obj = set.SystemYChanged(obj, value)
            calllib(obj.libname, 'YMatrix_Set_SystemYChanged', value);
            obj.CheckForError();
        end

        function result = get.UseAuxCurrents(obj)
            result = calllib(obj.libname, 'YMatrix_Get_UseAuxCurrents') ~= 0;
        end
        function obj = set.UseAuxCurrents(obj, value)
            calllib(obj.libname, 'YMatrix_Set_UseAuxCurrents', value);
            obj.CheckForError();
        end
        
    end
end