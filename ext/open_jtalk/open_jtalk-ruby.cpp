#include <stdio.h>
#include <ruby.h>
#include <ruby/encoding.h>

/* Main headers */
#include "mecab.h"
#include "njd.h"
#include "jpcommon.h"
#include "HTS_engine.h"
#include "HTS_hidden.h"

/* Sub headers */
#include "text2mecab.h"
#include "mecab2njd.h"
#include "njd_set_pronunciation.h"
#include "njd_set_digit.h"
#include "njd_set_accent_phrase.h"
#include "njd_set_accent_type.h"
#include "njd_set_unvoiced_vowel.h"
#include "njd_set_long_vowel.h"
#include "njd2jpcommon.h"

#ifdef __cplusplus
#  define PROTECTFUNC(f) ((VALUE (*)(VALUE)) f)
#  define VALUEFUNC(f) ((VALUE (*)(ANYARGS)) f)
#  define VOIDFUNC(f)  ((RUBY_DATA_FUNC) f)
#else
#  define VALUEFUNC(f) (f)
#  define VOIDFUNC(f) (f)
#endif

#define OPENJTALK_MAXSPEED    10.0
#define OPENJTALK_MINSPEED    0.1
#define OPENJTALK_MAXHALFTONE 24.0
#define OPENJTALK_MINHALFTONE -24.0
#define OPENJTALK_MAXALPHA    1.0
#define OPENJTALK_MINALPHA    0.0
#define OPENJTALK_MAXVOLUME   10.0
#define OPENJTALK_MINVOLUME   0.0

namespace {
    struct open_jtalk {
        bool initialized;
        Mecab m_mecab;
        HTS_Engine m_engine;
        NJD m_njd;
        JPCommon m_jpcommon;
    };

    static void open_jtalk_mark(struct open_jtalk *ptr)
    {
    }

    static void open_jtalk_free(struct open_jtalk *ptr)
    {
        if (ptr->initialized) {
            JPCommon_clear(&(ptr->m_jpcommon));
            NJD_clear(&(ptr->m_njd));
            HTS_Engine_clear(&(ptr->m_engine));
            Mecab_clear(&(ptr->m_mecab));
            ptr->initialized = false;
        }

        xfree(ptr);
    }

    static VALUE open_jtalk_close(VALUE self)
    {
        struct open_jtalk *ptr;
        Data_Get_Struct(self, struct open_jtalk, ptr);

        if (ptr->initialized) {
            JPCommon_clear(&(ptr->m_jpcommon));
            NJD_clear(&(ptr->m_njd));
            HTS_Engine_clear(&(ptr->m_engine));
            Mecab_clear(&(ptr->m_mecab));
            ptr->initialized = false;
        }

        return Qnil;
    }

    static VALUE open_jtalk_alloc(VALUE klass)
    {
        struct open_jtalk *ptr = ALLOC(struct open_jtalk);
        Mecab_initialize(&(ptr->m_mecab));
        HTS_Engine_initialize(&(ptr->m_engine));
        NJD_initialize(&(ptr->m_njd));
        JPCommon_initialize(&(ptr->m_jpcommon));
        ptr->initialized = true;

        return Data_Wrap_Struct(klass, open_jtalk_mark, open_jtalk_free, ptr);
    }

    static double range(double value, double min, double max)
    {
        if (value > max)
            return max;
        else if (value < min)
            return min;
        else
            return value;
    }

    BOOL Mecab_load2(Mecab *m, const char *dicdir, const char *userdic){
        int i;
        int argc = 5;
        char **argv;

        if (m == NULL)
            return FALSE;

        if (m->mecab != NULL)
            Mecab_clear(m);

        if (dicdir == NULL || strlen(dicdir) == 0)
            return FALSE;

        argv = (char **) malloc(sizeof(char *) * argc);

        argv[0] = strdup("mecab");
        argv[1] = strdup("-d");
        argv[2] = strdup(dicdir);
        if (userdic) {
            argv[3] = strdup("-u");
            argv[4] = strdup(userdic);
        } else {
            argc = 3;
            argv[3] = NULL;
            argv[4] = NULL;
        }

        m->mecab = mecab_new(argc, argv);

        for (i = 0; i < argc; i++) {
            if (argv[i])
                free(argv[i]);
        }
        free(argv);

        if (m->mecab == NULL) {
            fprintf(stderr,"ERROR: Mecab_load() in mecab.cpp: Cannot open %s.\n", dicdir);
            return FALSE;
        }
        return TRUE;
    }

