using System;

namespace Strawberry {
    class GL {
        public function void* GetProcAddressFunc(StringView procname);

        public const uint GL_DEPTH_BUFFER_BIT = 0x00000100;
        public const uint GL_STENCIL_BUFFER_BIT = 0x00000400;
        public const uint GL_COLOR_BUFFER_BIT = 0x00004000;
        public const uint GL_FALSE = 0;
        public const uint GL_TRUE = 1;
        public const uint GL_POINTS = 0x0000;
        public const uint GL_LINES = 0x0001;
        public const uint GL_LINE_LOOP = 0x0002;
        public const uint GL_LINE_STRIP = 0x0003;
        public const uint GL_TRIANGLES = 0x0004;
        public const uint GL_TRIANGLE_STRIP = 0x0005;
        public const uint GL_TRIANGLE_FAN = 0x0006;
        public const uint GL_NEVER = 0x0200;
        public const uint GL_LESS = 0x0201;
        public const uint GL_EQUAL = 0x0202;
        public const uint GL_LEQUAL = 0x0203;
        public const uint GL_GREATER = 0x0204;
        public const uint GL_NOTEQUAL = 0x0205;
        public const uint GL_GEQUAL = 0x0206;
        public const uint GL_ALWAYS = 0x0207;
        public const uint GL_ZERO = 0;
        public const uint GL_ONE = 1;
        public const uint GL_SRC_COLOR = 0x0300;
        public const uint GL_ONE_MINUS_SRC_COLOR = 0x0301;
        public const uint GL_SRC_ALPHA = 0x0302;
        public const uint GL_ONE_MINUS_SRC_ALPHA = 0x0303;
        public const uint GL_DST_ALPHA = 0x0304;
        public const uint GL_ONE_MINUS_DST_ALPHA = 0x0305;
        public const uint GL_DST_COLOR = 0x0306;
        public const uint GL_ONE_MINUS_DST_COLOR = 0x0307;
        public const uint GL_SRC_ALPHA_SATURATE = 0x0308;
        public const uint GL_NONE = 0;
        public const uint GL_FRONT_LEFT = 0x0400;
        public const uint GL_FRONT_RIGHT = 0x0401;
        public const uint GL_BACK_LEFT = 0x0402;
        public const uint GL_BACK_RIGHT = 0x0403;
        public const uint GL_FRONT = 0x0404;
        public const uint GL_BACK = 0x0405;
        public const uint GL_LEFT = 0x0406;
        public const uint GL_RIGHT = 0x0407;
        public const uint GL_FRONT_AND_BACK = 0x0408;
        public const uint GL_NO_ERROR = 0;
        public const uint GL_INVALID_ENUM = 0x0500;
        public const uint GL_INVALID_VALUE = 0x0501;
        public const uint GL_INVALID_OPERATION = 0x0502;
        public const uint GL_OUT_OF_MEMORY = 0x0505;
        public const uint GL_CW = 0x0900;
        public const uint GL_CCW = 0x0901;
        public const uint GL_POINT_SIZE = 0x0B11;
        public const uint GL_POINT_SIZE_RANGE = 0x0B12;
        public const uint GL_POINT_SIZE_GRANULARITY = 0x0B13;
        public const uint GL_LINE_SMOOTH = 0x0B20;
        public const uint GL_LINE_WIDTH = 0x0B21;
        public const uint GL_LINE_WIDTH_RANGE = 0x0B22;
        public const uint GL_LINE_WIDTH_GRANULARITY = 0x0B23;
        public const uint GL_POLYGON_MODE = 0x0B40;
        public const uint GL_POLYGON_SMOOTH = 0x0B41;
        public const uint GL_CULL_FACE = 0x0B44;
        public const uint GL_CULL_FACE_MODE = 0x0B45;
        public const uint GL_FRONT_FACE = 0x0B46;
        public const uint GL_DEPTH_RANGE = 0x0B70;
        public const uint GL_DEPTH_TEST = 0x0B71;
        public const uint GL_DEPTH_WRITEMASK = 0x0B72;
        public const uint GL_DEPTH_CLEAR_VALUE = 0x0B73;
        public const uint GL_DEPTH_FUNC = 0x0B74;
        public const uint GL_STENCIL_TEST = 0x0B90;
        public const uint GL_STENCIL_CLEAR_VALUE = 0x0B91;
        public const uint GL_STENCIL_FUNC = 0x0B92;
        public const uint GL_STENCIL_VALUE_MASK = 0x0B93;
        public const uint GL_STENCIL_FAIL = 0x0B94;
        public const uint GL_STENCIL_PASS_DEPTH_FAIL = 0x0B95;
        public const uint GL_STENCIL_PASS_DEPTH_PASS = 0x0B96;
        public const uint GL_STENCIL_REF = 0x0B97;
        public const uint GL_STENCIL_WRITEMASK = 0x0B98;
        public const uint GL_VIEWPORT = 0x0BA2;
        public const uint GL_DITHER = 0x0BD0;
        public const uint GL_BLEND_DST = 0x0BE0;
        public const uint GL_BLEND_SRC = 0x0BE1;
        public const uint GL_BLEND = 0x0BE2;
        public const uint GL_LOGIC_OP_MODE = 0x0BF0;
        public const uint GL_DRAW_BUFFER = 0x0C01;
        public const uint GL_READ_BUFFER = 0x0C02;
        public const uint GL_SCISSOR_BOX = 0x0C10;
        public const uint GL_SCISSOR_TEST = 0x0C11;
        public const uint GL_COLOR_CLEAR_VALUE = 0x0C22;
        public const uint GL_COLOR_WRITEMASK = 0x0C23;
        public const uint GL_DOUBLEBUFFER = 0x0C32;
        public const uint GL_STEREO = 0x0C33;
        public const uint GL_LINE_SMOOTH_HINT = 0x0C52;
        public const uint GL_POLYGON_SMOOTH_HINT = 0x0C53;
        public const uint GL_UNPACK_SWAP_BYTES = 0x0CF0;
        public const uint GL_UNPACK_LSB_FIRST = 0x0CF1;
        public const uint GL_UNPACK_ROW_LENGTH = 0x0CF2;
        public const uint GL_UNPACK_SKIP_ROWS = 0x0CF3;
        public const uint GL_UNPACK_SKIP_PIXELS = 0x0CF4;
        public const uint GL_UNPACK_ALIGNMENT = 0x0CF5;
        public const uint GL_PACK_SWAP_BYTES = 0x0D00;
        public const uint GL_PACK_LSB_FIRST = 0x0D01;
        public const uint GL_PACK_ROW_LENGTH = 0x0D02;
        public const uint GL_PACK_SKIP_ROWS = 0x0D03;
        public const uint GL_PACK_SKIP_PIXELS = 0x0D04;
        public const uint GL_PACK_ALIGNMENT = 0x0D05;
        public const uint GL_MAX_TEXTURE_SIZE = 0x0D33;
        public const uint GL_MAX_VIEWPORT_DIMS = 0x0D3A;
        public const uint GL_SUBPIXEL_BITS = 0x0D50;
        public const uint GL_TEXTURE_1D = 0x0DE0;
        public const uint GL_TEXTURE_2D = 0x0DE1;
        public const uint GL_TEXTURE_WIDTH = 0x1000;
        public const uint GL_TEXTURE_HEIGHT = 0x1001;
        public const uint GL_TEXTURE_BORDER_COLOR = 0x1004;
        public const uint GL_DONT_CARE = 0x1100;
        public const uint GL_FASTEST = 0x1101;
        public const uint GL_NICEST = 0x1102;
        public const uint GL_BYTE = 0x1400;
        public const uint GL_UNSIGNED_BYTE = 0x1401;
        public const uint GL_SHORT = 0x1402;
        public const uint GL_UNSIGNED_SHORT = 0x1403;
        public const uint GL_INT = 0x1404;
        public const uint GL_UNSIGNED_INT = 0x1405;
        public const uint GL_FLOAT = 0x1406;
        public const uint GL_CLEAR = 0x1500;
        public const uint GL_AND = 0x1501;
        public const uint GL_AND_REVERSE = 0x1502;
        public const uint GL_COPY = 0x1503;
        public const uint GL_AND_INVERTED = 0x1504;
        public const uint GL_NOOP = 0x1505;
        public const uint GL_XOR = 0x1506;
        public const uint GL_OR = 0x1507;
        public const uint GL_NOR = 0x1508;
        public const uint GL_EQUIV = 0x1509;
        public const uint GL_INVERT = 0x150A;
        public const uint GL_OR_REVERSE = 0x150B;
        public const uint GL_COPY_INVERTED = 0x150C;
        public const uint GL_OR_INVERTED = 0x150D;
        public const uint GL_NAND = 0x150E;
        public const uint GL_SET = 0x150F;
        public const uint GL_TEXTURE = 0x1702;
        public const uint GL_COLOR = 0x1800;
        public const uint GL_DEPTH = 0x1801;
        public const uint GL_STENCIL = 0x1802;
        public const uint GL_STENCIL_INDEX = 0x1901;
        public const uint GL_DEPTH_COMPONENT = 0x1902;
        public const uint GL_RED = 0x1903;
        public const uint GL_GREEN = 0x1904;
        public const uint GL_BLUE = 0x1905;
        public const uint GL_ALPHA = 0x1906;
        public const uint GL_RGB = 0x1907;
        public const uint GL_RGBA = 0x1908;
        public const uint GL_POINT = 0x1B00;
        public const uint GL_LINE = 0x1B01;
        public const uint GL_FILL = 0x1B02;
        public const uint GL_KEEP = 0x1E00;
        public const uint GL_REPLACE = 0x1E01;
        public const uint GL_INCR = 0x1E02;
        public const uint GL_DECR = 0x1E03;
        public const uint GL_VENDOR = 0x1F00;
        public const uint GL_RENDERER = 0x1F01;
        public const uint GL_VERSION = 0x1F02;
        public const uint GL_EXTENSIONS = 0x1F03;
        public const uint GL_NEAREST = 0x2600;
        public const uint GL_LINEAR = 0x2601;
        public const uint GL_NEAREST_MIPMAP_NEAREST = 0x2700;
        public const uint GL_LINEAR_MIPMAP_NEAREST = 0x2701;
        public const uint GL_NEAREST_MIPMAP_LINEAR = 0x2702;
        public const uint GL_LINEAR_MIPMAP_LINEAR = 0x2703;
        public const uint GL_TEXTURE_MAG_FILTER = 0x2800;
        public const uint GL_TEXTURE_MIN_FILTER = 0x2801;
        public const uint GL_TEXTURE_WRAP_S = 0x2802;
        public const uint GL_TEXTURE_WRAP_T = 0x2803;
        public const uint GL_REPEAT = 0x2901;
        public const uint GL_COLOR_LOGIC_OP = 0x0BF2;
        public const uint GL_POLYGON_OFFSET_UNITS = 0x2A00;
        public const uint GL_POLYGON_OFFSET_POINT = 0x2A01;
        public const uint GL_POLYGON_OFFSET_LINE = 0x2A02;
        public const uint GL_POLYGON_OFFSET_FILL = 0x8037;
        public const uint GL_POLYGON_OFFSET_FACTOR = 0x8038;
        public const uint GL_TEXTURE_BINDING_1D = 0x8068;
        public const uint GL_TEXTURE_BINDING_2D = 0x8069;
        public const uint GL_TEXTURE_INTERNAL_FORMAT = 0x1003;
        public const uint GL_TEXTURE_RED_SIZE = 0x805C;
        public const uint GL_TEXTURE_GREEN_SIZE = 0x805D;
        public const uint GL_TEXTURE_BLUE_SIZE = 0x805E;
        public const uint GL_TEXTURE_ALPHA_SIZE = 0x805F;
        public const uint GL_DOUBLE = 0x140A;
        public const uint GL_PROXY_TEXTURE_1D = 0x8063;
        public const uint GL_PROXY_TEXTURE_2D = 0x8064;
        public const uint GL_R3_G3_B2 = 0x2A10;
        public const uint GL_RGB4 = 0x804F;
        public const uint GL_RGB5 = 0x8050;
        public const uint GL_RGB8 = 0x8051;
        public const uint GL_RGB10 = 0x8052;
        public const uint GL_RGB12 = 0x8053;
        public const uint GL_RGB16 = 0x8054;
        public const uint GL_RGBA2 = 0x8055;
        public const uint GL_RGBA4 = 0x8056;
        public const uint GL_RGB5_A1 = 0x8057;
        public const uint GL_RGBA8 = 0x8058;
        public const uint GL_RGB10_A2 = 0x8059;
        public const uint GL_RGBA12 = 0x805A;
        public const uint GL_RGBA16 = 0x805B;
        public const uint GL_UNSIGNED_BYTE_3_3_2 = 0x8032;
        public const uint GL_UNSIGNED_SHORT_4_4_4_4 = 0x8033;
        public const uint GL_UNSIGNED_SHORT_5_5_5_1 = 0x8034;
        public const uint GL_UNSIGNED_INT_8_8_8_8 = 0x8035;
        public const uint GL_UNSIGNED_INT_10_10_10_2 = 0x8036;
        public const uint GL_TEXTURE_BINDING_3D = 0x806A;
        public const uint GL_PACK_SKIP_IMAGES = 0x806B;
        public const uint GL_PACK_IMAGE_HEIGHT = 0x806C;
        public const uint GL_UNPACK_SKIP_IMAGES = 0x806D;
        public const uint GL_UNPACK_IMAGE_HEIGHT = 0x806E;
        public const uint GL_TEXTURE_3D = 0x806F;
        public const uint GL_PROXY_TEXTURE_3D = 0x8070;
        public const uint GL_TEXTURE_DEPTH = 0x8071;
        public const uint GL_TEXTURE_WRAP_R = 0x8072;
        public const uint GL_MAX_3D_TEXTURE_SIZE = 0x8073;
        public const uint GL_UNSIGNED_BYTE_2_3_3_REV = 0x8362;
        public const uint GL_UNSIGNED_SHORT_5_6_5 = 0x8363;
        public const uint GL_UNSIGNED_SHORT_5_6_5_REV = 0x8364;
        public const uint GL_UNSIGNED_SHORT_4_4_4_4_REV = 0x8365;
        public const uint GL_UNSIGNED_SHORT_1_5_5_5_REV = 0x8366;
        public const uint GL_UNSIGNED_INT_8_8_8_8_REV = 0x8367;
        public const uint GL_UNSIGNED_INT_2_10_10_10_REV = 0x8368;
        public const uint GL_BGR = 0x80E0;
        public const uint GL_BGRA = 0x80E1;
        public const uint GL_MAX_ELEMENTS_VERTICES = 0x80E8;
        public const uint GL_MAX_ELEMENTS_INDICES = 0x80E9;
        public const uint GL_CLAMP_TO_EDGE = 0x812F;
        public const uint GL_TEXTURE_MIN_LOD = 0x813A;
        public const uint GL_TEXTURE_MAX_LOD = 0x813B;
        public const uint GL_TEXTURE_BASE_LEVEL = 0x813C;
        public const uint GL_TEXTURE_MAX_LEVEL = 0x813D;
        public const uint GL_SMOOTH_POINT_SIZE_RANGE = 0x0B12;
        public const uint GL_SMOOTH_POINT_SIZE_GRANULARITY = 0x0B13;
        public const uint GL_SMOOTH_LINE_WIDTH_RANGE = 0x0B22;
        public const uint GL_SMOOTH_LINE_WIDTH_GRANULARITY = 0x0B23;
        public const uint GL_ALIASED_LINE_WIDTH_RANGE = 0x846E;
        public const uint GL_TEXTURE0 = 0x84C0;
        public const uint GL_TEXTURE1 = 0x84C1;
        public const uint GL_TEXTURE2 = 0x84C2;
        public const uint GL_TEXTURE3 = 0x84C3;
        public const uint GL_TEXTURE4 = 0x84C4;
        public const uint GL_TEXTURE5 = 0x84C5;
        public const uint GL_TEXTURE6 = 0x84C6;
        public const uint GL_TEXTURE7 = 0x84C7;
        public const uint GL_TEXTURE8 = 0x84C8;
        public const uint GL_TEXTURE9 = 0x84C9;
        public const uint GL_TEXTURE10 = 0x84CA;
        public const uint GL_TEXTURE11 = 0x84CB;
        public const uint GL_TEXTURE12 = 0x84CC;
        public const uint GL_TEXTURE13 = 0x84CD;
        public const uint GL_TEXTURE14 = 0x84CE;
        public const uint GL_TEXTURE15 = 0x84CF;
        public const uint GL_TEXTURE16 = 0x84D0;
        public const uint GL_TEXTURE17 = 0x84D1;
        public const uint GL_TEXTURE18 = 0x84D2;
        public const uint GL_TEXTURE19 = 0x84D3;
        public const uint GL_TEXTURE20 = 0x84D4;
        public const uint GL_TEXTURE21 = 0x84D5;
        public const uint GL_TEXTURE22 = 0x84D6;
        public const uint GL_TEXTURE23 = 0x84D7;
        public const uint GL_TEXTURE24 = 0x84D8;
        public const uint GL_TEXTURE25 = 0x84D9;
        public const uint GL_TEXTURE26 = 0x84DA;
        public const uint GL_TEXTURE27 = 0x84DB;
        public const uint GL_TEXTURE28 = 0x84DC;
        public const uint GL_TEXTURE29 = 0x84DD;
        public const uint GL_TEXTURE30 = 0x84DE;
        public const uint GL_TEXTURE31 = 0x84DF;
        public const uint GL_ACTIVE_TEXTURE = 0x84E0;
        public const uint GL_MULTISAMPLE = 0x809D;
        public const uint GL_SAMPLE_ALPHA_TO_COVERAGE = 0x809E;
        public const uint GL_SAMPLE_ALPHA_TO_ONE = 0x809F;
        public const uint GL_SAMPLE_COVERAGE = 0x80A0;
        public const uint GL_SAMPLE_BUFFERS = 0x80A8;
        public const uint GL_SAMPLES = 0x80A9;
        public const uint GL_SAMPLE_COVERAGE_VALUE = 0x80AA;
        public const uint GL_SAMPLE_COVERAGE_INVERT = 0x80AB;
        public const uint GL_TEXTURE_CUBE_MAP = 0x8513;
        public const uint GL_TEXTURE_BINDING_CUBE_MAP = 0x8514;
        public const uint GL_TEXTURE_CUBE_MAP_POSITIVE_X = 0x8515;
        public const uint GL_TEXTURE_CUBE_MAP_NEGATIVE_X = 0x8516;
        public const uint GL_TEXTURE_CUBE_MAP_POSITIVE_Y = 0x8517;
        public const uint GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = 0x8518;
        public const uint GL_TEXTURE_CUBE_MAP_POSITIVE_Z = 0x8519;
        public const uint GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = 0x851A;
        public const uint GL_PROXY_TEXTURE_CUBE_MAP = 0x851B;
        public const uint GL_MAX_CUBE_MAP_TEXTURE_SIZE = 0x851C;
        public const uint GL_COMPRESSED_RGB = 0x84ED;
        public const uint GL_COMPRESSED_RGBA = 0x84EE;
        public const uint GL_TEXTURE_COMPRESSION_HINT = 0x84EF;
        public const uint GL_TEXTURE_COMPRESSED_IMAGE_SIZE = 0x86A0;
        public const uint GL_TEXTURE_COMPRESSED = 0x86A1;
        public const uint GL_NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2;
        public const uint GL_COMPRESSED_TEXTURE_FORMATS = 0x86A3;
        public const uint GL_CLAMP_TO_BORDER = 0x812D;
        public const uint GL_BLEND_DST_RGB = 0x80C8;
        public const uint GL_BLEND_SRC_RGB = 0x80C9;
        public const uint GL_BLEND_DST_ALPHA = 0x80CA;
        public const uint GL_BLEND_SRC_ALPHA = 0x80CB;
        public const uint GL_POINT_FADE_THRESHOLD_SIZE = 0x8128;
        public const uint GL_DEPTH_COMPONENT16 = 0x81A5;
        public const uint GL_DEPTH_COMPONENT24 = 0x81A6;
        public const uint GL_DEPTH_COMPONENT32 = 0x81A7;
        public const uint GL_MIRRORED_REPEAT = 0x8370;
        public const uint GL_MAX_TEXTURE_LOD_BIAS = 0x84FD;
        public const uint GL_TEXTURE_LOD_BIAS = 0x8501;
        public const uint GL_INCR_WRAP = 0x8507;
        public const uint GL_DECR_WRAP = 0x8508;
        public const uint GL_TEXTURE_DEPTH_SIZE = 0x884A;
        public const uint GL_TEXTURE_COMPARE_MODE = 0x884C;
        public const uint GL_TEXTURE_COMPARE_FUNC = 0x884D;
        public const uint GL_BLEND_COLOR = 0x8005;
        public const uint GL_BLEND_EQUATION = 0x8009;
        public const uint GL_CONSTANT_COLOR = 0x8001;
        public const uint GL_ONE_MINUS_CONSTANT_COLOR = 0x8002;
        public const uint GL_CONSTANT_ALPHA = 0x8003;
        public const uint GL_ONE_MINUS_CONSTANT_ALPHA = 0x8004;
        public const uint GL_FUNC_ADD = 0x8006;
        public const uint GL_FUNC_REVERSE_SUBTRACT = 0x800B;
        public const uint GL_FUNC_SUBTRACT = 0x800A;
        public const uint GL_MIN = 0x8007;
        public const uint GL_MAX = 0x8008;
        public const uint GL_BUFFER_SIZE = 0x8764;
        public const uint GL_BUFFER_USAGE = 0x8765;
        public const uint GL_QUERY_COUNTER_BITS = 0x8864;
        public const uint GL_CURRENT_QUERY = 0x8865;
        public const uint GL_QUERY_RESULT = 0x8866;
        public const uint GL_QUERY_RESULT_AVAILABLE = 0x8867;
        public const uint GL_ARRAY_BUFFER = 0x8892;
        public const uint GL_ELEMENT_ARRAY_BUFFER = 0x8893;
        public const uint GL_ARRAY_BUFFER_BINDING = 0x8894;
        public const uint GL_ELEMENT_ARRAY_BUFFER_BINDING = 0x8895;
        public const uint GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F;
        public const uint GL_READ_ONLY = 0x88B8;
        public const uint GL_WRITE_ONLY = 0x88B9;
        public const uint GL_READ_WRITE = 0x88BA;
        public const uint GL_BUFFER_ACCESS = 0x88BB;
        public const uint GL_BUFFER_MAPPED = 0x88BC;
        public const uint GL_BUFFER_MAP_POINTER = 0x88BD;
        public const uint GL_STREAM_DRAW = 0x88E0;
        public const uint GL_STREAM_READ = 0x88E1;
        public const uint GL_STREAM_COPY = 0x88E2;
        public const uint GL_STATIC_DRAW = 0x88E4;
        public const uint GL_STATIC_READ = 0x88E5;
        public const uint GL_STATIC_COPY = 0x88E6;
        public const uint GL_DYNAMIC_DRAW = 0x88E8;
        public const uint GL_DYNAMIC_READ = 0x88E9;
        public const uint GL_DYNAMIC_COPY = 0x88EA;
        public const uint GL_SAMPLES_PASSED = 0x8914;
        public const uint GL_SRC1_ALPHA = 0x8589;
        public const uint GL_BLEND_EQUATION_RGB = 0x8009;
        public const uint GL_VERTEX_ATTRIB_ARRAY_ENABLED = 0x8622;
        public const uint GL_VERTEX_ATTRIB_ARRAY_SIZE = 0x8623;
        public const uint GL_VERTEX_ATTRIB_ARRAY_STRIDE = 0x8624;
        public const uint GL_VERTEX_ATTRIB_ARRAY_TYPE = 0x8625;
        public const uint GL_CURRENT_VERTEX_ATTRIB = 0x8626;
        public const uint GL_VERTEX_PROGRAM_POINT_SIZE = 0x8642;
        public const uint GL_VERTEX_ATTRIB_ARRAY_POINTER = 0x8645;
        public const uint GL_STENCIL_BACK_FUNC = 0x8800;
        public const uint GL_STENCIL_BACK_FAIL = 0x8801;
        public const uint GL_STENCIL_BACK_PASS_DEPTH_FAIL = 0x8802;
        public const uint GL_STENCIL_BACK_PASS_DEPTH_PASS = 0x8803;
        public const uint GL_MAX_DRAW_BUFFERS = 0x8824;
        public const uint GL_DRAW_BUFFER0 = 0x8825;
        public const uint GL_DRAW_BUFFER1 = 0x8826;
        public const uint GL_DRAW_BUFFER2 = 0x8827;
        public const uint GL_DRAW_BUFFER3 = 0x8828;
        public const uint GL_DRAW_BUFFER4 = 0x8829;
        public const uint GL_DRAW_BUFFER5 = 0x882A;
        public const uint GL_DRAW_BUFFER6 = 0x882B;
        public const uint GL_DRAW_BUFFER7 = 0x882C;
        public const uint GL_DRAW_BUFFER8 = 0x882D;
        public const uint GL_DRAW_BUFFER9 = 0x882E;
        public const uint GL_DRAW_BUFFER10 = 0x882F;
        public const uint GL_DRAW_BUFFER11 = 0x8830;
        public const uint GL_DRAW_BUFFER12 = 0x8831;
        public const uint GL_DRAW_BUFFER13 = 0x8832;
        public const uint GL_DRAW_BUFFER14 = 0x8833;
        public const uint GL_DRAW_BUFFER15 = 0x8834;
        public const uint GL_BLEND_EQUATION_ALPHA = 0x883D;
        public const uint GL_MAX_VERTEX_ATTRIBS = 0x8869;
        public const uint GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = 0x886A;
        public const uint GL_MAX_TEXTURE_IMAGE_UNITS = 0x8872;
        public const uint GL_FRAGMENT_SHADER = 0x8B30;
        public const uint GL_VERTEX_SHADER = 0x8B31;
        public const uint GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = 0x8B49;
        public const uint GL_MAX_VERTEX_UNIFORM_COMPONENTS = 0x8B4A;
        public const uint GL_MAX_VARYING_FLOATS = 0x8B4B;
        public const uint GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C;
        public const uint GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D;
        public const uint GL_SHADER_TYPE = 0x8B4F;
        public const uint GL_FLOAT_VEC2 = 0x8B50;
        public const uint GL_FLOAT_VEC3 = 0x8B51;
        public const uint GL_FLOAT_VEC4 = 0x8B52;
        public const uint GL_INT_VEC2 = 0x8B53;
        public const uint GL_INT_VEC3 = 0x8B54;
        public const uint GL_INT_VEC4 = 0x8B55;
        public const uint GL_BOOL = 0x8B56;
        public const uint GL_BOOL_VEC2 = 0x8B57;
        public const uint GL_BOOL_VEC3 = 0x8B58;
        public const uint GL_BOOL_VEC4 = 0x8B59;
        public const uint GL_FLOAT_MAT2 = 0x8B5A;
        public const uint GL_FLOAT_MAT3 = 0x8B5B;
        public const uint GL_FLOAT_MAT4 = 0x8B5C;
        public const uint GL_SAMPLER_1D = 0x8B5D;
        public const uint GL_SAMPLER_2D = 0x8B5E;
        public const uint GL_SAMPLER_3D = 0x8B5F;
        public const uint GL_SAMPLER_CUBE = 0x8B60;
        public const uint GL_SAMPLER_1D_SHADOW = 0x8B61;
        public const uint GL_SAMPLER_2D_SHADOW = 0x8B62;
        public const uint GL_DELETE_STATUS = 0x8B80;
        public const uint GL_COMPILE_STATUS = 0x8B81;
        public const uint GL_LINK_STATUS = 0x8B82;
        public const uint GL_VALIDATE_STATUS = 0x8B83;
        public const uint GL_INFO_LOG_LENGTH = 0x8B84;
        public const uint GL_ATTACHED_SHADERS = 0x8B85;
        public const uint GL_ACTIVE_UNIFORMS = 0x8B86;
        public const uint GL_ACTIVE_UNIFORM_MAX_LENGTH = 0x8B87;
        public const uint GL_SHADER_SOURCE_LENGTH = 0x8B88;
        public const uint GL_ACTIVE_ATTRIBUTES = 0x8B89;
        public const uint GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = 0x8B8A;
        public const uint GL_FRAGMENT_SHADER_DERIVATIVE_HINT = 0x8B8B;
        public const uint GL_SHADING_LANGUAGE_VERSION = 0x8B8C;
        public const uint GL_CURRENT_PROGRAM = 0x8B8D;
        public const uint GL_POINT_SPRITE_COORD_ORIGIN = 0x8CA0;
        public const uint GL_LOWER_LEFT = 0x8CA1;
        public const uint GL_UPPER_LEFT = 0x8CA2;
        public const uint GL_STENCIL_BACK_REF = 0x8CA3;
        public const uint GL_STENCIL_BACK_VALUE_MASK = 0x8CA4;
        public const uint GL_STENCIL_BACK_WRITEMASK = 0x8CA5;
        public const uint GL_PIXEL_PACK_BUFFER = 0x88EB;
        public const uint GL_PIXEL_UNPACK_BUFFER = 0x88EC;
        public const uint GL_PIXEL_PACK_BUFFER_BINDING = 0x88ED;
        public const uint GL_PIXEL_UNPACK_BUFFER_BINDING = 0x88EF;
        public const uint GL_FLOAT_MAT2x3 = 0x8B65;
        public const uint GL_FLOAT_MAT2x4 = 0x8B66;
        public const uint GL_FLOAT_MAT3x2 = 0x8B67;
        public const uint GL_FLOAT_MAT3x4 = 0x8B68;
        public const uint GL_FLOAT_MAT4x2 = 0x8B69;
        public const uint GL_FLOAT_MAT4x3 = 0x8B6A;
        public const uint GL_SRGB = 0x8C40;
        public const uint GL_SRGB8 = 0x8C41;
        public const uint GL_SRGB_ALPHA = 0x8C42;
        public const uint GL_SRGB8_ALPHA8 = 0x8C43;
        public const uint GL_COMPRESSED_SRGB = 0x8C48;
        public const uint GL_COMPRESSED_SRGB_ALPHA = 0x8C49;
        public const uint GL_COMPARE_REF_TO_TEXTURE = 0x884E;
        public const uint GL_CLIP_DISTANCE0 = 0x3000;
        public const uint GL_CLIP_DISTANCE1 = 0x3001;
        public const uint GL_CLIP_DISTANCE2 = 0x3002;
        public const uint GL_CLIP_DISTANCE3 = 0x3003;
        public const uint GL_CLIP_DISTANCE4 = 0x3004;
        public const uint GL_CLIP_DISTANCE5 = 0x3005;
        public const uint GL_CLIP_DISTANCE6 = 0x3006;
        public const uint GL_CLIP_DISTANCE7 = 0x3007;
        public const uint GL_MAX_CLIP_DISTANCES = 0x0D32;
        public const uint GL_MAJOR_VERSION = 0x821B;
        public const uint GL_MINOR_VERSION = 0x821C;
        public const uint GL_NUM_EXTENSIONS = 0x821D;
        public const uint GL_CONTEXT_FLAGS = 0x821E;
        public const uint GL_COMPRESSED_RED = 0x8225;
        public const uint GL_COMPRESSED_RG = 0x8226;
        public const uint GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = 0x00000001;
        public const uint GL_RGBA32F = 0x8814;
        public const uint GL_RGB32F = 0x8815;
        public const uint GL_RGBA16F = 0x881A;
        public const uint GL_RGB16F = 0x881B;
        public const uint GL_VERTEX_ATTRIB_ARRAY_INTEGER = 0x88FD;
        public const uint GL_MAX_ARRAY_TEXTURE_LAYERS = 0x88FF;
        public const uint GL_MIN_PROGRAM_TEXEL_OFFSET = 0x8904;
        public const uint GL_MAX_PROGRAM_TEXEL_OFFSET = 0x8905;
        public const uint GL_CLAMP_READ_COLOR = 0x891C;
        public const uint GL_FIXED_ONLY = 0x891D;
        public const uint GL_MAX_VARYING_COMPONENTS = 0x8B4B;
        public const uint GL_TEXTURE_1D_ARRAY = 0x8C18;
        public const uint GL_PROXY_TEXTURE_1D_ARRAY = 0x8C19;
        public const uint GL_TEXTURE_2D_ARRAY = 0x8C1A;
        public const uint GL_PROXY_TEXTURE_2D_ARRAY = 0x8C1B;
        public const uint GL_TEXTURE_BINDING_1D_ARRAY = 0x8C1C;
        public const uint GL_TEXTURE_BINDING_2D_ARRAY = 0x8C1D;
        public const uint GL_R11F_G11F_B10F = 0x8C3A;
        public const uint GL_UNSIGNED_INT_10F_11F_11F_REV = 0x8C3B;
        public const uint GL_RGB9_E5 = 0x8C3D;
        public const uint GL_UNSIGNED_INT_5_9_9_9_REV = 0x8C3E;
        public const uint GL_TEXTURE_SHARED_SIZE = 0x8C3F;
        public const uint GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = 0x8C76;
        public const uint GL_TRANSFORM_FEEDBACK_BUFFER_MODE = 0x8C7F;
        public const uint GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = 0x8C80;
        public const uint GL_TRANSFORM_FEEDBACK_VARYINGS = 0x8C83;
        public const uint GL_TRANSFORM_FEEDBACK_BUFFER_START = 0x8C84;
        public const uint GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = 0x8C85;
        public const uint GL_PRIMITIVES_GENERATED = 0x8C87;
        public const uint GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = 0x8C88;
        public const uint GL_RASTERIZER_DISCARD = 0x8C89;
        public const uint GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 0x8C8A;
        public const uint GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 0x8C8B;
        public const uint GL_INTERLEAVED_ATTRIBS = 0x8C8C;
        public const uint GL_SEPARATE_ATTRIBS = 0x8C8D;
        public const uint GL_TRANSFORM_FEEDBACK_BUFFER = 0x8C8E;
        public const uint GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = 0x8C8F;
        public const uint GL_RGBA32UI = 0x8D70;
        public const uint GL_RGB32UI = 0x8D71;
        public const uint GL_RGBA16UI = 0x8D76;
        public const uint GL_RGB16UI = 0x8D77;
        public const uint GL_RGBA8UI = 0x8D7C;
        public const uint GL_RGB8UI = 0x8D7D;
        public const uint GL_RGBA32I = 0x8D82;
        public const uint GL_RGB32I = 0x8D83;
        public const uint GL_RGBA16I = 0x8D88;
        public const uint GL_RGB16I = 0x8D89;
        public const uint GL_RGBA8I = 0x8D8E;
        public const uint GL_RGB8I = 0x8D8F;
        public const uint GL_RED_INTEGER = 0x8D94;
        public const uint GL_GREEN_INTEGER = 0x8D95;
        public const uint GL_BLUE_INTEGER = 0x8D96;
        public const uint GL_RGB_INTEGER = 0x8D98;
        public const uint GL_RGBA_INTEGER = 0x8D99;
        public const uint GL_BGR_INTEGER = 0x8D9A;
        public const uint GL_BGRA_INTEGER = 0x8D9B;
        public const uint GL_SAMPLER_1D_ARRAY = 0x8DC0;
        public const uint GL_SAMPLER_2D_ARRAY = 0x8DC1;
        public const uint GL_SAMPLER_1D_ARRAY_SHADOW = 0x8DC3;
        public const uint GL_SAMPLER_2D_ARRAY_SHADOW = 0x8DC4;
        public const uint GL_SAMPLER_CUBE_SHADOW = 0x8DC5;
        public const uint GL_UNSIGNED_INT_VEC2 = 0x8DC6;
        public const uint GL_UNSIGNED_INT_VEC3 = 0x8DC7;
        public const uint GL_UNSIGNED_INT_VEC4 = 0x8DC8;
        public const uint GL_INT_SAMPLER_1D = 0x8DC9;
        public const uint GL_INT_SAMPLER_2D = 0x8DCA;
        public const uint GL_INT_SAMPLER_3D = 0x8DCB;
        public const uint GL_INT_SAMPLER_CUBE = 0x8DCC;
        public const uint GL_INT_SAMPLER_1D_ARRAY = 0x8DCE;
        public const uint GL_INT_SAMPLER_2D_ARRAY = 0x8DCF;
        public const uint GL_UNSIGNED_INT_SAMPLER_1D = 0x8DD1;
        public const uint GL_UNSIGNED_INT_SAMPLER_2D = 0x8DD2;
        public const uint GL_UNSIGNED_INT_SAMPLER_3D = 0x8DD3;
        public const uint GL_UNSIGNED_INT_SAMPLER_CUBE = 0x8DD4;
        public const uint GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = 0x8DD6;
        public const uint GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = 0x8DD7;
        public const uint GL_QUERY_WAIT = 0x8E13;
        public const uint GL_QUERY_NO_WAIT = 0x8E14;
        public const uint GL_QUERY_BY_REGION_WAIT = 0x8E15;
        public const uint GL_QUERY_BY_REGION_NO_WAIT = 0x8E16;
        public const uint GL_BUFFER_ACCESS_FLAGS = 0x911F;
        public const uint GL_BUFFER_MAP_LENGTH = 0x9120;
        public const uint GL_BUFFER_MAP_OFFSET = 0x9121;
        public const uint GL_DEPTH_COMPONENT32F = 0x8CAC;
        public const uint GL_DEPTH32F_STENCIL8 = 0x8CAD;
        public const uint GL_FLOAT_32_UNSIGNED_INT_24_8_REV = 0x8DAD;
        public const uint GL_INVALID_FRAMEBUFFER_OPERATION = 0x0506;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 0x8210;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 0x8211;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = 0x8212;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 0x8213;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 0x8214;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 0x8215;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 0x8216;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 0x8217;
        public const uint GL_FRAMEBUFFER_DEFAULT = 0x8218;
        public const uint GL_FRAMEBUFFER_UNDEFINED = 0x8219;
        public const uint GL_DEPTH_STENCIL_ATTACHMENT = 0x821A;
        public const uint GL_MAX_RENDERBUFFER_SIZE = 0x84E8;
        public const uint GL_DEPTH_STENCIL = 0x84F9;
        public const uint GL_UNSIGNED_INT_24_8 = 0x84FA;
        public const uint GL_DEPTH24_STENCIL8 = 0x88F0;
        public const uint GL_TEXTURE_STENCIL_SIZE = 0x88F1;
        public const uint GL_TEXTURE_RED_TYPE = 0x8C10;
        public const uint GL_TEXTURE_GREEN_TYPE = 0x8C11;
        public const uint GL_TEXTURE_BLUE_TYPE = 0x8C12;
        public const uint GL_TEXTURE_ALPHA_TYPE = 0x8C13;
        public const uint GL_TEXTURE_DEPTH_TYPE = 0x8C16;
        public const uint GL_UNSIGNED_NORMALIZED = 0x8C17;
        public const uint GL_FRAMEBUFFER_BINDING = 0x8CA6;
        public const uint GL_DRAW_FRAMEBUFFER_BINDING = 0x8CA6;
        public const uint GL_RENDERBUFFER_BINDING = 0x8CA7;
        public const uint GL_READ_FRAMEBUFFER = 0x8CA8;
        public const uint GL_DRAW_FRAMEBUFFER = 0x8CA9;
        public const uint GL_READ_FRAMEBUFFER_BINDING = 0x8CAA;
        public const uint GL_RENDERBUFFER_SAMPLES = 0x8CAB;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 0x8CD0;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 0x8CD1;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 0x8CD2;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 0x8CD4;
        public const uint GL_FRAMEBUFFER_COMPLETE = 0x8CD5;
        public const uint GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 0x8CD6;
        public const uint GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7;
        public const uint GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = 0x8CDB;
        public const uint GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER = 0x8CDC;
        public const uint GL_FRAMEBUFFER_UNSUPPORTED = 0x8CDD;
        public const uint GL_MAX_COLOR_ATTACHMENTS = 0x8CDF;
        public const uint GL_COLOR_ATTACHMENT0 = 0x8CE0;
        public const uint GL_COLOR_ATTACHMENT1 = 0x8CE1;
        public const uint GL_COLOR_ATTACHMENT2 = 0x8CE2;
        public const uint GL_COLOR_ATTACHMENT3 = 0x8CE3;
        public const uint GL_COLOR_ATTACHMENT4 = 0x8CE4;
        public const uint GL_COLOR_ATTACHMENT5 = 0x8CE5;
        public const uint GL_COLOR_ATTACHMENT6 = 0x8CE6;
        public const uint GL_COLOR_ATTACHMENT7 = 0x8CE7;
        public const uint GL_COLOR_ATTACHMENT8 = 0x8CE8;
        public const uint GL_COLOR_ATTACHMENT9 = 0x8CE9;
        public const uint GL_COLOR_ATTACHMENT10 = 0x8CEA;
        public const uint GL_COLOR_ATTACHMENT11 = 0x8CEB;
        public const uint GL_COLOR_ATTACHMENT12 = 0x8CEC;
        public const uint GL_COLOR_ATTACHMENT13 = 0x8CED;
        public const uint GL_COLOR_ATTACHMENT14 = 0x8CEE;
        public const uint GL_COLOR_ATTACHMENT15 = 0x8CEF;
        public const uint GL_COLOR_ATTACHMENT16 = 0x8CF0;
        public const uint GL_COLOR_ATTACHMENT17 = 0x8CF1;
        public const uint GL_COLOR_ATTACHMENT18 = 0x8CF2;
        public const uint GL_COLOR_ATTACHMENT19 = 0x8CF3;
        public const uint GL_COLOR_ATTACHMENT20 = 0x8CF4;
        public const uint GL_COLOR_ATTACHMENT21 = 0x8CF5;
        public const uint GL_COLOR_ATTACHMENT22 = 0x8CF6;
        public const uint GL_COLOR_ATTACHMENT23 = 0x8CF7;
        public const uint GL_COLOR_ATTACHMENT24 = 0x8CF8;
        public const uint GL_COLOR_ATTACHMENT25 = 0x8CF9;
        public const uint GL_COLOR_ATTACHMENT26 = 0x8CFA;
        public const uint GL_COLOR_ATTACHMENT27 = 0x8CFB;
        public const uint GL_COLOR_ATTACHMENT28 = 0x8CFC;
        public const uint GL_COLOR_ATTACHMENT29 = 0x8CFD;
        public const uint GL_COLOR_ATTACHMENT30 = 0x8CFE;
        public const uint GL_COLOR_ATTACHMENT31 = 0x8CFF;
        public const uint GL_DEPTH_ATTACHMENT = 0x8D00;
        public const uint GL_STENCIL_ATTACHMENT = 0x8D20;
        public const uint GL_FRAMEBUFFER = 0x8D40;
        public const uint GL_RENDERBUFFER = 0x8D41;
        public const uint GL_RENDERBUFFER_WIDTH = 0x8D42;
        public const uint GL_RENDERBUFFER_HEIGHT = 0x8D43;
        public const uint GL_RENDERBUFFER_INTERNAL_FORMAT = 0x8D44;
        public const uint GL_STENCIL_INDEX1 = 0x8D46;
        public const uint GL_STENCIL_INDEX4 = 0x8D47;
        public const uint GL_STENCIL_INDEX8 = 0x8D48;
        public const uint GL_STENCIL_INDEX16 = 0x8D49;
        public const uint GL_RENDERBUFFER_RED_SIZE = 0x8D50;
        public const uint GL_RENDERBUFFER_GREEN_SIZE = 0x8D51;
        public const uint GL_RENDERBUFFER_BLUE_SIZE = 0x8D52;
        public const uint GL_RENDERBUFFER_ALPHA_SIZE = 0x8D53;
        public const uint GL_RENDERBUFFER_DEPTH_SIZE = 0x8D54;
        public const uint GL_RENDERBUFFER_STENCIL_SIZE = 0x8D55;
        public const uint GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 0x8D56;
        public const uint GL_MAX_SAMPLES = 0x8D57;
        public const uint GL_FRAMEBUFFER_SRGB = 0x8DB9;
        public const uint GL_HALF_FLOAT = 0x140B;
        public const uint GL_MAP_READ_BIT = 0x0001;
        public const uint GL_MAP_WRITE_BIT = 0x0002;
        public const uint GL_MAP_INVALIDATE_RANGE_BIT = 0x0004;
        public const uint GL_MAP_INVALIDATE_BUFFER_BIT = 0x0008;
        public const uint GL_MAP_FLUSH_EXPLICIT_BIT = 0x0010;
        public const uint GL_MAP_UNSYNCHRONIZED_BIT = 0x0020;
        public const uint GL_COMPRESSED_RED_RGTC1 = 0x8DBB;
        public const uint GL_COMPRESSED_SIGNED_RED_RGTC1 = 0x8DBC;
        public const uint GL_COMPRESSED_RG_RGTC2 = 0x8DBD;
        public const uint GL_COMPRESSED_SIGNED_RG_RGTC2 = 0x8DBE;
        public const uint GL_RG = 0x8227;
        public const uint GL_RG_INTEGER = 0x8228;
        public const uint GL_R8 = 0x8229;
        public const uint GL_R16 = 0x822A;
        public const uint GL_RG8 = 0x822B;
        public const uint GL_RG16 = 0x822C;
        public const uint GL_R16F = 0x822D;
        public const uint GL_R32F = 0x822E;
        public const uint GL_RG16F = 0x822F;
        public const uint GL_RG32F = 0x8230;
        public const uint GL_R8I = 0x8231;
        public const uint GL_R8UI = 0x8232;
        public const uint GL_R16I = 0x8233;
        public const uint GL_R16UI = 0x8234;
        public const uint GL_R32I = 0x8235;
        public const uint GL_R32UI = 0x8236;
        public const uint GL_RG8I = 0x8237;
        public const uint GL_RG8UI = 0x8238;
        public const uint GL_RG16I = 0x8239;
        public const uint GL_RG16UI = 0x823A;
        public const uint GL_RG32I = 0x823B;
        public const uint GL_RG32UI = 0x823C;
        public const uint GL_VERTEX_ARRAY_BINDING = 0x85B5;
        public const uint GL_SAMPLER_2D_RECT = 0x8B63;
        public const uint GL_SAMPLER_2D_RECT_SHADOW = 0x8B64;
        public const uint GL_SAMPLER_BUFFER = 0x8DC2;
        public const uint GL_INT_SAMPLER_2D_RECT = 0x8DCD;
        public const uint GL_INT_SAMPLER_BUFFER = 0x8DD0;
        public const uint GL_UNSIGNED_INT_SAMPLER_2D_RECT = 0x8DD5;
        public const uint GL_UNSIGNED_INT_SAMPLER_BUFFER = 0x8DD8;
        public const uint GL_TEXTURE_BUFFER = 0x8C2A;
        public const uint GL_MAX_TEXTURE_BUFFER_SIZE = 0x8C2B;
        public const uint GL_TEXTURE_BINDING_BUFFER = 0x8C2C;
        public const uint GL_TEXTURE_BUFFER_DATA_STORE_BINDING = 0x8C2D;
        public const uint GL_TEXTURE_RECTANGLE = 0x84F5;
        public const uint GL_TEXTURE_BINDING_RECTANGLE = 0x84F6;
        public const uint GL_PROXY_TEXTURE_RECTANGLE = 0x84F7;
        public const uint GL_MAX_RECTANGLE_TEXTURE_SIZE = 0x84F8;
        public const uint GL_R8_SNORM = 0x8F94;
        public const uint GL_RG8_SNORM = 0x8F95;
        public const uint GL_RGB8_SNORM = 0x8F96;
        public const uint GL_RGBA8_SNORM = 0x8F97;
        public const uint GL_R16_SNORM = 0x8F98;
        public const uint GL_RG16_SNORM = 0x8F99;
        public const uint GL_RGB16_SNORM = 0x8F9A;
        public const uint GL_RGBA16_SNORM = 0x8F9B;
        public const uint GL_SIGNED_NORMALIZED = 0x8F9C;
        public const uint GL_PRIMITIVE_RESTART = 0x8F9D;
        public const uint GL_PRIMITIVE_RESTART_INDEX = 0x8F9E;
        public const uint GL_COPY_READ_BUFFER = 0x8F36;
        public const uint GL_COPY_WRITE_BUFFER = 0x8F37;
        public const uint GL_UNIFORM_BUFFER = 0x8A11;
        public const uint GL_UNIFORM_BUFFER_BINDING = 0x8A28;
        public const uint GL_UNIFORM_BUFFER_START = 0x8A29;
        public const uint GL_UNIFORM_BUFFER_SIZE = 0x8A2A;
        public const uint GL_MAX_VERTEX_UNIFORM_BLOCKS = 0x8A2B;
        public const uint GL_MAX_GEOMETRY_UNIFORM_BLOCKS = 0x8A2C;
        public const uint GL_MAX_FRAGMENT_UNIFORM_BLOCKS = 0x8A2D;
        public const uint GL_MAX_COMBINED_UNIFORM_BLOCKS = 0x8A2E;
        public const uint GL_MAX_UNIFORM_BUFFER_BINDINGS = 0x8A2F;
        public const uint GL_MAX_UNIFORM_BLOCK_SIZE = 0x8A30;
        public const uint GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = 0x8A31;
        public const uint GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = 0x8A32;
        public const uint GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = 0x8A33;
        public const uint GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = 0x8A34;
        public const uint GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = 0x8A35;
        public const uint GL_ACTIVE_UNIFORM_BLOCKS = 0x8A36;
        public const uint GL_UNIFORM_TYPE = 0x8A37;
        public const uint GL_UNIFORM_SIZE = 0x8A38;
        public const uint GL_UNIFORM_NAME_LENGTH = 0x8A39;
        public const uint GL_UNIFORM_BLOCK_INDEX = 0x8A3A;
        public const uint GL_UNIFORM_OFFSET = 0x8A3B;
        public const uint GL_UNIFORM_ARRAY_STRIDE = 0x8A3C;
        public const uint GL_UNIFORM_MATRIX_STRIDE = 0x8A3D;
        public const uint GL_UNIFORM_IS_ROW_MAJOR = 0x8A3E;
        public const uint GL_UNIFORM_BLOCK_BINDING = 0x8A3F;
        public const uint GL_UNIFORM_BLOCK_DATA_SIZE = 0x8A40;
        public const uint GL_UNIFORM_BLOCK_NAME_LENGTH = 0x8A41;
        public const uint GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS = 0x8A42;
        public const uint GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = 0x8A43;
        public const uint GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = 0x8A44;
        public const uint GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = 0x8A45;
        public const uint GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = 0x8A46;
        public const uint GL_INVALID_INDEX = 0xFFFFFFFF;
        public const uint GL_CONTEXT_CORE_PROFILE_BIT = 0x00000001;
        public const uint GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = 0x00000002;
        public const uint GL_LINES_ADJACENCY = 0x000A;
        public const uint GL_LINE_STRIP_ADJACENCY = 0x000B;
        public const uint GL_TRIANGLES_ADJACENCY = 0x000C;
        public const uint GL_TRIANGLE_STRIP_ADJACENCY = 0x000D;
        public const uint GL_PROGRAM_POINT_SIZE = 0x8642;
        public const uint GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = 0x8C29;
        public const uint GL_FRAMEBUFFER_ATTACHMENT_LAYERED = 0x8DA7;
        public const uint GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = 0x8DA8;
        public const uint GL_GEOMETRY_SHADER = 0x8DD9;
        public const uint GL_GEOMETRY_VERTICES_OUT = 0x8916;
        public const uint GL_GEOMETRY_INPUT_TYPE = 0x8917;
        public const uint GL_GEOMETRY_OUTPUT_TYPE = 0x8918;
        public const uint GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = 0x8DDF;
        public const uint GL_MAX_GEOMETRY_OUTPUT_VERTICES = 0x8DE0;
        public const uint GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = 0x8DE1;
        public const uint GL_MAX_VERTEX_OUTPUT_COMPONENTS = 0x9122;
        public const uint GL_MAX_GEOMETRY_INPUT_COMPONENTS = 0x9123;
        public const uint GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = 0x9124;
        public const uint GL_MAX_FRAGMENT_INPUT_COMPONENTS = 0x9125;
        public const uint GL_CONTEXT_PROFILE_MASK = 0x9126;
        public const uint GL_DEPTH_CLAMP = 0x864F;
        public const uint GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = 0x8E4C;
        public const uint GL_FIRST_VERTEX_CONVENTION = 0x8E4D;
        public const uint GL_LAST_VERTEX_CONVENTION = 0x8E4E;
        public const uint GL_PROVOKING_VERTEX = 0x8E4F;
        public const uint GL_TEXTURE_CUBE_MAP_SEAMLESS = 0x884F;
        public const uint GL_MAX_SERVER_WAIT_TIMEOUT = 0x9111;
        public const uint GL_OBJECT_TYPE = 0x9112;
        public const uint GL_SYNC_CONDITION = 0x9113;
        public const uint GL_SYNC_STATUS = 0x9114;
        public const uint GL_SYNC_FLAGS = 0x9115;
        public const uint GL_SYNC_FENCE = 0x9116;
        public const uint GL_SYNC_GPU_COMMANDS_COMPLETE = 0x9117;
        public const uint GL_UNSIGNALED = 0x9118;
        public const uint GL_SIGNALED = 0x9119;
        public const uint GL_ALREADY_SIGNALED = 0x911A;
        public const uint GL_TIMEOUT_EXPIRED = 0x911B;
        public const uint GL_CONDITION_SATISFIED = 0x911C;
        public const uint GL_WAIT_FAILED = 0x911D;
        public const uint GL_TIMEOUT_IGNORED = 0xFFFFFFFFFFFFFFFF;
        public const uint GL_SYNC_FLUSH_COMMANDS_BIT = 0x00000001;
        public const uint GL_SAMPLE_POSITION = 0x8E50;
        public const uint GL_SAMPLE_MASK = 0x8E51;
        public const uint GL_SAMPLE_MASK_VALUE = 0x8E52;
        public const uint GL_MAX_SAMPLE_MASK_WORDS = 0x8E59;
        public const uint GL_TEXTURE_2D_MULTISAMPLE = 0x9100;
        public const uint GL_PROXY_TEXTURE_2D_MULTISAMPLE = 0x9101;
        public const uint GL_TEXTURE_2D_MULTISAMPLE_ARRAY = 0x9102;
        public const uint GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = 0x9103;
        public const uint GL_TEXTURE_BINDING_2D_MULTISAMPLE = 0x9104;
        public const uint GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = 0x9105;
        public const uint GL_TEXTURE_SAMPLES = 0x9106;
        public const uint GL_TEXTURE_FIXED_SAMPLE_LOCATIONS = 0x9107;
        public const uint GL_SAMPLER_2D_MULTISAMPLE = 0x9108;
        public const uint GL_INT_SAMPLER_2D_MULTISAMPLE = 0x9109;
        public const uint GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = 0x910A;
        public const uint GL_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910B;
        public const uint GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910C;
        public const uint GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910D;
        public const uint GL_MAX_COLOR_TEXTURE_SAMPLES = 0x910E;
        public const uint GL_MAX_DEPTH_TEXTURE_SAMPLES = 0x910F;
        public const uint GL_MAX_INTEGER_SAMPLES = 0x9110;
        public const uint GL_VERTEX_ATTRIB_ARRAY_DIVISOR = 0x88FE;
        public const uint GL_SRC1_COLOR = 0x88F9;
        public const uint GL_ONE_MINUS_SRC1_COLOR = 0x88FA;
        public const uint GL_ONE_MINUS_SRC1_ALPHA = 0x88FB;
        public const uint GL_MAX_DUAL_SOURCE_DRAW_BUFFERS = 0x88FC;
        public const uint GL_ANY_SAMPLES_PASSED = 0x8C2F;
        public const uint GL_SAMPLER_BINDING = 0x8919;
        public const uint GL_RGB10_A2UI = 0x906F;
        public const uint GL_TEXTURE_SWIZZLE_R = 0x8E42;
        public const uint GL_TEXTURE_SWIZZLE_G = 0x8E43;
        public const uint GL_TEXTURE_SWIZZLE_B = 0x8E44;
        public const uint GL_TEXTURE_SWIZZLE_A = 0x8E45;
        public const uint GL_TEXTURE_SWIZZLE_RGBA = 0x8E46;
        public const uint GL_TIME_ELAPSED = 0x88BF;
        public const uint GL_TIMESTAMP = 0x8E28;
        public const uint GL_INT_2_10_10_10_REV = 0x8D9F;

