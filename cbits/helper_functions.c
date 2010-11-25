#include <bindings.cmacros.h>
#include <SC_WorldOptions.h>
#include <SC_Reply.h>

const struct WorldOptions *inline_kDefaultWorldOptions(void)
{
	return &kDefaultWorldOptions;
}

void* ReplyAddress_ReplyData(const struct ReplyAddress *replyAddress)
{
	return replyAddress->mReplyData;
}