    static VALUE open_jtalk_load(VALUE klass, VALUE config)
    {
        Check_Type(config, T_HASH);

        VALUE self = rb_obj_alloc(klass);

        struct open_jtalk *ptr;
        Data_Get_Struct(self, struct open_jtalk, ptr);

        VALUE dicdir = rb_hash_lookup(config, rb_str_new2("dicdir"));
        char *dicdir_ptr = StringValueCStr(dicdir);
        VALUE userdic = rb_hash_lookup(config, rb_str_new2("userdic"));
        char *userdic_ptr = NULL;
        if (userdic != Qnil) {
            userdic_ptr = StringValueCStr(userdic);
        }
        if (Mecab_load2(&(ptr->m_mecab), dicdir_ptr, userdic_ptr) != TRUE) {
            open_jtalk_close(self);
            return Qnil;
        };

        VALUE model = rb_hash_lookup(config, rb_str_new2("model"));
        char *model_ptr = StringValueCStr(model);
        if(HTS_Engine_load(&(ptr->m_engine), &model_ptr, 1) != TRUE) {
            open_jtalk_close(self);
            return Qnil;
        }

        VALUE style = rb_hash_lookup(config, rb_str_new2("style"));
        if (style != Qnil) {
            VALUE interpolation0 = rb_hash_lookup(style, rb_str_new2("interpolation0"));
            if (interpolation0 != Qnil) {
                HTS_Engine_set_parameter_interpolation_weight(&(ptr->m_engine), 0, 0, NUM2DBL(interpolation0));
            }

            VALUE interpolation1 = rb_hash_lookup(style, rb_str_new2("interpolation1"));
            if (interpolation1 != Qnil) {
                HTS_Engine_set_parameter_interpolation_weight(&(ptr->m_engine), 1, 0, NUM2DBL(interpolation1));
            }

            VALUE duration = rb_hash_lookup(style, rb_str_new2("duration"));
            if (duration != Qnil) {
                HTS_Engine_set_duration_interpolation_weight(&(ptr->m_engine), 0, NUM2DBL(duration));
            }

            VALUE speed = rb_hash_lookup(style, rb_str_new2("speed"));
            if (speed != Qnil) {
                HTS_Engine_set_speed(&(ptr->m_engine),
                    range(NUM2DBL(speed), OPENJTALK_MINSPEED, OPENJTALK_MAXSPEED));
            }

            VALUE half_tone = rb_hash_lookup(style, rb_str_new2("half_tone"));
            if (half_tone != Qnil) {
                HTS_Engine_add_half_tone(&(ptr->m_engine),
                    range(NUM2DBL(half_tone), OPENJTALK_MINHALFTONE, OPENJTALK_MAXHALFTONE));
            }

            VALUE alpha = rb_hash_lookup(style, rb_str_new2("alpha"));
            if (alpha != Qnil) {
                HTS_Engine_set_alpha(&(ptr->m_engine),
                    range(NUM2DBL(alpha), OPENJTALK_MINALPHA, OPENJTALK_MAXALPHA));
            }

            VALUE volume = rb_hash_lookup(style, rb_str_new2("volume"));
            if (volume != Qnil) {
                HTS_Engine_set_volume(&(ptr->m_engine),
                    range(NUM2DBL(volume), OPENJTALK_MINVOLUME, OPENJTALK_MAXVOLUME));
            }

            VALUE sampling_fraquency = rb_hash_lookup(style, rb_str_new2("sampling_fraquency"));
            if (sampling_fraquency != Qnil) {
                HTS_Engine_set_sampling_frequency(&(ptr->m_engine), NUM2INT(sampling_fraquency));
            }

            VALUE frame_period = rb_hash_lookup(style, rb_str_new2("frame_period"));
            if (frame_period != Qnil) {
                HTS_Engine_set_fperiod(&(ptr->m_engine), NUM2INT(frame_period));
            }

            VALUE beta = rb_hash_lookup(style, rb_str_new2("beta"));
            if (beta != Qnil) {
                HTS_Engine_set_beta(&(ptr->m_engine), NUM2DBL(beta));
            }

            VALUE msd_threshold1 = rb_hash_lookup(style, rb_str_new2("msd_threshold1"));
            if (msd_threshold1 != Qnil) {
                HTS_Engine_set_msd_threshold(&(ptr->m_engine), 1, NUM2DBL(msd_threshold1));
            }

            VALUE gv_weight0 = rb_hash_lookup(style, rb_str_new2("gv_weight0"));
            if (gv_weight0 != Qnil) {
                HTS_Engine_set_gv_weight(&(ptr->m_engine), 0, NUM2DBL(gv_weight0));
            }

            VALUE gv_weight1 = rb_hash_lookup(style, rb_str_new2("gv_weight1"));
            if (gv_weight1 != Qnil) {
                HTS_Engine_set_gv_weight(&(ptr->m_engine), 1, NUM2DBL(gv_weight1));
            }

            VALUE audio_buff_size = rb_hash_lookup(style, rb_str_new2("audio_buff_size"));
            if (audio_buff_size != Qnil) {
                HTS_Engine_set_audio_buff_size(&(ptr->m_engine), NUM2INT(audio_buff_size));
            }
        }

        if (!rb_block_given_p()) {
            return self;
        }

        VALUE ret = rb_yield(self);
        open_jtalk_close(self);

        return ret;
    }