        public function void GlCullFace(uint mode);
        public static GlCullFace glCullFace;

        public function void GlFrontFace(uint mode);
        public static GlFrontFace glFrontFace;

        public function void GlHint(uint target, uint mode);
        public static GlHint glHint;

        public function void GlLineWidth(float width);
        public static GlLineWidth glLineWidth;

        public function void GlPointSize(float size);
        public static GlPointSize glPointSize;

        public function void GlPolygonMode(uint face, uint mode);
        public static GlPolygonMode glPolygonMode;

        public function void GlScissor(int x, int y, int width, int height);
        public static GlScissor glScissor;

        public function void GlTexParameterf(uint target, uint pname, float param);
        public static GlTexParameterf glTexParameterf;

        public function void GlTexParameterfv(uint target, uint pname, float* paramss);
        public static GlTexParameterfv glTexParameterfv;

        public function void GlTexParameteri(uint target, uint pname, int param);
        public static GlTexParameteri glTexParameteri;

        public function void GlTexParameteriv(uint target, uint pname, int32* paramss);
        public static GlTexParameteriv glTexParameteriv;

        public function void GlTexImage1D(uint target, int level, int internalformat, int width, int border, uint format, uint type, void* pixels);
        public static GlTexImage1D glTexImage1D;

        public function void GlTexImage2D(uint target, int level, int internalformat, int width, int height, int border, uint format, uint type, void* pixels);
        public static GlTexImage2D glTexImage2D;

