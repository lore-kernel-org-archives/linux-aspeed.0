From: Sergey Organov <sorganov@gmail.com>
Date: Fri, 23 Apr 2021 17:40:19 +0300
Subject: AW: [PATCH] soc: aspeed: fix a ternary sign expansion bug
In-Reply-To: <ebe4a1a6dd0748e28e6ca19aec20223e@bfs.de> (Walter Harms's message
 of "Fri, 23 Apr 2021 11:03:30 +0000")
References: <YIE90PSXsMTa2Y8n@mwanda>
 <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
 <877dktuvmz.fsf@osv.gnss.ru>
 <265e2d3accc74c89b5bab22eadb43808@AcuMS.aculab.com>
 <ebe4a1a6dd0748e28e6ca19aec20223e@bfs.de>
Message-ID: <878s59rrn0.fsf@osv.gnss.ru>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Walter Harms <wharms@bfs.de> writes:

> as indepentent observer,
> i would go for Dans solution:
>
> ret = kfifo_to_user();
> /* if an error occurs just return */
> if (ret)
>    return ret;
>
> /* otherwise return the copied number of bytes */
>
> return copied;
>
> there is no need for any deeper language knowledge,

Yep, but this is not idiomatic C, so one looking at this code would
tend to convert it back to ternary, and the actual problem here is that
the type of 'copied' does not match the return type of the function.

-- Sergey Organov
