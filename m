From: Steven Lee <steven_lee@aspeedtech.com>
Date: Thu, 10 Jun 2021 16:39:32 +0800
Subject: [PATCH v5 00/10] ASPEED sgpio driver enhancement.
In-Reply-To: <CACRpkda60eB6i2+2MQFyhqYn4Q0WRGPPs91cu9K-g1maov61+w@mail.gmail.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
 <CACRpkdZOStr+K9U9QTkAcsk4NxuSqBRVv_-9_VkGJbT69iSxmQ@mail.gmail.com>
 <20210610022416.GA27188@aspeedtech.com>
 <CACRpkda60eB6i2+2MQFyhqYn4Q0WRGPPs91cu9K-g1maov61+w@mail.gmail.com>
Message-ID: <20210610083932.GA30360@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 06/10/2021 15:50, Linus Walleij wrote:
> On Thu, Jun 10, 2021 at 4:24 AM Steven Lee <steven_lee@aspeedtech.com> wrote:
> 
> > Per the comment in the following mail
> > https://lkml.org/lkml/2021/6/9/317
> >
> > I was wondering if I should prepare v6 for the currnet solution or
> > I should drop this patch series then prepare another patch for the
> > new solution(piar GPIO input/output) which breaks userspace but is
> > better than the current solution.
> 
> I would say just go ahead with the new solution. AFAIK Aspeed
> has pretty tight control over what kind of userspace run on these
> systems.
> 
> BTW please influence Aspeed to use the GPIO character device
> and ligpiod
> https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/
> if you are doing any kind of userspace GPIO control (which I
> suspect that you do).
> 

We currently use gpioset and gpioget that provided by libgpiod to test
aspeed gpio and sgpio drivers.

For the current solution on AST2600,
the valid range of input pins  is 0 ~ 127,
the valid range of output pins is 128 ~ 255.
So we access input pins by the following command

```
gpioget $chipId 0 1 2 3 4 ... 127
```

and access output pins by the following command

```
gpioset $chipId 128=1 129=0 130=1 131=1 ... 255=1

```


The new solution will change the gpio id order as follows
Input:
```
gpioget $chipId 0 2 4 6 8 ... 254

```

Output:

```
gpioset $chipId 1=1 3=0 5=1 7=1 ... 255=1

```

Thanks,
Steven

> Yours,
> Linus Walleij
