From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 21 Sep 2018 15:30:42 -0700
Subject: [PATCH v2] i2c: aspeed: fix invalid clock parameters for very
 large divisors
In-Reply-To: <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
References: <20180921221025.75003-1-brendanhiggins@google.com>
 <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
Message-ID: <CAFd5g46==5HG2stvuVfOUtsSW37SvLN6cCmOhRSxibrUpxb8aA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 21, 2018 at 3:26 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
<snip>
>
> > +     if (base_clk_divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
> > +             base_clk_divisor = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
> > +             clk_low = clk_high_low_mask;
> > +             clk_high = clk_high_low_mask;
> > +             dev_err(dev,
> > +                     "clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.",
>
> Please put a newline character at the end of the string.

I always forget to do that. I wonder if anyone has considered adding a
warning for this to checkpatch?

>
> Thanks,
> Jae
>
> [....]
