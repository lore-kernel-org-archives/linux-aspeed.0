From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 15 Jun 2018 09:42:07 +1000
Subject: [PATCH 0/4] gpio: aspeed: Fixes and support for sharing with
 co-processor
In-Reply-To: <CACRpkdazwQNYNZrSr_8szYKbWUKUmYr9RUP6D2KLZsk=MHmyBw@mail.gmail.com>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
 <CACRpkdazwQNYNZrSr_8szYKbWUKUmYr9RUP6D2KLZsk=MHmyBw@mail.gmail.com>
Message-ID: <d2f3aaf1d56c85d20235d1b68865e799f27a801a.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2018-06-14 at 11:01 +0200, Linus Walleij wrote:
> On Tue, Jun 12, 2018 at 2:10 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> 
> > This series cleans up the register accessors a bit, adds missing ones,
> > fixes the access to the write latch and finally adds an interface
> > that a co-processor driver can use to change the owner of some of
> > the GPIO lines and arbitrate access to shared GPIO banks.
> 
> I'm pretty happy with the series as long as they have Joel's consent/ACK
> which seems doable. See comment about using gpiolib internals which I
> do not think is necessary.

Thanks. Yes I need to address Joel's comments, I was waiting for your
review before posting a v2.

As for the gpiolib internals, it's unfortunate, see my other email, I'm
happy to change that if you can suggest an alternative approach...

Cheers,
Ben.