        public function void GlDrawBuffer(uint buf);
        public static GlDrawBuffer glDrawBuffer;

        public function void GlClear(uint mask);
        public static GlClear glClear;

        public function void GlClearColor(float red, float green, float blue, float alpha);
        public static GlClearColor glClearColor;

        public function void GlClearStencil(int s);
        public static GlClearStencil glClearStencil;

        public function void GlClearDepth(double depth);
        public static GlClearDepth glClearDepth;

        public function void GlStencilMask(uint mask);
        public static GlStencilMask glStencilMask;

        public function void GlColorMask(uint8 red, uint8 green, uint8 blue, uint8 alpha);
        public static GlColorMask glColorMask;

        public function void GlDepthMask(uint8 flag);
        public static GlDepthMask glDepthMask;

        public function void GlDisable(uint cap);
        public static GlDisable glDisable;

        public function void GlEnable(uint cap);
        public static GlEnable glEnable;

        public function void GlFinish();
        public static GlFinish glFinish;

        public function void GlFlush();
        public static GlFlush glFlush;

        public function void GlBlendFunc(uint sfactor, uint dfactor);
        public static GlBlendFunc glBlendFunc;

        public function void GlLogicOp(uint opcode);
        public static GlLogicOp glLogicOp;

        public function void GlStencilFunc(uint func, int reff, uint mask);
        public static GlStencilFunc glStencilFunc;

