From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Jun 2021 09:50:09 +0200
Subject: [PATCH v5 00/10] ASPEED sgpio driver enhancement.
In-Reply-To: <20210610022416.GA27188@aspeedtech.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
 <CACRpkdZOStr+K9U9QTkAcsk4NxuSqBRVv_-9_VkGJbT69iSxmQ@mail.gmail.com>
 <20210610022416.GA27188@aspeedtech.com>
Message-ID: <CACRpkda60eB6i2+2MQFyhqYn4Q0WRGPPs91cu9K-g1maov61+w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 10, 2021 at 4:24 AM Steven Lee <steven_lee@aspeedtech.com> wrote:

> Per the comment in the following mail
> https://lkml.org/lkml/2021/6/9/317
>
> I was wondering if I should prepare v6 for the currnet solution or
> I should drop this patch series then prepare another patch for the
> new solution(piar GPIO input/output) which breaks userspace but is
> better than the current solution.

I would say just go ahead with the new solution. AFAIK Aspeed
has pretty tight control over what kind of userspace run on these
systems.

BTW please influence Aspeed to use the GPIO character device
and ligpiod
https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/
if you are doing any kind of userspace GPIO control (which I
suspect that you do).

Yours,
Linus Walleij
