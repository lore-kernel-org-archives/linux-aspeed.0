From: Oskar Senft <osk@google.com>
Date: Tue, 16 Nov 2021 19:54:20 -0500
Subject: vga_pw sysfs file
In-Reply-To: <4aa8906bdd429c878dd73139319e07f36ea584c2.camel@codeconstruct.com.au>
References: <CABoTLcR2bHQCgV+ooVGE5GJ5NOeK1irDgg0P-rfErA=xbit0vg@mail.gmail.com>
 <4aa8906bdd429c878dd73139319e07f36ea584c2.camel@codeconstruct.com.au>
Message-ID: <CABoTLcQ4VQCiEUyXtSQu-L4La=83btT4zB7iKBumtfH0V8eQpg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Jeremy, Thanks for the explanation!

I think the problem is that the gfx driver effectively changed the
semantic of the "vga_pw": In the past this was merely the contents of
said register. With the new driver, it claims to report "1" if the
host is driving the VGA, 0 otherwise. From what I can tell, it's not
possible to make such a statement just from the VGA scratch registers.
This is evident in that the uart_render_controller uses additional
signals (i.e. the "power" / run state of the host) to make a
determination on whether the host is driving VGA or not.

No that you mentioned it, I do remember from testing a couple of years
ago, that the register does not reliably return to 0 when the host is
rebooting.

With that, I suggest changing the gfx driver's "vga_pw" back to just
reporting the contents of the register and leaving it to a user space
process (like uart_render_controller) to use a variety of signals to
make a determination.

Joel, if I sent such a patch, would you accept that? If it's easier to
argue with the actual patch in hand, I'd be happy to prep it real
quick.

Thanks
Oskar.


On Tue, Nov 16, 2021 at 7:48 PM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> Hi Oskar,
>
> I think Joel will send some details on the gfx driver side, but:
>
> > In uart_render_controller, however, we're checking whether the bottom
> > 8 bit equal to 0xa8 (why are we not checking for != 0 here?)
>
> This is because we want to ensure that we're in the init process of the
> host-side GPU driver, and not some arbitrary other access; it's been a
> while since working on this, but I *think* I remember seeing other areas
> of the scratch reg at non-zero values (granted, not the lower 8 bits
> though...).
>
> [There was some discussion with aspeed about the init value
> of 0x0 not being guaranteed on some part of the scratch register
> interface, but I don't recall what that applied to]
>
> We could change this to != 0, but there's a solid convention that the
> host-side driver is writing 0xa8 as the first part of init, so I think
> the current behaviour would provide a more solid check.
>
> Cheers,
>
>
> Jeremy
>
