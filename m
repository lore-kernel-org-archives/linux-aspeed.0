From: Joel Stanley <joel@jms.id.au>
Date: Wed, 23 Dec 2020 01:07:12 +0000
Subject: [PATCH 2/3] aspeed-video: clear spurious interrupt bits
 unconditionally
In-Reply-To: <20201222191433.3dgnfwyrod4tnvaf@hatter.bewilderbeest.net>
References: <20201215024542.18888-1-zev@bewilderbeest.net>
 <20201215024542.18888-3-zev@bewilderbeest.net>
 <CACPK8XczCUgqOENABoDbc-qwbMxOh=1OUyBtuHSmDG_Zo571Wg@mail.gmail.com>
 <20201222191433.3dgnfwyrod4tnvaf@hatter.bewilderbeest.net>
Message-ID: <CACPK8XeOZEkpAKcyhZLeMdGzbwtFmdGEnL6QXp0VK1HL_O2pSg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 22 Dec 2020 at 19:14, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Mon, Dec 21, 2020 at 10:47:37PM CST, Joel Stanley wrote:
> >On Tue, 15 Dec 2020 at 02:46, Zev Weiss <zev@bewilderbeest.net> wrote:
> >>
> >> Instead of testing and conditionally clearing them one by one, we can
> >> instead just unconditionally clear them all at once.
> >>
> >> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> >
> >I had a poke at the assembly and it looks like GCC is clearing the
> >bits unconditionally anyway, so removing the tests provides no change.
> >
> >Combining them is a good further optimization.
> >
> >Reviewed-by: Joel Stanley <joel@jms.id.au>
> >
> >A question unrelated to this patch: Do you know why the driver doesn't
> >clear the status bits in the interrupt handler? I would expect it to
> >write the value of sts back to the register to ack the pending
> >interrupt.
> >
>
> No, I don't, and I was sort of wondering the same thing actually -- I'm
> not deeply familiar with this hardware or driver though, so I was a bit
> hesitant to start messing with things.  (Though maybe doing so would
> address the "stickiness" aspect when it does manifest.)  Perhaps Eddie
> or Jae can shed some light here?

I think you're onto something here - this would be why the status bits
seem to stick until the device is reset.

Until Aspeed can clarify if this is a hardware or software issue, I
suggest we ack the bits and log a message when we see them, instead of
always ignoring them without taking any action.

Can you write a patch that changes the interrupt handler to ack status
bits as it handles each of them?

>
>
> Zev
>
