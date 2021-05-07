From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 7 May 2021 12:57:20 -0700
Subject: [PATCH v2] i2c: aspeed: disable additional device addresses on
 ast2[56]xx
In-Reply-To: <20210506205419.26294-1-zev@bewilderbeest.net>
References: <20210506205419.26294-1-zev@bewilderbeest.net>
Message-ID: <CAFd5g46TEFLWdBN80RxGwZfoyD-70C0pP59mhrynvD5ODd2wrg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 6, 2021 at 1:54 PM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> The ast25xx and ast26xx have, respectively, two and three configurable
> slave device addresses to the ast24xx's one.  We only support using
> one at a time, but the others may come up in an indeterminate state
> depending on hardware/bootloader behavior, so we need to make sure we
> disable them so as to avoid ending up with phantom devices on the bus.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Looks great! No concerns from me.

Nevertheless, I am not in a position to test this at this time. Joel,
or Andrew could one of you (or someone else on the mailing list) test
this?

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
