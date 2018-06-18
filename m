From: Joel Stanley <joel@jms.id.au>
Date: Mon, 18 Jun 2018 15:08:44 +0930
Subject: [PATCH v2 4/4] gpio: aspeed: Add interfaces for co-processor to
 grab GPIOs
In-Reply-To: <20180618045352.9489-5-benh@kernel.crashing.org>
References: <20180618045352.9489-1-benh@kernel.crashing.org>
 <20180618045352.9489-5-benh@kernel.crashing.org>
Message-ID: <CACPK8Xd93hSFFY8fMcVTd3pRK5Pd4s1Vdgo9SXoEY0_Z_Y-Ctw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18 June 2018 at 14:23, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On the Aspeed chip, the GPIOs can be under control of the ARM
> chip or of the ColdFire coprocessor. (There's a third command
> source, the LPC bus, which we don't use or support yet).
>
> The control of which master is allowed to modify a given
> GPIO is per-bank (8 GPIOs).
>
> Unfortunately, systems already exist for which we want to
> use GPIOs of both sources in the same bank.
>
> This provides an API exported by the gpio-aspeed driver
> that an aspeed coprocessor driver can use to "grab" some
> GPIOs for use by the coprocessor, and allow the coprocessor
> driver to provide callbacks for arbitrating access.
>
> Once at least one GPIO of a given bank has been "grabbed"
> by the coprocessor, the entire bank is marked as being
> under coprocessor control. It's command source is switched
> to the coprocessor.
>
> If the ARM then tries to write to a GPIO in such a marked bank,
> the provided callbacks are used to request access from the
> coprocessor driver, which is responsible to doing whatever
> is necessary to "pause" the coprocessor or prevent it from
> trying to use the GPIOs while the ARM is doing its accesses.
>
> During that time, the command source for the bank is temporarily
> switched back to the ARM.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I did some playing around with the consumer.h include and I couldn't
see an easy way out of this either.

Reviewed-by: Joel Stanley <joel@jms.id.au>
