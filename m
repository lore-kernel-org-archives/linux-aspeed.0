From: Joe Perches <joe@perches.com>
Date: Sat, 22 Sep 2018 07:16:58 -0700
Subject: [PATCH v2] i2c: aspeed: fix invalid clock parameters for very
 large divisors
In-Reply-To: <CAFd5g46==5HG2stvuVfOUtsSW37SvLN6cCmOhRSxibrUpxb8aA@mail.gmail.com>
References: <20180921221025.75003-1-brendanhiggins@google.com>
 <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
 <CAFd5g46==5HG2stvuVfOUtsSW37SvLN6cCmOhRSxibrUpxb8aA@mail.gmail.com>
Message-ID: <a31b639d4415d6edd4174b3d4b71528ec94ad10a.camel@perches.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2018-09-21 at 15:30 -0700, Brendan Higgins wrote:
> On Fri, Sep 21, 2018 at 3:26 PM Jae Hyun Yoo
[]
> > > +             dev_err(dev,
> > > +                     "clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.",
> > 
> > Please put a newline character at the end of the string.
> 
> I always forget to do that. I wonder if anyone has considered adding a
> warning for this to checkpatch?

Yes, but it's not possible to know when there
a pr_cont that follows so any checkpatch test
would be a false positive generator too.