    static VALUE get_param(HTS_Engine *engine)
    {
        HTS_GStreamSet *gss = &engine->gss;
        // char data_01_04[] = { 'R', 'I', 'F', 'F' };
        // int data_05_08 = HTS_GStreamSet_get_total_nsamples(gss) * sizeof(short) + 36;
        // char data_09_12[] = { 'W', 'A', 'V', 'E' };
        // char data_13_16[] = { 'f', 'm', 't', ' ' };
        // int data_17_20 = 16;
        short data_21_22 = 1;        /* PCM */
        short data_23_24 = 1;        /* monoral */
        int data_25_28 = engine->condition.sampling_frequency;
        int data_29_32 = engine->condition.sampling_frequency * sizeof(short);
        short data_33_34 = sizeof(short);
        short data_35_36 = (short) (sizeof(short) * 8);
        // char data_37_40[] = { 'd', 'a', 't', 'a' };
        // int data_41_44 = HTS_GStreamSet_get_total_nsamples(gss) * sizeof(short);

        VALUE params = rb_hash_new();

        rb_hash_aset(params, rb_str_new2("compression_code"), INT2FIX(data_21_22));
        rb_hash_aset(params, rb_str_new2("number_of_channels"), INT2FIX(data_23_24));
        rb_hash_aset(params, rb_str_new2("sample_rate"), INT2FIX(data_25_28));
        rb_hash_aset(params, rb_str_new2("average_bytes_per_second"), INT2FIX(data_29_32));
        rb_hash_aset(params, rb_str_new2("block_align"), INT2FIX(data_33_34));
        rb_hash_aset(params, rb_str_new2("significant_bits_per_sample"), INT2FIX(data_35_36));
        rb_hash_aset(params, rb_str_new2("total_nsamples"), INT2FIX(HTS_GStreamSet_get_total_nsamples(gss)));

        return params;
    }

    static void put_as_little_endian(char* ptr, short value)
    {
        ptr[0] = (value) & 0x00FF;
        ptr[1] = (value >> 8) & 0x00FF;
    }

    static VALUE get_data(HTS_Engine *engine)
    {
        HTS_GStreamSet *gss = &engine->gss;
        size_t size = HTS_GStreamSet_get_total_nsamples(gss);
        char *raw_bytes = (char *)ruby_xmalloc(size * sizeof (short));

        double x;
        short temp;

        char *ptr = raw_bytes;
        for (size_t i = 0; i < size; i++) {
            x = HTS_GStreamSet_get_speech(gss, i);
            if (x > 32767.0)
                temp = 32767;
            else if (x < -32768.0)
                temp = -32768;
            else
                temp = (short) x;

            put_as_little_endian(ptr, temp);
            ptr += sizeof (short);
        }

        VALUE data = rb_str_new(raw_bytes, size * sizeof (short));
        ruby_xfree(raw_bytes);

        return data;
    }

