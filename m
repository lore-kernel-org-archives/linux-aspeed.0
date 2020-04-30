From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 30 Apr 2020 20:55:48 +1000
Subject: [PATCH v0 linux master] i2c/busses: Avoid i2c interrupt status
 clear race condition.
In-Reply-To: <20200429090355.GA2891@kunai>
References: <20200429033737.2781-1-ryan_chen@aspeedtech.com>
 <20200429075357.GA1957@kunai>
 <56add9c6e6b5410986325a1360466e4b@TWMBX02.aspeed.com>
 <20200429090355.GA2891@kunai>
Message-ID: <232b9fac588beb4d024ab496b118c51af2b0ecba.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-04-29 at 11:03 +0200, Wolfram Sang wrote:
> > And is there maybe a Fixes: tag for it?
> > [Ryan Chen] Yes it is a fix patch.
> 
> I meant this (from submitting-patches.rst):

It fixes the original implementation of the driver basically. It's just
a classic posted-write fix. The write to clear the pending interrupt is
asynchronous, so you can get spurrious ones if you return from the
handler before it has percolated to the HW.

I assume it's just more visible on the 2600 because of the cores are
significantly faster but the IO bus is still as dumb.

Ryan: You could always add a Fixed-by: tag that specifies the commit
that added the initial driver...

Cheers,
Ben.

