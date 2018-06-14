From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Jun 2018 11:01:05 +0200
Subject: [PATCH 0/4] gpio: aspeed: Fixes and support for sharing with
 co-processor
In-Reply-To: <20180612001043.9327-1-benh@kernel.crashing.org>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
Message-ID: <CACRpkdazwQNYNZrSr_8szYKbWUKUmYr9RUP6D2KLZsk=MHmyBw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 12, 2018 at 2:10 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> This series cleans up the register accessors a bit, adds missing ones,
> fixes the access to the write latch and finally adds an interface
> that a co-processor driver can use to change the owner of some of
> the GPIO lines and arbitrate access to shared GPIO banks.

I'm pretty happy with the series as long as they have Joel's consent/ACK
which seems doable. See comment about using gpiolib internals which I
do not think is necessary.

Yours,
Linus Walleij
