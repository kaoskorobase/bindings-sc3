#include <bindings.cmacros.h>
#include <SC_WorldOptions.h>
#include <SC_Reply.h>

enum {
    kOK
  , kError
};

typedef void (*HaskellPrintFunc)(const char* str);

static HaskellPrintFunc gHaskellPrintFunc = 0;

static int bindings_sc3_PrintFunc(const char* format, va_list ap)
{
    if (gHaskellPrintFunc == 0)
        return kError;

    const size_t bufSize = 1024;
    char* buf = (char*)malloc(bufSize*sizeof(char));
    if (buf == 0) return kError;

    int n = vsnprintf(buf, bufSize, format, ap);

    if (n >= bufSize) {
        // Try again
        char* newBuf = realloc(buf, n);
        if (newBuf == 0) {
            free(buf);
            return kError;
        }
        buf = newBuf;
        vsnprintf(buf, n, format, ap);
    }

    (*gHaskellPrintFunc)(buf);

    free(buf);

    return kOK;
}

void SetHaskellPrintFunc(HaskellPrintFunc func)
{
    gHaskellPrintFunc = func;
    SetPrintFunc(&bindings_sc3_PrintFunc);
}

const struct WorldOptions *inline_kDefaultWorldOptions(void)
{
    return &kDefaultWorldOptions;
}

void* ReplyAddress_ReplyData(const struct ReplyAddress *replyAddress)
{
    return replyAddress->mReplyData;
}