    static VALUE open_jtalk_normalize_text(VALUE self, VALUE text)
    {
        Check_Type(text, T_STRING);

        struct open_jtalk *ptr;
        Data_Get_Struct(self, struct open_jtalk, ptr);
        if (!ptr->initialized) {
            VALUE klass = rb_const_get(rb_cObject, rb_intern("StandardError"));
            rb_raise(klass, "already closed");
            return Qnil;
        }

        char *text_ptr = StringValueCStr(text);
        size_t len = rb_str_strlen(text);
        char *buff = (char *)ruby_xmalloc(len * 4 + 1);
        text2mecab(buff, text_ptr);
        VALUE ret = rb_enc_str_new(buff, strlen(buff), rb_utf8_encoding());
        ruby_xfree(buff);

        return ret;
    }

    static VALUE open_jtalk_synthesis(VALUE self, VALUE text)
    {
        Check_Type(text, T_STRING);

        struct open_jtalk *ptr;
        Data_Get_Struct(self, struct open_jtalk, ptr);
        if (!ptr->initialized) {
            VALUE klass = rb_const_get(rb_cObject, rb_intern("StandardError"));
            rb_raise(klass, "already closed");
            return Qnil;
        }

        char *text_ptr = StringValueCStr(text);

        VALUE params = Qnil;
        VALUE data = Qnil;
        bool result = false;

        Mecab_analysis(&(ptr->m_mecab), text_ptr);
        mecab2njd(&(ptr->m_njd), Mecab_get_feature(&(ptr->m_mecab)), Mecab_get_size(&(ptr->m_mecab)));
        njd_set_pronunciation(&(ptr->m_njd));
        njd_set_digit(&(ptr->m_njd));
        njd_set_accent_phrase(&(ptr->m_njd));
        njd_set_accent_type(&(ptr->m_njd));
        njd_set_unvoiced_vowel(&(ptr->m_njd));
        njd_set_long_vowel(&(ptr->m_njd));
        njd2jpcommon(&(ptr->m_jpcommon), &(ptr->m_njd));
        JPCommon_make_label(&(ptr->m_jpcommon));
        if (JPCommon_get_label_size(&(ptr->m_jpcommon)) > 2) {
            if (HTS_Engine_synthesize_from_strings(&(ptr->m_engine),
                    JPCommon_get_label_feature(&(ptr->m_jpcommon)),
                    JPCommon_get_label_size(&(ptr->m_jpcommon))) == TRUE) {
                result = true;

                params = get_param(&(ptr->m_engine));
                data = get_data(&(ptr->m_engine));
            }

            HTS_Engine_refresh(&(ptr->m_engine));
        }
        JPCommon_refresh(&(ptr->m_jpcommon));
        NJD_refresh(&(ptr->m_njd));
        Mecab_refresh(&(ptr->m_mecab));

        VALUE ret = Qnil;
        if (result)
            ret = rb_ary_new3(2, params, data);
        return ret;
    }

    static VALUE open_jtalk_closed(VALUE self)
    {
        struct open_jtalk *ptr;
        Data_Get_Struct(self, struct open_jtalk, ptr);

        return ptr->initialized ? Qfalse : Qtrue;
    }

    static void open_jtalk_init(void)
    {
        VALUE klass;

        klass = rb_const_get(rb_cObject, rb_intern("OpenJtalk"));
        rb_define_singleton_method(klass, "load", VALUEFUNC(open_jtalk_load), 1);
        rb_define_alloc_func(klass, open_jtalk_alloc);
        rb_define_method(klass, "synthesis", VALUEFUNC(open_jtalk_synthesis), 1);
        rb_define_method(klass, "normalize_text", VALUEFUNC(open_jtalk_normalize_text), 1);
        rb_define_method(klass, "close", VALUEFUNC(open_jtalk_close), 0);
        rb_define_method(klass, "closed?", VALUEFUNC(open_jtalk_closed), 0);
    }
}

#ifdef __cplusplus
extern "C" {
#endif

void Init_open_jtalk(void)
{
    open_jtalk_init();
}

#ifdef __cplusplus
}
#endif