        public function void GlStencilOp(uint fail, uint zfail, uint zpass);
        public static GlStencilOp glStencilOp;

        public function void GlDepthFunc(uint func);
        public static GlDepthFunc glDepthFunc;

        public function void GlPixelStoref(uint pname, float param);
        public static GlPixelStoref glPixelStoref;

        public function void GlPixelStorei(uint pname, int param);
        public static GlPixelStorei glPixelStorei;

        public function void GlReadBuffer(uint src);
        public static GlReadBuffer glReadBuffer;

        public function void GlReadPixels(int x, int y, int width, int height, uint format, uint type, void* pixels);
        public static GlReadPixels glReadPixels;

        public function void GlGetBooleanv(uint pname, uint8* data);
        public static GlGetBooleanv glGetBooleanv;

        public function void GlGetDoublev(uint pname, double* data);
        public static GlGetDoublev glGetDoublev;

        public function uint GlGetError();
        public static GlGetError glGetError;

        public function void GlGetFloatv(uint pname, float* data);
        public static GlGetFloatv glGetFloatv;

        public function void GlGetIntegerv(uint pname, int32* data);
        public static GlGetIntegerv glGetIntegerv;

        public function uint8 GlGetString(uint name);
        public static GlGetString glGetString;

        public function void GlGetTexImage(uint target, int level, uint format, uint type, void* pixels);
        public static GlGetTexImage glGetTexImage;

        public function void GlGetTexParameterfv(uint target, uint pname, float* paramss);
        public static GlGetTexParameterfv glGetTexParameterfv;

        public function void GlGetTexParameteriv(uint target, uint pname, int32* paramss);
        public static GlGetTexParameteriv glGetTexParameteriv;

        public function void GlGetTexLevelParameterfv(uint target, int level, uint pname, float* paramss);
        public static GlGetTexLevelParameterfv glGetTexLevelParameterfv;

        public function void GlGetTexLevelParameteriv(uint target, int level, uint pname, int32* paramss);
        public static GlGetTexLevelParameteriv glGetTexLevelParameteriv;

        public function uint8 GlIsEnabled(uint cap);
        public static GlIsEnabled glIsEnabled;

        public function void GlDepthRange(double n, double f);
        public static GlDepthRange glDepthRange;

        public function void GlViewport(int x, int y, int width, int height);
        public static GlViewport glViewport;

        public function void GlDrawArrays(uint mode, int first, int count);
        public static GlDrawArrays glDrawArrays;

        public function void GlDrawElements(uint mode, int count, uint type, void* indices);
        public static GlDrawElements glDrawElements;

        public function void GlPolygonOffset(float factor, float units);
        public static GlPolygonOffset glPolygonOffset;

        public function void GlCopyTexImage1D(uint target, int level, uint internalformat, int x, int y, int width, int border);
        public static GlCopyTexImage1D glCopyTexImage1D;

        public function void GlCopyTexImage2D(uint target, int level, uint internalformat, int x, int y, int width, int height, int border);
        public static GlCopyTexImage2D glCopyTexImage2D;

        public function void GlCopyTexSubImage1D(uint target, int level, int xoffset, int x, int y, int width);
        public static GlCopyTexSubImage1D glCopyTexSubImage1D;

        public function void GlCopyTexSubImage2D(uint target, int level, int xoffset, int yoffset, int x, int y, int width, int height);
        public static GlCopyTexSubImage2D glCopyTexSubImage2D;

        public function void GlTexSubImage1D(uint target, int level, int xoffset, int width, uint format, uint type, void* pixels);
        public static GlTexSubImage1D glTexSubImage1D;

        public function void GlTexSubImage2D(uint target, int level, int xoffset, int yoffset, int width, int height, uint format, uint type, void* pixels);
        public static GlTexSubImage2D glTexSubImage2D;

        public function void GlBindTexture(uint target, uint texture);
        public static GlBindTexture glBindTexture;

        public function void GlDeleteTextures(int n, uint32* textures);
        public static GlDeleteTextures glDeleteTextures;

        public function void GlGenTextures(int n, uint32* textures);
        public static GlGenTextures glGenTextures;

        public function uint8 GlIsTexture(uint texture);
        public static GlIsTexture glIsTexture;

        public function void GlDrawRangeElements(uint mode, uint start, uint end, int count, uint type, void* indices);
        public static GlDrawRangeElements glDrawRangeElements;

        public function void GlTexImage3D(uint target, int level, int internalformat, int width, int height, int depth, int border, uint format, uint type, void* pixels);
        public static GlTexImage3D glTexImage3D;

        public function void GlTexSubImage3D(uint target, int level, int xoffset, int yoffset, int zoffset, int width, int height, int depth, uint format, uint type, void* pixels);
        public static GlTexSubImage3D glTexSubImage3D;

        public function void GlCopyTexSubImage3D(uint target, int level, int xoffset, int yoffset, int zoffset, int x, int y, int width, int height);
        public static GlCopyTexSubImage3D glCopyTexSubImage3D;

        public function void GlActiveTexture(uint texture);
        public static GlActiveTexture glActiveTexture;

        public function void GlSampleCoverage(float value, uint8 invert);
        public static GlSampleCoverage glSampleCoverage;

        public function void GlCompressedTexImage3D(uint target, int level, uint internalformat, int width, int height, int depth, int border, int imageSize, void* data);
        public static GlCompressedTexImage3D glCompressedTexImage3D;

        public function void GlCompressedTexImage2D(uint target, int level, uint internalformat, int width, int height, int border, int imageSize, void* data);
        public static GlCompressedTexImage2D glCompressedTexImage2D;

        public function void GlCompressedTexImage1D(uint target, int level, uint internalformat, int width, int border, int imageSize, void* data);
        public static GlCompressedTexImage1D glCompressedTexImage1D;

        public function void GlCompressedTexSubImage3D(uint target, int level, int xoffset, int yoffset, int zoffset, int width, int height, int depth, uint format, int imageSize, void* data);
        public static GlCompressedTexSubImage3D glCompressedTexSubImage3D;

        public function void GlCompressedTexSubImage2D(uint target, int level, int xoffset, int yoffset, int width, int height, uint format, int imageSize, void* data);
        public static GlCompressedTexSubImage2D glCompressedTexSubImage2D;

        public function void GlCompressedTexSubImage1D(uint target, int level, int xoffset, int width, uint format, int imageSize, void* data);
        public static GlCompressedTexSubImage1D glCompressedTexSubImage1D;

        public function void GlGetCompressedTexImage(uint target, int level, void* img);
        public static GlGetCompressedTexImage glGetCompressedTexImage;

        public function void GlBlendFuncSeparate(uint sfactorRGB, uint dfactorRGB, uint sfactorAlpha, uint dfactorAlpha);
        public static GlBlendFuncSeparate glBlendFuncSeparate;

        public function void GlMultiDrawArrays(uint mode, int32* first, int32* count, int drawcount);
        public static GlMultiDrawArrays glMultiDrawArrays;

        public function void GlMultiDrawElements(uint mode, int32* count, uint type, void *** indices, int drawcount);
        public static GlMultiDrawElements glMultiDrawElements;

        public function void GlPointParameterf(uint pname, float param);
        public static GlPointParameterf glPointParameterf;

        public function void GlPointParameterfv(uint pname, float* paramss);
        public static GlPointParameterfv glPointParameterfv;

        public function void GlPointParameteri(uint pname, int param);
        public static GlPointParameteri glPointParameteri;

        public function void GlPointParameteriv(uint pname, int32* paramss);
        public static GlPointParameteriv glPointParameteriv;

        public function void GlBlendColor(float red, float green, float blue, float alpha);
        public static GlBlendColor glBlendColor;

        public function void GlBlendEquation(uint mode);
        public static GlBlendEquation glBlendEquation;

        public function void GlGenQueries(int n, uint32* ids);
        public static GlGenQueries glGenQueries;

        public function void GlDeleteQueries(int n, uint32* ids);
        public static GlDeleteQueries glDeleteQueries;

        public function uint8 GlIsQuery(uint id);
        public static GlIsQuery glIsQuery;

        public function void GlBeginQuery(uint target, uint id);
        public static GlBeginQuery glBeginQuery;

        public function void GlEndQuery(uint target);
        public static GlEndQuery glEndQuery;

        public function void GlGetQueryiv(uint target, uint pname, int32* paramss);
        public static GlGetQueryiv glGetQueryiv;

        public function void GlGetQueryObjectiv(uint id, uint pname, int32* paramss);
        public static GlGetQueryObjectiv glGetQueryObjectiv;

        public function void GlGetQueryObjectuiv(uint id, uint pname, uint32* paramss);
        public static GlGetQueryObjectuiv glGetQueryObjectuiv;

        public function void GlBindBuffer(uint target, uint buffer);
        public static GlBindBuffer glBindBuffer;

        public function void GlDeleteBuffers(int n, uint32* buffers);
        public static GlDeleteBuffers glDeleteBuffers;

        public function void GlGenBuffers(int n, uint32* buffers);
        public static GlGenBuffers glGenBuffers;

        public function uint8 GlIsBuffer(uint buffer);
        public static GlIsBuffer glIsBuffer;

        public function void GlBufferData(uint target, int size, void* data, uint usage);
        public static GlBufferData glBufferData;

        public function void GlBufferSubData(uint target, int offset, int size, void* data);
        public static GlBufferSubData glBufferSubData;

        public function void GlGetBufferSubData(uint target, int offset, int size, void* data);
        public static GlGetBufferSubData glGetBufferSubData;

        public function void GlMapBuffer(uint target, uint access);
        public static GlMapBuffer glMapBuffer;

        public function uint8 GlUnmapBuffer(uint target);
        public static GlUnmapBuffer glUnmapBuffer;

        public function void GlGetBufferParameteriv(uint target, uint pname, int32* paramss);
        public static GlGetBufferParameteriv glGetBufferParameteriv;

