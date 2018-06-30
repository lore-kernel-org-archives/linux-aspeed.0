From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 30 Jun 2018 11:06:07 +1000
Subject: [RFC PATCH 01/14] devres: Add devm_of_iomap()
In-Reply-To: <CAHp75VfshFLuvOSB4deALX=EUf2Z_RW4Ct-K5cMsAj4yifF-cg@mail.gmail.com>
References: <20180622043134.18238-1-benh@kernel.crashing.org>
 <20180622043134.18238-2-benh@kernel.crashing.org>
 <CACRpkdbhxjahYaVnQN0xqD0NLPouO8VCW8w-GZD0sbLFtFtY5g@mail.gmail.com>
 <CAHp75VfshFLuvOSB4deALX=EUf2Z_RW4Ct-K5cMsAj4yifF-cg@mail.gmail.com>
Message-ID: <36f23db17a3d25e78e3387cc9d18fc66b4df74d1.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2018-06-29 at 23:27 +0300, Andy Shevchenko wrote:
> On Fri, Jun 29, 2018 at 12:14 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
> > I wonder if it is easy to find these cases and replace them with
> > this neat function...
> 
> Would be reasonable easy by using coccinelle.

For the obvious ones yes. A lot of the existing users of of_iomap
however don't do the request_region, and while they probably should and
should use the new accessor, this can't be done blindly without
testing, because there are many old things around that have broken
memory region tracking and that will fail..

I plan to do a sweep through some of my old powermac/powerpc stuff one
of these days and do some conversions.

Cheers,
Ben.

