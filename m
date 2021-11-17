From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 17 Nov 2021 08:47:51 +0800
Subject: vga_pw sysfs file
In-Reply-To: <CABoTLcR2bHQCgV+ooVGE5GJ5NOeK1irDgg0P-rfErA=xbit0vg@mail.gmail.com>
References: <CABoTLcR2bHQCgV+ooVGE5GJ5NOeK1irDgg0P-rfErA=xbit0vg@mail.gmail.com>
Message-ID: <4aa8906bdd429c878dd73139319e07f36ea584c2.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Oskar,

I think Joel will send some details on the gfx driver side, but:

> In uart_render_controller, however, we're checking whether the bottom
> 8 bit equal to 0xa8 (why are we not checking for != 0 here?)

This is because we want to ensure that we're in the init process of the
host-side GPU driver, and not some arbitrary other access; it's been a
while since working on this, but I *think* I remember seeing other areas
of the scratch reg at non-zero values (granted, not the lower 8 bits
though...).

[There was some discussion with aspeed about the init value
of 0x0 not being guaranteed on some part of the scratch register
interface, but I don't recall what that applied to]

We could change this to != 0, but there's a solid convention that the
host-side driver is writing 0xa8 as the first part of init, so I think
the current behaviour would provide a more solid check.

Cheers,


Jeremy