        public function void GlGetBufferPointerv(uint target, uint pname, void *** paramss);
        public static GlGetBufferPointerv glGetBufferPointerv;

        public function void GlBlendEquationSeparate(uint modeRGB, uint modeAlpha);
        public static GlBlendEquationSeparate glBlendEquationSeparate;

        public function void GlDrawBuffers(int n, uint32* bufs);
        public static GlDrawBuffers glDrawBuffers;

        public function void GlStencilOpSeparate(uint face, uint sfail, uint dpfail, uint dppass);
        public static GlStencilOpSeparate glStencilOpSeparate;

        public function void GlStencilFuncSeparate(uint face, uint func, int reff, uint mask);
        public static GlStencilFuncSeparate glStencilFuncSeparate;

        public function void GlStencilMaskSeparate(uint face, uint mask);
        public static GlStencilMaskSeparate glStencilMaskSeparate;

        public function void GlAttachShader(uint program, uint shader);
        public static GlAttachShader glAttachShader;

        public function void GlBindAttribLocation(uint program, uint index, char8* name);
        public static GlBindAttribLocation glBindAttribLocation;

        public function void GlCompileShader(uint shader);
        public static GlCompileShader glCompileShader;

        public function uint GlCreateProgram();
        public static GlCreateProgram glCreateProgram;

        public function uint GlCreateShader(uint type);
        public static GlCreateShader glCreateShader;

        public function void GlDeleteProgram(uint program);
        public static GlDeleteProgram glDeleteProgram;

        public function void GlDeleteShader(uint shader);
        public static GlDeleteShader glDeleteShader;

        public function void GlDetachShader(uint program, uint shader);
        public static GlDetachShader glDetachShader;

        public function void GlDisableVertexAttribArray(uint index);
        public static GlDisableVertexAttribArray glDisableVertexAttribArray;

        public function void GlEnableVertexAttribArray(uint index);
        public static GlEnableVertexAttribArray glEnableVertexAttribArray;

        public function void GlGetActiveAttrib(uint program, uint index, int bufSize, int32* length, int32* size, uint32* type, char8* name);
        public static GlGetActiveAttrib glGetActiveAttrib;

        public function void GlGetActiveUniform(uint program, uint index, int bufSize, int32* length, int32* size, uint32* type, char8* name);
        public static GlGetActiveUniform glGetActiveUniform;

        public function void GlGetAttachedShaders(uint program, int maxCount, int32* count, uint32* shaders);
        public static GlGetAttachedShaders glGetAttachedShaders;

        public function int GlGetAttribLocation(uint program, char8* name);
        public static GlGetAttribLocation glGetAttribLocation;

        public function void GlGetProgramiv(uint program, uint pname, int32* paramss);
        public static GlGetProgramiv glGetProgramiv;

        public function void GlGetProgramInfoLog(uint program, int bufSize, int32* length, char8* infoLog);
        public static GlGetProgramInfoLog glGetProgramInfoLog;

        public function void GlGetShaderiv(uint shader, uint pname, int32* paramss);
        public static GlGetShaderiv glGetShaderiv;

        public function void GlGetShaderInfoLog(uint shader, int bufSize, int32* length, char8* infoLog);
        public static GlGetShaderInfoLog glGetShaderInfoLog;

        public function void GlGetShaderSource(uint shader, int bufSize, int32* length, char8* source);
        public static GlGetShaderSource glGetShaderSource;

        public function int GlGetUniformLocation(uint program, char8* name);
        public static GlGetUniformLocation glGetUniformLocation;

        public function void GlGetUniformfv(uint program, int location, float* paramss);
        public static GlGetUniformfv glGetUniformfv;

        public function void GlGetUniformiv(uint program, int location, int32* paramss);
        public static GlGetUniformiv glGetUniformiv;

        public function void GlGetVertexAttribdv(uint index, uint pname, double* paramss);
        public static GlGetVertexAttribdv glGetVertexAttribdv;

        public function void GlGetVertexAttribfv(uint index, uint pname, float* paramss);
        public static GlGetVertexAttribfv glGetVertexAttribfv;

        public function void GlGetVertexAttribiv(uint index, uint pname, int32* paramss);
        public static GlGetVertexAttribiv glGetVertexAttribiv;

        public function void GlGetVertexAttribPointerv(uint index, uint pname, void *** pointer);
        public static GlGetVertexAttribPointerv glGetVertexAttribPointerv;

        public function uint8 GlIsProgram(uint program);
        public static GlIsProgram glIsProgram;

        public function uint8 GlIsShader(uint shader);
        public static GlIsShader glIsShader;

        public function void GlLinkProgram(uint program);
        public static GlLinkProgram glLinkProgram;

        public function void GlShaderSource(uint shader, int count, char8** string, int32* length);
        public static GlShaderSource glShaderSource;

        public function void GlUseProgram(uint program);
        public static GlUseProgram glUseProgram;

        public function void GlUniform1f(int location, float v0);
        public static GlUniform1f glUniform1f;

        public function void GlUniform2f(int location, float v0, float v1);
        public static GlUniform2f glUniform2f;

        public function void GlUniform3f(int location, float v0, float v1, float v2);
        public static GlUniform3f glUniform3f;

        public function void GlUniform4f(int location, float v0, float v1, float v2, float v3);
        public static GlUniform4f glUniform4f;

        public function void GlUniform1i(int location, int v0);
        public static GlUniform1i glUniform1i;

        public function void GlUniform2i(int location, int v0, int v1);
        public static GlUniform2i glUniform2i;

        public function void GlUniform3i(int location, int v0, int v1, int v2);
        public static GlUniform3i glUniform3i;

        public function void GlUniform4i(int location, int v0, int v1, int v2, int v3);
        public static GlUniform4i glUniform4i;

        public function void GlUniform1fv(int location, int count, float* value);
        public static GlUniform1fv glUniform1fv;

        public function void GlUniform2fv(int location, int count, float* value);
        public static GlUniform2fv glUniform2fv;

        public function void GlUniform3fv(int location, int count, float* value);
        public static GlUniform3fv glUniform3fv;

        public function void GlUniform4fv(int location, int count, float* value);
        public static GlUniform4fv glUniform4fv;

        public function void GlUniform1iv(int location, int count, int32* value);
        public static GlUniform1iv glUniform1iv;

        public function void GlUniform2iv(int location, int count, int32* value);
        public static GlUniform2iv glUniform2iv;

        public function void GlUniform3iv(int location, int count, int32* value);
        public static GlUniform3iv glUniform3iv;

        public function void GlUniform4iv(int location, int count, int32* value);
        public static GlUniform4iv glUniform4iv;

        public function void GlUniformMatrix2fv(int location, int count, uint8 transpose, float* value);
        public static GlUniformMatrix2fv glUniformMatrix2fv;

        public function void GlUniformMatrix3fv(int location, int count, uint8 transpose, float* value);
        public static GlUniformMatrix3fv glUniformMatrix3fv;

        public function void GlUniformMatrix4fv(int location, int count, uint8 transpose, float* value);
        public static GlUniformMatrix4fv glUniformMatrix4fv;

        public function void GlValidateProgram(uint program);
        public static GlValidateProgram glValidateProgram;

        public function void GlVertexAttrib1d(uint index, double x);
        public static GlVertexAttrib1d glVertexAttrib1d;

        public function void GlVertexAttrib1dv(uint index, double* v);
        public static GlVertexAttrib1dv glVertexAttrib1dv;

        public function void GlVertexAttrib1f(uint index, float x);
        public static GlVertexAttrib1f glVertexAttrib1f;

        public function void GlVertexAttrib1fv(uint index, float* v);
        public static GlVertexAttrib1fv glVertexAttrib1fv;

        public function void GlVertexAttrib1s(uint index, int16 x);
        public static GlVertexAttrib1s glVertexAttrib1s;

        public function void GlVertexAttrib1sv(uint index, int16* v);
        public static GlVertexAttrib1sv glVertexAttrib1sv;

        public function void GlVertexAttrib2d(uint index, double x, double y);
        public static GlVertexAttrib2d glVertexAttrib2d;

        public function void GlVertexAttrib2dv(uint index, double* v);
        public static GlVertexAttrib2dv glVertexAttrib2dv;

        public function void GlVertexAttrib2f(uint index, float x, float y);
        public static GlVertexAttrib2f glVertexAttrib2f;

        public function void GlVertexAttrib2fv(uint index, float* v);
        public static GlVertexAttrib2fv glVertexAttrib2fv;

        public function void GlVertexAttrib2s(uint index, int16 x, int16 y);
        public static GlVertexAttrib2s glVertexAttrib2s;

        public function void GlVertexAttrib2sv(uint index, int16* v);
        public static GlVertexAttrib2sv glVertexAttrib2sv;

        public function void GlVertexAttrib3d(uint index, double x, double y, double z);
        public static GlVertexAttrib3d glVertexAttrib3d;

        public function void GlVertexAttrib3dv(uint index, double* v);
        public static GlVertexAttrib3dv glVertexAttrib3dv;

        public function void GlVertexAttrib3f(uint index, float x, float y, float z);
        public static GlVertexAttrib3f glVertexAttrib3f;

        public function void GlVertexAttrib3fv(uint index, float* v);
        public static GlVertexAttrib3fv glVertexAttrib3fv;

        public function void GlVertexAttrib3s(uint index, int16 x, int16 y, int16 z);
        public static GlVertexAttrib3s glVertexAttrib3s;

        public function void GlVertexAttrib3sv(uint index, int16* v);
        public static GlVertexAttrib3sv glVertexAttrib3sv;

        public function void GlVertexAttrib4Nbv(uint index, int8* v);
        public static GlVertexAttrib4Nbv glVertexAttrib4Nbv;

        public function void GlVertexAttrib4Niv(uint index, int32* v);
        public static GlVertexAttrib4Niv glVertexAttrib4Niv;

        public function void GlVertexAttrib4Nsv(uint index, int16* v);
        public static GlVertexAttrib4Nsv glVertexAttrib4Nsv;

        public function void GlVertexAttrib4Nub(uint index, uint8 x, uint8 y, uint8 z, uint8 w);
        public static GlVertexAttrib4Nub glVertexAttrib4Nub;

        public function void GlVertexAttrib4Nubv(uint index, uint8* v);
        public static GlVertexAttrib4Nubv glVertexAttrib4Nubv;

        public function void GlVertexAttrib4Nuiv(uint index, uint32* v);
        public static GlVertexAttrib4Nuiv glVertexAttrib4Nuiv;

        public function void GlVertexAttrib4Nusv(uint index, uint16* v);
        public static GlVertexAttrib4Nusv glVertexAttrib4Nusv;

        public function void GlVertexAttrib4bv(uint index, int8* v);
        public static GlVertexAttrib4bv glVertexAttrib4bv;

        public function void GlVertexAttrib4d(uint index, double x, double y, double z, double w);
        public static GlVertexAttrib4d glVertexAttrib4d;

        public function void GlVertexAttrib4dv(uint index, double* v);
        public static GlVertexAttrib4dv glVertexAttrib4dv;

        public function void GlVertexAttrib4f(uint index, float x, float y, float z, float w);
        public static GlVertexAttrib4f glVertexAttrib4f;

        public function void GlVertexAttrib4fv(uint index, float* v);
        public static GlVertexAttrib4fv glVertexAttrib4fv;

        public function void GlVertexAttrib4iv(uint index, int32* v);
        public static GlVertexAttrib4iv glVertexAttrib4iv;

        public function void GlVertexAttrib4s(uint index, int16 x, int16 y, int16 z, int16 w);
        public static GlVertexAttrib4s glVertexAttrib4s;

        public function void GlVertexAttrib4sv(uint index, int16* v);
        public static GlVertexAttrib4sv glVertexAttrib4sv;

        public function void GlVertexAttrib4ubv(uint index, uint8* v);
        public static GlVertexAttrib4ubv glVertexAttrib4ubv;

        public function void GlVertexAttrib4uiv(uint index, uint32* v);
        public static GlVertexAttrib4uiv glVertexAttrib4uiv;

        public function void GlVertexAttrib4usv(uint index, uint16* v);
        public static GlVertexAttrib4usv glVertexAttrib4usv;

        public function void GlVertexAttribPointer(uint index, int size, uint type, uint8 normalized, int stride, void* pointer);
        public static GlVertexAttribPointer glVertexAttribPointer;

        public function void GlUniformMatrix2x3fv(int location, int count, uint8 transpose, float* value);
        public static GlUniformMatrix2x3fv glUniformMatrix2x3fv;

        public function void GlUniformMatrix3x2fv(int location, int count, uint8 transpose, float* value);
        public static GlUniformMatrix3x2fv glUniformMatrix3x2fv;

        public function void GlUniformMatrix2x4fv(int location, int count, uint8 transpose, float* value);
        public static GlUniformMatrix2x4fv glUniformMatrix2x4fv;

        public function void GlUniformMatrix4x2fv(int location, int count, uint8 transpose, float* value);
        public static GlUniformMatrix4x2fv glUniformMatrix4x2fv;

        public function void GlUniformMatrix3x4fv(int location, int count, uint8 transpose, float* value);
        public static GlUniformMatrix3x4fv glUniformMatrix3x4fv;

        public function void GlUniformMatrix4x3fv(int location, int count, uint8 transpose, float* value);
        public static GlUniformMatrix4x3fv glUniformMatrix4x3fv;

        public function void GlColorMaski(uint index, uint8 r, uint8 g, uint8 b, uint8 a);
        public static GlColorMaski glColorMaski;

        public function void GlGetBooleani_v(uint target, uint index, uint8* data);
        public static GlGetBooleani_v glGetBooleani_v;

        public function void GlGetIntegeri_v(uint target, uint index, int32* data);
        public static GlGetIntegeri_v glGetIntegeri_v;

        public function void GlEnablei(uint target, uint index);
        public static GlEnablei glEnablei;

        public function void GlDisablei(uint target, uint index);
        public static GlDisablei glDisablei;

        public function uint8 GlIsEnabledi(uint target, uint index);
        public static GlIsEnabledi glIsEnabledi;

        public function void GlBeginTransformFeedback(uint primitiveMode);
        public static GlBeginTransformFeedback glBeginTransformFeedback;

        public function void GlEndTransformFeedback();
        public static GlEndTransformFeedback glEndTransformFeedback;

        public function void GlBindBufferRange(uint target, uint index, uint buffer, int offset, int size);
        public static GlBindBufferRange glBindBufferRange;

        public function void GlBindBufferBase(uint target, uint index, uint buffer);
        public static GlBindBufferBase glBindBufferBase;

        public function void GlTransformFeedbackVaryings(uint program, int count, char8** varyings, uint bufferMode);
        public static GlTransformFeedbackVaryings glTransformFeedbackVaryings;

        public function void GlGetTransformFeedbackVarying(uint program, uint index, int bufSize, int32* length, int32* size, uint32* type, char8* name);
        public static GlGetTransformFeedbackVarying glGetTransformFeedbackVarying;

        public function void GlClampColor(uint target, uint clamp);
        public static GlClampColor glClampColor;

        public function void GlBeginConditionalRender(uint id, uint mode);
        public static GlBeginConditionalRender glBeginConditionalRender;

        public function void GlEndConditionalRender();
        public static GlEndConditionalRender glEndConditionalRender;

        public function void GlVertexAttribIPointer(uint index, int size, uint type, int stride, void* pointer);
        public static GlVertexAttribIPointer glVertexAttribIPointer;

        public function void GlGetVertexAttribIiv(uint index, uint pname, int32* paramss);
        public static GlGetVertexAttribIiv glGetVertexAttribIiv;

        public function void GlGetVertexAttribIuiv(uint index, uint pname, uint32* paramss);
        public static GlGetVertexAttribIuiv glGetVertexAttribIuiv;

        public function void GlVertexAttribI1i(uint index, int x);
        public static GlVertexAttribI1i glVertexAttribI1i;

        public function void GlVertexAttribI2i(uint index, int x, int y);
        public static GlVertexAttribI2i glVertexAttribI2i;

        public function void GlVertexAttribI3i(uint index, int x, int y, int z);
        public static GlVertexAttribI3i glVertexAttribI3i;

        public function void GlVertexAttribI4i(uint index, int x, int y, int z, int w);
        public static GlVertexAttribI4i glVertexAttribI4i;

        public function void GlVertexAttribI1ui(uint index, uint x);
        public static GlVertexAttribI1ui glVertexAttribI1ui;

        public function void GlVertexAttribI2ui(uint index, uint x, uint y);
        public static GlVertexAttribI2ui glVertexAttribI2ui;

        public function void GlVertexAttribI3ui(uint index, uint x, uint y, uint z);
        public static GlVertexAttribI3ui glVertexAttribI3ui;

        public function void GlVertexAttribI4ui(uint index, uint x, uint y, uint z, uint w);
        public static GlVertexAttribI4ui glVertexAttribI4ui;

        public function void GlVertexAttribI1iv(uint index, int32* v);
        public static GlVertexAttribI1iv glVertexAttribI1iv;

        public function void GlVertexAttribI2iv(uint index, int32* v);
        public static GlVertexAttribI2iv glVertexAttribI2iv;

        public function void GlVertexAttribI3iv(uint index, int32* v);
        public static GlVertexAttribI3iv glVertexAttribI3iv;

        public function void GlVertexAttribI4iv(uint index, int32* v);
        public static GlVertexAttribI4iv glVertexAttribI4iv;

