From: Wolfram Sang <wsa@kernel.org>
Date: Wed, 27 Sep 2023 08:18:05 +0200
Subject: [External] Re: [PATCH] i2c: aspeed: Fix i2c bus hang in slave
 read
In-Reply-To: <CACPK8XeO404ok+B+k4U_bdFE3yYebzT-UNcTqcHStJfEnDh6jg@mail.gmail.com>
References: <20230810072155.3726352-1-zhangjian.3032@bytedance.com>
 <CACPK8XfWKLS_4nBC+NCSw=21iQeaHzBXOROmz9T+S0qZHCBKeg@mail.gmail.com>
 <CA+J-oUtxiQBOT+VM3fbOUM8HL5TX-C4HqtbbT__b4_KsGAJy1w@mail.gmail.com>
 <CACPK8XeO404ok+B+k4U_bdFE3yYebzT-UNcTqcHStJfEnDh6jg@mail.gmail.com>
Message-ID: <ZRPJHQXLb0nPUjwF@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel!

> Unfortunately, despite no acks from the maintainers, this patch has
> now been merged and backported to stable.

To explain my reasoning: given the list of unreviewed patches for
aspeed[1], I thought that the driver maintainers were busy or similar.
This happens all the time, so it would be no surprise. Andi is the
driver-comaintainer meanwhile, so an ack from him counts for me as well.

[1] http://patchwork.ozlabs.org/project/linux-i2c/list/?series=&submitter=&state=&q=aspeed&archive=&delegate=

> We should complete the fix, or revert it asap.

Agreed. We can always revert if you guys need more time fixing the issue
properly.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230927/b51529bd/attachment.sig>