        public function void GlVertexAttribI1uiv(uint index, uint32* v);
        public static GlVertexAttribI1uiv glVertexAttribI1uiv;

        public function void GlVertexAttribI2uiv(uint index, uint32* v);
        public static GlVertexAttribI2uiv glVertexAttribI2uiv;

        public function void GlVertexAttribI3uiv(uint index, uint32* v);
        public static GlVertexAttribI3uiv glVertexAttribI3uiv;

        public function void GlVertexAttribI4uiv(uint index, uint32* v);
        public static GlVertexAttribI4uiv glVertexAttribI4uiv;

        public function void GlVertexAttribI4bv(uint index, int8* v);
        public static GlVertexAttribI4bv glVertexAttribI4bv;

        public function void GlVertexAttribI4sv(uint index, int16* v);
        public static GlVertexAttribI4sv glVertexAttribI4sv;

        public function void GlVertexAttribI4ubv(uint index, uint8* v);
        public static GlVertexAttribI4ubv glVertexAttribI4ubv;

        public function void GlVertexAttribI4usv(uint index, uint16* v);
        public static GlVertexAttribI4usv glVertexAttribI4usv;

        public function void GlGetUniformuiv(uint program, int location, uint32* paramss);
        public static GlGetUniformuiv glGetUniformuiv;

        public function void GlBindFragDataLocation(uint program, uint color, char8* name);
        public static GlBindFragDataLocation glBindFragDataLocation;

        public function int GlGetFragDataLocation(uint program, char8* name);
        public static GlGetFragDataLocation glGetFragDataLocation;

        public function void GlUniform1ui(int location, uint v0);
        public static GlUniform1ui glUniform1ui;

        public function void GlUniform2ui(int location, uint v0, uint v1);
        public static GlUniform2ui glUniform2ui;

        public function void GlUniform3ui(int location, uint v0, uint v1, uint v2);
        public static GlUniform3ui glUniform3ui;

        public function void GlUniform4ui(int location, uint v0, uint v1, uint v2, uint v3);
        public static GlUniform4ui glUniform4ui;

        public function void GlUniform1uiv(int location, int count, uint32* value);
        public static GlUniform1uiv glUniform1uiv;

        public function void GlUniform2uiv(int location, int count, uint32* value);
        public static GlUniform2uiv glUniform2uiv;

        public function void GlUniform3uiv(int location, int count, uint32* value);
        public static GlUniform3uiv glUniform3uiv;

        public function void GlUniform4uiv(int location, int count, uint32* value);
        public static GlUniform4uiv glUniform4uiv;

        public function void GlTexParameterIiv(uint target, uint pname, int32* paramss);
        public static GlTexParameterIiv glTexParameterIiv;

        public function void GlTexParameterIuiv(uint target, uint pname, uint32* paramss);
        public static GlTexParameterIuiv glTexParameterIuiv;

        public function void GlGetTexParameterIiv(uint target, uint pname, int32* paramss);
        public static GlGetTexParameterIiv glGetTexParameterIiv;

        public function void GlGetTexParameterIuiv(uint target, uint pname, uint32* paramss);
        public static GlGetTexParameterIuiv glGetTexParameterIuiv;

        public function void GlClearBufferiv(uint buffer, int drawbuffer, int32* value);
        public static GlClearBufferiv glClearBufferiv;

        public function void GlClearBufferuiv(uint buffer, int drawbuffer, uint32* value);
        public static GlClearBufferuiv glClearBufferuiv;

        public function void GlClearBufferfv(uint buffer, int drawbuffer, float* value);
        public static GlClearBufferfv glClearBufferfv;

        public function void GlClearBufferfi(uint buffer, int drawbuffer, float depth, int stencil);
        public static GlClearBufferfi glClearBufferfi;

        public function uint8 GlGetStringi(uint name, uint index);
        public static GlGetStringi glGetStringi;

        public function uint8 GlIsRenderbuffer(uint renderbuffer);
        public static GlIsRenderbuffer glIsRenderbuffer;

        public function void GlBindRenderbuffer(uint target, uint renderbuffer);
        public static GlBindRenderbuffer glBindRenderbuffer;

        public function void GlDeleteRenderbuffers(int n, uint32* renderbuffers);
        public static GlDeleteRenderbuffers glDeleteRenderbuffers;

        public function void GlGenRenderbuffers(int n, uint32* renderbuffers);
        public static GlGenRenderbuffers glGenRenderbuffers;

        public function void GlRenderbufferStorage(uint target, uint internalformat, int width, int height);
        public static GlRenderbufferStorage glRenderbufferStorage;

        public function void GlGetRenderbufferParameteriv(uint target, uint pname, int32* paramss);
        public static GlGetRenderbufferParameteriv glGetRenderbufferParameteriv;

        public function uint8 GlIsFramebuffer(uint framebuffer);
        public static GlIsFramebuffer glIsFramebuffer;

        public function void GlBindFramebuffer(uint target, uint framebuffer);
        public static GlBindFramebuffer glBindFramebuffer;

        public function void GlDeleteFramebuffers(int n, uint32* framebuffers);
        public static GlDeleteFramebuffers glDeleteFramebuffers;

        public function void GlGenFramebuffers(int n, uint32* framebuffers);
        public static GlGenFramebuffers glGenFramebuffers;

        public function uint GlCheckFramebufferStatus(uint target);
        public static GlCheckFramebufferStatus glCheckFramebufferStatus;

        public function void GlFramebufferTexture1D(uint target, uint attachment, uint textarget, uint texture, int level);
        public static GlFramebufferTexture1D glFramebufferTexture1D;

        public function void GlFramebufferTexture2D(uint target, uint attachment, uint textarget, uint texture, int level);
        public static GlFramebufferTexture2D glFramebufferTexture2D;

        public function void GlFramebufferTexture3D(uint target, uint attachment, uint textarget, uint texture, int level, int zoffset);
        public static GlFramebufferTexture3D glFramebufferTexture3D;

        public function void GlFramebufferRenderbuffer(uint target, uint attachment, uint renderbuffertarget, uint renderbuffer);
        public static GlFramebufferRenderbuffer glFramebufferRenderbuffer;

        public function void GlGetFramebufferAttachmentParameteriv(uint target, uint attachment, uint pname, int32* paramss);
        public static GlGetFramebufferAttachmentParameteriv glGetFramebufferAttachmentParameteriv;

        public function void GlGenerateMipmap(uint target);
        public static GlGenerateMipmap glGenerateMipmap;

        public function void GlBlitFramebuffer(int srcX0, int srcY0, int srcX1, int srcY1, int dstX0, int dstY0, int dstX1, int dstY1, uint mask, uint filter);
        public static GlBlitFramebuffer glBlitFramebuffer;

        public function void GlRenderbufferStorageMultisample(uint target, int samples, uint internalformat, int width, int height);
        public static GlRenderbufferStorageMultisample glRenderbufferStorageMultisample;

        public function void GlFramebufferTextureLayer(uint target, uint attachment, uint texture, int level, int layer);
        public static GlFramebufferTextureLayer glFramebufferTextureLayer;

        public function void GlMapBufferRange(uint target, int offset, int length, uint access);
        public static GlMapBufferRange glMapBufferRange;

        public function void GlFlushMappedBufferRange(uint target, int offset, int length);
        public static GlFlushMappedBufferRange glFlushMappedBufferRange;

        public function void GlBindVertexArray(uint array);
        public static GlBindVertexArray glBindVertexArray;

        public function void GlDeleteVertexArrays(int n, uint32* arrays);
        public static GlDeleteVertexArrays glDeleteVertexArrays;

        public function void GlGenVertexArrays(int n, uint32* arrays);
        public static GlGenVertexArrays glGenVertexArrays;

        public function uint8 GlIsVertexArray(uint array);
        public static GlIsVertexArray glIsVertexArray;

        public function void GlDrawArraysInstanced(uint mode, int first, int count, int instancecount);
        public static GlDrawArraysInstanced glDrawArraysInstanced;

        public function void GlDrawElementsInstanced(uint mode, int count, uint type, void* indices, int instancecount);
        public static GlDrawElementsInstanced glDrawElementsInstanced;

        public function void GlTexBuffer(uint target, uint internalformat, uint buffer);
        public static GlTexBuffer glTexBuffer;

        public function void GlPrimitiveRestartIndex(uint index);
        public static GlPrimitiveRestartIndex glPrimitiveRestartIndex;

        public function void GlCopyBufferSubData(uint readTarget, uint writeTarget, int readOffset, int writeOffset, int size);
        public static GlCopyBufferSubData glCopyBufferSubData;

        public function void GlGetUniformIndices(uint program, int uniformCount, char8** uniformNames, uint32* uniformIndices);
        public static GlGetUniformIndices glGetUniformIndices;

        public function void GlGetActiveUniformsiv(uint program, int uniformCount, uint32* uniformIndices, uint pname, int32* paramss);
        public static GlGetActiveUniformsiv glGetActiveUniformsiv;

        public function void GlGetActiveUniformName(uint program, uint uniformIndex, int bufSize, int32* length, char8* uniformName);
        public static GlGetActiveUniformName glGetActiveUniformName;

        public function uint GlGetUniformBlockIndex(uint program, char8* uniformBlockName);
        public static GlGetUniformBlockIndex glGetUniformBlockIndex;

        public function void GlGetActiveUniformBlockiv(uint program, uint uniformBlockIndex, uint pname, int32* paramss);
        public static GlGetActiveUniformBlockiv glGetActiveUniformBlockiv;

        public function void GlGetActiveUniformBlockName(uint program, uint uniformBlockIndex, int bufSize, int32* length, char8* uniformBlockName);
        public static GlGetActiveUniformBlockName glGetActiveUniformBlockName;

        public function void GlUniformBlockBinding(uint program, uint uniformBlockIndex, uint uniformBlockBinding);
        public static GlUniformBlockBinding glUniformBlockBinding;

        public function void GlDrawElementsBaseVertex(uint mode, int count, uint type, void* indices, int basevertex);
        public static GlDrawElementsBaseVertex glDrawElementsBaseVertex;

        public function void GlDrawRangeElementsBaseVertex(uint mode, uint start, uint end, int count, uint type, void* indices, int basevertex);
        public static GlDrawRangeElementsBaseVertex glDrawRangeElementsBaseVertex;

        public function void GlDrawElementsInstancedBaseVertex(uint mode, int count, uint type, void* indices, int instancecount, int basevertex);
        public static GlDrawElementsInstancedBaseVertex glDrawElementsInstancedBaseVertex;

        public function void GlMultiDrawElementsBaseVertex(uint mode, int32* count, uint type, void *** indices, int drawcount, int32* basevertex);
        public static GlMultiDrawElementsBaseVertex glMultiDrawElementsBaseVertex;

        public function void GlProvokingVertex(uint mode);
        public static GlProvokingVertex glProvokingVertex;

        public function void* GlFenceSync(uint condition, uint flags);
        public static GlFenceSync glFenceSync;

        public function uint8 GlIsSync(void* sync);
        public static GlIsSync glIsSync;

        public function void GlDeleteSync(void* sync);
        public static GlDeleteSync glDeleteSync;

        public function uint GlClientWaitSync(void* sync, uint flags, uint64 timeout);
        public static GlClientWaitSync glClientWaitSync;

        public function void GlWaitSync(void* sync, uint flags, uint64 timeout);
        public static GlWaitSync glWaitSync;

        public function void GlGetInteger64v(uint pname, int64* data);
        public static GlGetInteger64v glGetInteger64v;

        public function void GlGetSynciv(void* sync, uint pname, int count, int32* length, int32* values);
        public static GlGetSynciv glGetSynciv;

        public function void GlGetInteger64i_v(uint target, uint index, int64* data);
        public static GlGetInteger64i_v glGetInteger64i_v;

        public function void GlGetBufferParameteri64v(uint target, uint pname, int64* paramss);
        public static GlGetBufferParameteri64v glGetBufferParameteri64v;

        public function void GlFramebufferTexture(uint target, uint attachment, uint texture, int level);
        public static GlFramebufferTexture glFramebufferTexture;

        public function void GlTexImage2DMultisample(uint target, int samples, uint internalformat, int width, int height, uint8 fixedsamplelocations);
        public static GlTexImage2DMultisample glTexImage2DMultisample;

        public function void GlTexImage3DMultisample(uint target, int samples, uint internalformat, int width, int height, int depth, uint8 fixedsamplelocations);
        public static GlTexImage3DMultisample glTexImage3DMultisample;

        public function void GlGetMultisamplefv(uint pname, uint index, float* val);
        public static GlGetMultisamplefv glGetMultisamplefv;

        public function void GlSampleMaski(uint maskNumber, uint mask);
        public static GlSampleMaski glSampleMaski;

        public function void GlBindFragDataLocationIndexed(uint program, uint colorNumber, uint index, char8* name);
        public static GlBindFragDataLocationIndexed glBindFragDataLocationIndexed;

        public function int GlGetFragDataIndex(uint program, char8* name);
        public static GlGetFragDataIndex glGetFragDataIndex;

        public function void GlGenSamplers(int count, uint32* samplers);
        public static GlGenSamplers glGenSamplers;

        public function void GlDeleteSamplers(int count, uint32* samplers);
        public static GlDeleteSamplers glDeleteSamplers;

        public function uint8 GlIsSampler(uint sampler);
        public static GlIsSampler glIsSampler;

        public function void GlBindSampler(uint unit, uint sampler);
        public static GlBindSampler glBindSampler;

        public function void GlSamplerParameteri(uint sampler, uint pname, int param);
        public static GlSamplerParameteri glSamplerParameteri;

        public function void GlSamplerParameteriv(uint sampler, uint pname, int32* param);
        public static GlSamplerParameteriv glSamplerParameteriv;

        public function void GlSamplerParameterf(uint sampler, uint pname, float param);
        public static GlSamplerParameterf glSamplerParameterf;

        public function void GlSamplerParameterfv(uint sampler, uint pname, float* param);
        public static GlSamplerParameterfv glSamplerParameterfv;

        public function void GlSamplerParameterIiv(uint sampler, uint pname, int32* param);
        public static GlSamplerParameterIiv glSamplerParameterIiv;

        public function void GlSamplerParameterIuiv(uint sampler, uint pname, uint32* param);
        public static GlSamplerParameterIuiv glSamplerParameterIuiv;

        public function void GlGetSamplerParameteriv(uint sampler, uint pname, int32* paramss);
        public static GlGetSamplerParameteriv glGetSamplerParameteriv;

        public function void GlGetSamplerParameterIiv(uint sampler, uint pname, int32* paramss);
        public static GlGetSamplerParameterIiv glGetSamplerParameterIiv;

        public function void GlGetSamplerParameterfv(uint sampler, uint pname, float* paramss);
        public static GlGetSamplerParameterfv glGetSamplerParameterfv;

        public function void GlGetSamplerParameterIuiv(uint sampler, uint pname, uint32* paramss);
        public static GlGetSamplerParameterIuiv glGetSamplerParameterIuiv;

        public function void GlQueryCounter(uint id, uint target);
        public static GlQueryCounter glQueryCounter;

        public function void GlGetQueryObjecti64v(uint id, uint pname, int64* paramss);
        public static GlGetQueryObjecti64v glGetQueryObjecti64v;

        public function void GlGetQueryObjectui64v(uint id, uint pname, uint64* paramss);
        public static GlGetQueryObjectui64v glGetQueryObjectui64v;

        public function void GlVertexAttribDivisor(uint index, uint divisor);
        public static GlVertexAttribDivisor glVertexAttribDivisor;

        public function void GlVertexAttribP1ui(uint index, uint type, uint8 normalized, uint value);
        public static GlVertexAttribP1ui glVertexAttribP1ui;

        public function void GlVertexAttribP1uiv(uint index, uint type, uint8 normalized, uint32* value);
        public static GlVertexAttribP1uiv glVertexAttribP1uiv;

        public function void GlVertexAttribP2ui(uint index, uint type, uint8 normalized, uint value);
        public static GlVertexAttribP2ui glVertexAttribP2ui;

        public function void GlVertexAttribP2uiv(uint index, uint type, uint8 normalized, uint32* value);
        public static GlVertexAttribP2uiv glVertexAttribP2uiv;

        public function void GlVertexAttribP3ui(uint index, uint type, uint8 normalized, uint value);
        public static GlVertexAttribP3ui glVertexAttribP3ui;

        public function void GlVertexAttribP3uiv(uint index, uint type, uint8 normalized, uint32* value);
        public static GlVertexAttribP3uiv glVertexAttribP3uiv;

        public function void GlVertexAttribP4ui(uint index, uint type, uint8 normalized, uint value);
        public static GlVertexAttribP4ui glVertexAttribP4ui;

        public function void GlVertexAttribP4uiv(uint index, uint type, uint8 normalized, uint32* value);
        public static GlVertexAttribP4uiv glVertexAttribP4uiv;

        public static void Init(GetProcAddressFunc getProcAddress) {
            glCullFace = (GlCullFace) getProcAddress("glCullFace");
            glFrontFace = (GlFrontFace) getProcAddress("glFrontFace");
            glHint = (GlHint) getProcAddress("glHint");
            glLineWidth = (GlLineWidth) getProcAddress("glLineWidth");
            glPointSize = (GlPointSize) getProcAddress("glPointSize");
            glPolygonMode = (GlPolygonMode) getProcAddress("glPolygonMode");
            glScissor = (GlScissor) getProcAddress("glScissor");
            glTexParameterf = (GlTexParameterf) getProcAddress("glTexParameterf");
            glTexParameterfv = (GlTexParameterfv) getProcAddress("glTexParameterfv");
            glTexParameteri = (GlTexParameteri) getProcAddress("glTexParameteri");
            glTexParameteriv = (GlTexParameteriv) getProcAddress("glTexParameteriv");
            glTexImage1D = (GlTexImage1D) getProcAddress("glTexImage1D");
            glTexImage2D = (GlTexImage2D) getProcAddress("glTexImage2D");
            glDrawBuffer = (GlDrawBuffer) getProcAddress("glDrawBuffer");
            glClear = (GlClear) getProcAddress("glClear");
            glClearColor = (GlClearColor) getProcAddress("glClearColor");
            glClearStencil = (GlClearStencil) getProcAddress("glClearStencil");
            glClearDepth = (GlClearDepth) getProcAddress("glClearDepth");
            glStencilMask = (GlStencilMask) getProcAddress("glStencilMask");
            glColorMask = (GlColorMask) getProcAddress("glColorMask");
            glDepthMask = (GlDepthMask) getProcAddress("glDepthMask");
            glDisable = (GlDisable) getProcAddress("glDisable");
            glEnable = (GlEnable) getProcAddress("glEnable");
            glFinish = (GlFinish) getProcAddress("glFinish");
            glFlush = (GlFlush) getProcAddress("glFlush");
            glBlendFunc = (GlBlendFunc) getProcAddress("glBlendFunc");
            glLogicOp = (GlLogicOp) getProcAddress("glLogicOp");
            glStencilFunc = (GlStencilFunc) getProcAddress("glStencilFunc");
            glStencilOp = (GlStencilOp) getProcAddress("glStencilOp");
            glDepthFunc = (GlDepthFunc) getProcAddress("glDepthFunc");
            glPixelStoref = (GlPixelStoref) getProcAddress("glPixelStoref");
            glPixelStorei = (GlPixelStorei) getProcAddress("glPixelStorei");
            glReadBuffer = (GlReadBuffer) getProcAddress("glReadBuffer");
            glReadPixels = (GlReadPixels) getProcAddress("glReadPixels");
            glGetBooleanv = (GlGetBooleanv) getProcAddress("glGetBooleanv");
            glGetDoublev = (GlGetDoublev) getProcAddress("glGetDoublev");
            glGetError = (GlGetError) getProcAddress("glGetError");
            glGetFloatv = (GlGetFloatv) getProcAddress("glGetFloatv");
            glGetIntegerv = (GlGetIntegerv) getProcAddress("glGetIntegerv");
            glGetString = (GlGetString) getProcAddress("glGetString");
            glGetTexImage = (GlGetTexImage) getProcAddress("glGetTexImage");
            glGetTexParameterfv = (GlGetTexParameterfv) getProcAddress("glGetTexParameterfv");
            glGetTexParameteriv = (GlGetTexParameteriv) getProcAddress("glGetTexParameteriv");
            glGetTexLevelParameterfv = (GlGetTexLevelParameterfv) getProcAddress("glGetTexLevelParameterfv");
            glGetTexLevelParameteriv = (GlGetTexLevelParameteriv) getProcAddress("glGetTexLevelParameteriv");
            glIsEnabled = (GlIsEnabled) getProcAddress("glIsEnabled");
            glDepthRange = (GlDepthRange) getProcAddress("glDepthRange");
            glViewport = (GlViewport) getProcAddress("glViewport");
            glDrawArrays = (GlDrawArrays) getProcAddress("glDrawArrays");
            glDrawElements = (GlDrawElements) getProcAddress("glDrawElements");
            glPolygonOffset = (GlPolygonOffset) getProcAddress("glPolygonOffset");
            glCopyTexImage1D = (GlCopyTexImage1D) getProcAddress("glCopyTexImage1D");
            glCopyTexImage2D = (GlCopyTexImage2D) getProcAddress("glCopyTexImage2D");
            glCopyTexSubImage1D = (GlCopyTexSubImage1D) getProcAddress("glCopyTexSubImage1D");
            glCopyTexSubImage2D = (GlCopyTexSubImage2D) getProcAddress("glCopyTexSubImage2D");
            glTexSubImage1D = (GlTexSubImage1D) getProcAddress("glTexSubImage1D");
            glTexSubImage2D = (GlTexSubImage2D) getProcAddress("glTexSubImage2D");
            glBindTexture = (GlBindTexture) getProcAddress("glBindTexture");
            glDeleteTextures = (GlDeleteTextures) getProcAddress("glDeleteTextures");
            glGenTextures = (GlGenTextures) getProcAddress("glGenTextures");
            glIsTexture = (GlIsTexture) getProcAddress("glIsTexture");
            glDrawRangeElements = (GlDrawRangeElements) getProcAddress("glDrawRangeElements");
            glTexImage3D = (GlTexImage3D) getProcAddress("glTexImage3D");
            glTexSubImage3D = (GlTexSubImage3D) getProcAddress("glTexSubImage3D");
            glCopyTexSubImage3D = (GlCopyTexSubImage3D) getProcAddress("glCopyTexSubImage3D");
            glActiveTexture = (GlActiveTexture) getProcAddress("glActiveTexture");
            glSampleCoverage = (GlSampleCoverage) getProcAddress("glSampleCoverage");
            glCompressedTexImage3D = (GlCompressedTexImage3D) getProcAddress("glCompressedTexImage3D");
            glCompressedTexImage2D = (GlCompressedTexImage2D) getProcAddress("glCompressedTexImage2D");
            glCompressedTexImage1D = (GlCompressedTexImage1D) getProcAddress("glCompressedTexImage1D");
            glCompressedTexSubImage3D = (GlCompressedTexSubImage3D) getProcAddress("glCompressedTexSubImage3D");
            glCompressedTexSubImage2D = (GlCompressedTexSubImage2D) getProcAddress("glCompressedTexSubImage2D");
            glCompressedTexSubImage1D = (GlCompressedTexSubImage1D) getProcAddress("glCompressedTexSubImage1D");
            glGetCompressedTexImage = (GlGetCompressedTexImage) getProcAddress("glGetCompressedTexImage");
            glBlendFuncSeparate = (GlBlendFuncSeparate) getProcAddress("glBlendFuncSeparate");
            glMultiDrawArrays = (GlMultiDrawArrays) getProcAddress("glMultiDrawArrays");
            glMultiDrawElements = (GlMultiDrawElements) getProcAddress("glMultiDrawElements");
            glPointParameterf = (GlPointParameterf) getProcAddress("glPointParameterf");
            glPointParameterfv = (GlPointParameterfv) getProcAddress("glPointParameterfv");
            glPointParameteri = (GlPointParameteri) getProcAddress("glPointParameteri");
            glPointParameteriv = (GlPointParameteriv) getProcAddress("glPointParameteriv");
            glBlendColor = (GlBlendColor) getProcAddress("glBlendColor");
            glBlendEquation = (GlBlendEquation) getProcAddress("glBlendEquation");
            glGenQueries = (GlGenQueries) getProcAddress("glGenQueries");
            glDeleteQueries = (GlDeleteQueries) getProcAddress("glDeleteQueries");
            glIsQuery = (GlIsQuery) getProcAddress("glIsQuery");
            glBeginQuery = (GlBeginQuery) getProcAddress("glBeginQuery");
            glEndQuery = (GlEndQuery) getProcAddress("glEndQuery");
            glGetQueryiv = (GlGetQueryiv) getProcAddress("glGetQueryiv");
            glGetQueryObjectiv = (GlGetQueryObjectiv) getProcAddress("glGetQueryObjectiv");
            glGetQueryObjectuiv = (GlGetQueryObjectuiv) getProcAddress("glGetQueryObjectuiv");
            glBindBuffer = (GlBindBuffer) getProcAddress("glBindBuffer");
            glDeleteBuffers = (GlDeleteBuffers) getProcAddress("glDeleteBuffers");
            glGenBuffers = (GlGenBuffers) getProcAddress("glGenBuffers");
            glIsBuffer = (GlIsBuffer) getProcAddress("glIsBuffer");
            glBufferData = (GlBufferData) getProcAddress("glBufferData");
            glBufferSubData = (GlBufferSubData) getProcAddress("glBufferSubData");
            glGetBufferSubData = (GlGetBufferSubData) getProcAddress("glGetBufferSubData");
            glMapBuffer = (GlMapBuffer) getProcAddress("glMapBuffer");
            glUnmapBuffer = (GlUnmapBuffer) getProcAddress("glUnmapBuffer");
            glGetBufferParameteriv = (GlGetBufferParameteriv) getProcAddress("glGetBufferParameteriv");
            glGetBufferPointerv = (GlGetBufferPointerv) getProcAddress("glGetBufferPointerv");
            glBlendEquationSeparate = (GlBlendEquationSeparate) getProcAddress("glBlendEquationSeparate");
            glDrawBuffers = (GlDrawBuffers) getProcAddress("glDrawBuffers");
            glStencilOpSeparate = (GlStencilOpSeparate) getProcAddress("glStencilOpSeparate");
            glStencilFuncSeparate = (GlStencilFuncSeparate) getProcAddress("glStencilFuncSeparate");
            glStencilMaskSeparate = (GlStencilMaskSeparate) getProcAddress("glStencilMaskSeparate");
            glAttachShader = (GlAttachShader) getProcAddress("glAttachShader");
            glBindAttribLocation = (GlBindAttribLocation) getProcAddress("glBindAttribLocation");
            glCompileShader = (GlCompileShader) getProcAddress("glCompileShader");
            glCreateProgram = (GlCreateProgram) getProcAddress("glCreateProgram");
            glCreateShader = (GlCreateShader) getProcAddress("glCreateShader");
            glDeleteProgram = (GlDeleteProgram) getProcAddress("glDeleteProgram");
            glDeleteShader = (GlDeleteShader) getProcAddress("glDeleteShader");
            glDetachShader = (GlDetachShader) getProcAddress("glDetachShader");
            glDisableVertexAttribArray = (GlDisableVertexAttribArray) getProcAddress("glDisableVertexAttribArray");
            glEnableVertexAttribArray = (GlEnableVertexAttribArray) getProcAddress("glEnableVertexAttribArray");
            glGetActiveAttrib = (GlGetActiveAttrib) getProcAddress("glGetActiveAttrib");
            glGetActiveUniform = (GlGetActiveUniform) getProcAddress("glGetActiveUniform");
            glGetAttachedShaders = (GlGetAttachedShaders) getProcAddress("glGetAttachedShaders");
            glGetAttribLocation = (GlGetAttribLocation) getProcAddress("glGetAttribLocation");
            glGetProgramiv = (GlGetProgramiv) getProcAddress("glGetProgramiv");
            glGetProgramInfoLog = (GlGetProgramInfoLog) getProcAddress("glGetProgramInfoLog");
            glGetShaderiv = (GlGetShaderiv) getProcAddress("glGetShaderiv");
            glGetShaderInfoLog = (GlGetShaderInfoLog) getProcAddress("glGetShaderInfoLog");
            glGetShaderSource = (GlGetShaderSource) getProcAddress("glGetShaderSource");
            glGetUniformLocation = (GlGetUniformLocation) getProcAddress("glGetUniformLocation");
            glGetUniformfv = (GlGetUniformfv) getProcAddress("glGetUniformfv");
            glGetUniformiv = (GlGetUniformiv) getProcAddress("glGetUniformiv");
            glGetVertexAttribdv = (GlGetVertexAttribdv) getProcAddress("glGetVertexAttribdv");
            glGetVertexAttribfv = (GlGetVertexAttribfv) getProcAddress("glGetVertexAttribfv");
            glGetVertexAttribiv = (GlGetVertexAttribiv) getProcAddress("glGetVertexAttribiv");
            glGetVertexAttribPointerv = (GlGetVertexAttribPointerv) getProcAddress("glGetVertexAttribPointerv");
            glIsProgram = (GlIsProgram) getProcAddress("glIsProgram");
            glIsShader = (GlIsShader) getProcAddress("glIsShader");
            glLinkProgram = (GlLinkProgram) getProcAddress("glLinkProgram");
            glShaderSource = (GlShaderSource) getProcAddress("glShaderSource");
            glUseProgram = (GlUseProgram) getProcAddress("glUseProgram");
            glUniform1f = (GlUniform1f) getProcAddress("glUniform1f");
            glUniform2f = (GlUniform2f) getProcAddress("glUniform2f");
            glUniform3f = (GlUniform3f) getProcAddress("glUniform3f");
            glUniform4f = (GlUniform4f) getProcAddress("glUniform4f");
            glUniform1i = (GlUniform1i) getProcAddress("glUniform1i");
            glUniform2i = (GlUniform2i) getProcAddress("glUniform2i");
            glUniform3i = (GlUniform3i) getProcAddress("glUniform3i");
            glUniform4i = (GlUniform4i) getProcAddress("glUniform4i");
            glUniform1fv = (GlUniform1fv) getProcAddress("glUniform1fv");
            glUniform2fv = (GlUniform2fv) getProcAddress("glUniform2fv");
            glUniform3fv = (GlUniform3fv) getProcAddress("glUniform3fv");
            glUniform4fv = (GlUniform4fv) getProcAddress("glUniform4fv");
            glUniform1iv = (GlUniform1iv) getProcAddress("glUniform1iv");
            glUniform2iv = (GlUniform2iv) getProcAddress("glUniform2iv");
            glUniform3iv = (GlUniform3iv) getProcAddress("glUniform3iv");
            glUniform4iv = (GlUniform4iv) getProcAddress("glUniform4iv");
            glUniformMatrix2fv = (GlUniformMatrix2fv) getProcAddress("glUniformMatrix2fv");
            glUniformMatrix3fv = (GlUniformMatrix3fv) getProcAddress("glUniformMatrix3fv");
            glUniformMatrix4fv = (GlUniformMatrix4fv) getProcAddress("glUniformMatrix4fv");
            glValidateProgram = (GlValidateProgram) getProcAddress("glValidateProgram");
            glVertexAttrib1d = (GlVertexAttrib1d) getProcAddress("glVertexAttrib1d");
            glVertexAttrib1dv = (GlVertexAttrib1dv) getProcAddress("glVertexAttrib1dv");
            glVertexAttrib1f = (GlVertexAttrib1f) getProcAddress("glVertexAttrib1f");
            glVertexAttrib1fv = (GlVertexAttrib1fv) getProcAddress("glVertexAttrib1fv");
            glVertexAttrib1s = (GlVertexAttrib1s) getProcAddress("glVertexAttrib1s");
            glVertexAttrib1sv = (GlVertexAttrib1sv) getProcAddress("glVertexAttrib1sv");
            glVertexAttrib2d = (GlVertexAttrib2d) getProcAddress("glVertexAttrib2d");
            glVertexAttrib2dv = (GlVertexAttrib2dv) getProcAddress("glVertexAttrib2dv");
            glVertexAttrib2f = (GlVertexAttrib2f) getProcAddress("glVertexAttrib2f");
            glVertexAttrib2fv = (GlVertexAttrib2fv) getProcAddress("glVertexAttrib2fv");
            glVertexAttrib2s = (GlVertexAttrib2s) getProcAddress("glVertexAttrib2s");
            glVertexAttrib2sv = (GlVertexAttrib2sv) getProcAddress("glVertexAttrib2sv");
            glVertexAttrib3d = (GlVertexAttrib3d) getProcAddress("glVertexAttrib3d");
            glVertexAttrib3dv = (GlVertexAttrib3dv) getProcAddress("glVertexAttrib3dv");
            glVertexAttrib3f = (GlVertexAttrib3f) getProcAddress("glVertexAttrib3f");
            glVertexAttrib3fv = (GlVertexAttrib3fv) getProcAddress("glVertexAttrib3fv");
            glVertexAttrib3s = (GlVertexAttrib3s) getProcAddress("glVertexAttrib3s");
            glVertexAttrib3sv = (GlVertexAttrib3sv) getProcAddress("glVertexAttrib3sv");
            glVertexAttrib4Nbv = (GlVertexAttrib4Nbv) getProcAddress("glVertexAttrib4Nbv");
            glVertexAttrib4Niv = (GlVertexAttrib4Niv) getProcAddress("glVertexAttrib4Niv");
            glVertexAttrib4Nsv = (GlVertexAttrib4Nsv) getProcAddress("glVertexAttrib4Nsv");
            glVertexAttrib4Nub = (GlVertexAttrib4Nub) getProcAddress("glVertexAttrib4Nub");
            glVertexAttrib4Nubv = (GlVertexAttrib4Nubv) getProcAddress("glVertexAttrib4Nubv");
            glVertexAttrib4Nuiv = (GlVertexAttrib4Nuiv) getProcAddress("glVertexAttrib4Nuiv");
            glVertexAttrib4Nusv = (GlVertexAttrib4Nusv) getProcAddress("glVertexAttrib4Nusv");
            glVertexAttrib4bv = (GlVertexAttrib4bv) getProcAddress("glVertexAttrib4bv");
            glVertexAttrib4d = (GlVertexAttrib4d) getProcAddress("glVertexAttrib4d");
            glVertexAttrib4dv = (GlVertexAttrib4dv) getProcAddress("glVertexAttrib4dv");
            glVertexAttrib4f = (GlVertexAttrib4f) getProcAddress("glVertexAttrib4f");
            glVertexAttrib4fv = (GlVertexAttrib4fv) getProcAddress("glVertexAttrib4fv");
            glVertexAttrib4iv = (GlVertexAttrib4iv) getProcAddress("glVertexAttrib4iv");
            glVertexAttrib4s = (GlVertexAttrib4s) getProcAddress("glVertexAttrib4s");
            glVertexAttrib4sv = (GlVertexAttrib4sv) getProcAddress("glVertexAttrib4sv");
            glVertexAttrib4ubv = (GlVertexAttrib4ubv) getProcAddress("glVertexAttrib4ubv");
            glVertexAttrib4uiv = (GlVertexAttrib4uiv) getProcAddress("glVertexAttrib4uiv");
            glVertexAttrib4usv = (GlVertexAttrib4usv) getProcAddress("glVertexAttrib4usv");
            glVertexAttribPointer = (GlVertexAttribPointer) getProcAddress("glVertexAttribPointer");
            glUniformMatrix2x3fv = (GlUniformMatrix2x3fv) getProcAddress("glUniformMatrix2x3fv");
            glUniformMatrix3x2fv = (GlUniformMatrix3x2fv) getProcAddress("glUniformMatrix3x2fv");
            glUniformMatrix2x4fv = (GlUniformMatrix2x4fv) getProcAddress("glUniformMatrix2x4fv");
            glUniformMatrix4x2fv = (GlUniformMatrix4x2fv) getProcAddress("glUniformMatrix4x2fv");
            glUniformMatrix3x4fv = (GlUniformMatrix3x4fv) getProcAddress("glUniformMatrix3x4fv");
            glUniformMatrix4x3fv = (GlUniformMatrix4x3fv) getProcAddress("glUniformMatrix4x3fv");
            glColorMaski = (GlColorMaski) getProcAddress("glColorMaski");
            glGetBooleani_v = (GlGetBooleani_v) getProcAddress("glGetBooleani_v");
            glGetIntegeri_v = (GlGetIntegeri_v) getProcAddress("glGetIntegeri_v");
            glEnablei = (GlEnablei) getProcAddress("glEnablei");
            glDisablei = (GlDisablei) getProcAddress("glDisablei");
            glIsEnabledi = (GlIsEnabledi) getProcAddress("glIsEnabledi");
            glBeginTransformFeedback = (GlBeginTransformFeedback) getProcAddress("glBeginTransformFeedback");
            glEndTransformFeedback = (GlEndTransformFeedback) getProcAddress("glEndTransformFeedback");
            glBindBufferRange = (GlBindBufferRange) getProcAddress("glBindBufferRange");
            glBindBufferBase = (GlBindBufferBase) getProcAddress("glBindBufferBase");
            glTransformFeedbackVaryings = (GlTransformFeedbackVaryings) getProcAddress("glTransformFeedbackVaryings");
            glGetTransformFeedbackVarying = (GlGetTransformFeedbackVarying) getProcAddress("glGetTransformFeedbackVarying");
            glClampColor = (GlClampColor) getProcAddress("glClampColor");
            glBeginConditionalRender = (GlBeginConditionalRender) getProcAddress("glBeginConditionalRender");
            glEndConditionalRender = (GlEndConditionalRender) getProcAddress("glEndConditionalRender");
            glVertexAttribIPointer = (GlVertexAttribIPointer) getProcAddress("glVertexAttribIPointer");
            glGetVertexAttribIiv = (GlGetVertexAttribIiv) getProcAddress("glGetVertexAttribIiv");
            glGetVertexAttribIuiv = (GlGetVertexAttribIuiv) getProcAddress("glGetVertexAttribIuiv");
            glVertexAttribI1i = (GlVertexAttribI1i) getProcAddress("glVertexAttribI1i");
            glVertexAttribI2i = (GlVertexAttribI2i) getProcAddress("glVertexAttribI2i");
            glVertexAttribI3i = (GlVertexAttribI3i) getProcAddress("glVertexAttribI3i");
            glVertexAttribI4i = (GlVertexAttribI4i) getProcAddress("glVertexAttribI4i");
            glVertexAttribI1ui = (GlVertexAttribI1ui) getProcAddress("glVertexAttribI1ui");
            glVertexAttribI2ui = (GlVertexAttribI2ui) getProcAddress("glVertexAttribI2ui");
            glVertexAttribI3ui = (GlVertexAttribI3ui) getProcAddress("glVertexAttribI3ui");
            glVertexAttribI4ui = (GlVertexAttribI4ui) getProcAddress("glVertexAttribI4ui");
            glVertexAttribI1iv = (GlVertexAttribI1iv) getProcAddress("glVertexAttribI1iv");
            glVertexAttribI2iv = (GlVertexAttribI2iv) getProcAddress("glVertexAttribI2iv");
            glVertexAttribI3iv = (GlVertexAttribI3iv) getProcAddress("glVertexAttribI3iv");
            glVertexAttribI4iv = (GlVertexAttribI4iv) getProcAddress("glVertexAttribI4iv");
            glVertexAttribI1uiv = (GlVertexAttribI1uiv) getProcAddress("glVertexAttribI1uiv");
            glVertexAttribI2uiv = (GlVertexAttribI2uiv) getProcAddress("glVertexAttribI2uiv");
            glVertexAttribI3uiv = (GlVertexAttribI3uiv) getProcAddress("glVertexAttribI3uiv");
            glVertexAttribI4uiv = (GlVertexAttribI4uiv) getProcAddress("glVertexAttribI4uiv");
            glVertexAttribI4bv = (GlVertexAttribI4bv) getProcAddress("glVertexAttribI4bv");
            glVertexAttribI4sv = (GlVertexAttribI4sv) getProcAddress("glVertexAttribI4sv");
            glVertexAttribI4ubv = (GlVertexAttribI4ubv) getProcAddress("glVertexAttribI4ubv");
            glVertexAttribI4usv = (GlVertexAttribI4usv) getProcAddress("glVertexAttribI4usv");
            glGetUniformuiv = (GlGetUniformuiv) getProcAddress("glGetUniformuiv");
            glBindFragDataLocation = (GlBindFragDataLocation) getProcAddress("glBindFragDataLocation");
            glGetFragDataLocation = (GlGetFragDataLocation) getProcAddress("glGetFragDataLocation");
            glUniform1ui = (GlUniform1ui) getProcAddress("glUniform1ui");
            glUniform2ui = (GlUniform2ui) getProcAddress("glUniform2ui");
            glUniform3ui = (GlUniform3ui) getProcAddress("glUniform3ui");
            glUniform4ui = (GlUniform4ui) getProcAddress("glUniform4ui");
            glUniform1uiv = (GlUniform1uiv) getProcAddress("glUniform1uiv");
            glUniform2uiv = (GlUniform2uiv) getProcAddress("glUniform2uiv");
            glUniform3uiv = (GlUniform3uiv) getProcAddress("glUniform3uiv");
            glUniform4uiv = (GlUniform4uiv) getProcAddress("glUniform4uiv");
            glTexParameterIiv = (GlTexParameterIiv) getProcAddress("glTexParameterIiv");
            glTexParameterIuiv = (GlTexParameterIuiv) getProcAddress("glTexParameterIuiv");
            glGetTexParameterIiv = (GlGetTexParameterIiv) getProcAddress("glGetTexParameterIiv");
            glGetTexParameterIuiv = (GlGetTexParameterIuiv) getProcAddress("glGetTexParameterIuiv");
            glClearBufferiv = (GlClearBufferiv) getProcAddress("glClearBufferiv");
            glClearBufferuiv = (GlClearBufferuiv) getProcAddress("glClearBufferuiv");
            glClearBufferfv = (GlClearBufferfv) getProcAddress("glClearBufferfv");
            glClearBufferfi = (GlClearBufferfi) getProcAddress("glClearBufferfi");
            glGetStringi = (GlGetStringi) getProcAddress("glGetStringi");
            glIsRenderbuffer = (GlIsRenderbuffer) getProcAddress("glIsRenderbuffer");
            glBindRenderbuffer = (GlBindRenderbuffer) getProcAddress("glBindRenderbuffer");
            glDeleteRenderbuffers = (GlDeleteRenderbuffers) getProcAddress("glDeleteRenderbuffers");
            glGenRenderbuffers = (GlGenRenderbuffers) getProcAddress("glGenRenderbuffers");
            glRenderbufferStorage = (GlRenderbufferStorage) getProcAddress("glRenderbufferStorage");
            glGetRenderbufferParameteriv = (GlGetRenderbufferParameteriv) getProcAddress("glGetRenderbufferParameteriv");
            glIsFramebuffer = (GlIsFramebuffer) getProcAddress("glIsFramebuffer");
            glBindFramebuffer = (GlBindFramebuffer) getProcAddress("glBindFramebuffer");
            glDeleteFramebuffers = (GlDeleteFramebuffers) getProcAddress("glDeleteFramebuffers");
            glGenFramebuffers = (GlGenFramebuffers) getProcAddress("glGenFramebuffers");
            glCheckFramebufferStatus = (GlCheckFramebufferStatus) getProcAddress("glCheckFramebufferStatus");
            glFramebufferTexture1D = (GlFramebufferTexture1D) getProcAddress("glFramebufferTexture1D");
            glFramebufferTexture2D = (GlFramebufferTexture2D) getProcAddress("glFramebufferTexture2D");
            glFramebufferTexture3D = (GlFramebufferTexture3D) getProcAddress("glFramebufferTexture3D");
            glFramebufferRenderbuffer = (GlFramebufferRenderbuffer) getProcAddress("glFramebufferRenderbuffer");
            glGetFramebufferAttachmentParameteriv = (GlGetFramebufferAttachmentParameteriv) getProcAddress("glGetFramebufferAttachmentParameteriv");
            glGenerateMipmap = (GlGenerateMipmap) getProcAddress("glGenerateMipmap");
            glBlitFramebuffer = (GlBlitFramebuffer) getProcAddress("glBlitFramebuffer");
            glRenderbufferStorageMultisample = (GlRenderbufferStorageMultisample) getProcAddress("glRenderbufferStorageMultisample");
            glFramebufferTextureLayer = (GlFramebufferTextureLayer) getProcAddress("glFramebufferTextureLayer");
            glMapBufferRange = (GlMapBufferRange) getProcAddress("glMapBufferRange");
            glFlushMappedBufferRange = (GlFlushMappedBufferRange) getProcAddress("glFlushMappedBufferRange");
            glBindVertexArray = (GlBindVertexArray) getProcAddress("glBindVertexArray");
            glDeleteVertexArrays = (GlDeleteVertexArrays) getProcAddress("glDeleteVertexArrays");
            glGenVertexArrays = (GlGenVertexArrays) getProcAddress("glGenVertexArrays");
            glIsVertexArray = (GlIsVertexArray) getProcAddress("glIsVertexArray");
            glDrawArraysInstanced = (GlDrawArraysInstanced) getProcAddress("glDrawArraysInstanced");
            glDrawElementsInstanced = (GlDrawElementsInstanced) getProcAddress("glDrawElementsInstanced");
            glTexBuffer = (GlTexBuffer) getProcAddress("glTexBuffer");
            glPrimitiveRestartIndex = (GlPrimitiveRestartIndex) getProcAddress("glPrimitiveRestartIndex");
            glCopyBufferSubData = (GlCopyBufferSubData) getProcAddress("glCopyBufferSubData");
            glGetUniformIndices = (GlGetUniformIndices) getProcAddress("glGetUniformIndices");
            glGetActiveUniformsiv = (GlGetActiveUniformsiv) getProcAddress("glGetActiveUniformsiv");
            glGetActiveUniformName = (GlGetActiveUniformName) getProcAddress("glGetActiveUniformName");
            glGetUniformBlockIndex = (GlGetUniformBlockIndex) getProcAddress("glGetUniformBlockIndex");
            glGetActiveUniformBlockiv = (GlGetActiveUniformBlockiv) getProcAddress("glGetActiveUniformBlockiv");
            glGetActiveUniformBlockName = (GlGetActiveUniformBlockName) getProcAddress("glGetActiveUniformBlockName");
            glUniformBlockBinding = (GlUniformBlockBinding) getProcAddress("glUniformBlockBinding");
            glDrawElementsBaseVertex = (GlDrawElementsBaseVertex) getProcAddress("glDrawElementsBaseVertex");
            glDrawRangeElementsBaseVertex = (GlDrawRangeElementsBaseVertex) getProcAddress("glDrawRangeElementsBaseVertex");
            glDrawElementsInstancedBaseVertex = (GlDrawElementsInstancedBaseVertex) getProcAddress("glDrawElementsInstancedBaseVertex");
            glMultiDrawElementsBaseVertex = (GlMultiDrawElementsBaseVertex) getProcAddress("glMultiDrawElementsBaseVertex");
            glProvokingVertex = (GlProvokingVertex) getProcAddress("glProvokingVertex");
            glFenceSync = (GlFenceSync) getProcAddress("glFenceSync");
            glIsSync = (GlIsSync) getProcAddress("glIsSync");
            glDeleteSync = (GlDeleteSync) getProcAddress("glDeleteSync");
            glClientWaitSync = (GlClientWaitSync) getProcAddress("glClientWaitSync");
            glWaitSync = (GlWaitSync) getProcAddress("glWaitSync");
            glGetInteger64v = (GlGetInteger64v) getProcAddress("glGetInteger64v");
            glGetSynciv = (GlGetSynciv) getProcAddress("glGetSynciv");
            glGetInteger64i_v = (GlGetInteger64i_v) getProcAddress("glGetInteger64i_v");
            glGetBufferParameteri64v = (GlGetBufferParameteri64v) getProcAddress("glGetBufferParameteri64v");
            glFramebufferTexture = (GlFramebufferTexture) getProcAddress("glFramebufferTexture");
            glTexImage2DMultisample = (GlTexImage2DMultisample) getProcAddress("glTexImage2DMultisample");
            glTexImage3DMultisample = (GlTexImage3DMultisample) getProcAddress("glTexImage3DMultisample");
            glGetMultisamplefv = (GlGetMultisamplefv) getProcAddress("glGetMultisamplefv");
            glSampleMaski = (GlSampleMaski) getProcAddress("glSampleMaski");
            glBindFragDataLocationIndexed = (GlBindFragDataLocationIndexed) getProcAddress("glBindFragDataLocationIndexed");
            glGetFragDataIndex = (GlGetFragDataIndex) getProcAddress("glGetFragDataIndex");
            glGenSamplers = (GlGenSamplers) getProcAddress("glGenSamplers");
            glDeleteSamplers = (GlDeleteSamplers) getProcAddress("glDeleteSamplers");
            glIsSampler = (GlIsSampler) getProcAddress("glIsSampler");
            glBindSampler = (GlBindSampler) getProcAddress("glBindSampler");
            glSamplerParameteri = (GlSamplerParameteri) getProcAddress("glSamplerParameteri");
            glSamplerParameteriv = (GlSamplerParameteriv) getProcAddress("glSamplerParameteriv");
            glSamplerParameterf = (GlSamplerParameterf) getProcAddress("glSamplerParameterf");
            glSamplerParameterfv = (GlSamplerParameterfv) getProcAddress("glSamplerParameterfv");
            glSamplerParameterIiv = (GlSamplerParameterIiv) getProcAddress("glSamplerParameterIiv");
            glSamplerParameterIuiv = (GlSamplerParameterIuiv) getProcAddress("glSamplerParameterIuiv");
            glGetSamplerParameteriv = (GlGetSamplerParameteriv) getProcAddress("glGetSamplerParameteriv");
            glGetSamplerParameterIiv = (GlGetSamplerParameterIiv) getProcAddress("glGetSamplerParameterIiv");
            glGetSamplerParameterfv = (GlGetSamplerParameterfv) getProcAddress("glGetSamplerParameterfv");
            glGetSamplerParameterIuiv = (GlGetSamplerParameterIuiv) getProcAddress("glGetSamplerParameterIuiv");
            glQueryCounter = (GlQueryCounter) getProcAddress("glQueryCounter");
            glGetQueryObjecti64v = (GlGetQueryObjecti64v) getProcAddress("glGetQueryObjecti64v");
            glGetQueryObjectui64v = (GlGetQueryObjectui64v) getProcAddress("glGetQueryObjectui64v");
            glVertexAttribDivisor = (GlVertexAttribDivisor) getProcAddress("glVertexAttribDivisor");
            glVertexAttribP1ui = (GlVertexAttribP1ui) getProcAddress("glVertexAttribP1ui");
            glVertexAttribP1uiv = (GlVertexAttribP1uiv) getProcAddress("glVertexAttribP1uiv");
            glVertexAttribP2ui = (GlVertexAttribP2ui) getProcAddress("glVertexAttribP2ui");
            glVertexAttribP2uiv = (GlVertexAttribP2uiv) getProcAddress("glVertexAttribP2uiv");
            glVertexAttribP3ui = (GlVertexAttribP3ui) getProcAddress("glVertexAttribP3ui");
            glVertexAttribP3uiv = (GlVertexAttribP3uiv) getProcAddress("glVertexAttribP3uiv");
            glVertexAttribP4ui = (GlVertexAttribP4ui) getProcAddress("glVertexAttribP4ui");
            glVertexAttribP4uiv = (GlVertexAttribP4uiv) getProcAddress("glVertexAttribP4uiv");
        }
    }
}
