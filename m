From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Nov 2021 00:57:11 +0000
Subject: vga_pw sysfs file
In-Reply-To: <CABoTLcR2bHQCgV+ooVGE5GJ5NOeK1irDgg0P-rfErA=xbit0vg@mail.gmail.com>
References: <CABoTLcR2bHQCgV+ooVGE5GJ5NOeK1irDgg0P-rfErA=xbit0vg@mail.gmail.com>
Message-ID: <CACPK8Xc_B4T-xAcQ7sSqOuVLpwBw69mmj7=5T_opr2AqUs7ThQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Oskar,

On Tue, 16 Nov 2021 at 14:40, Oskar Senft <osk@google.com> wrote:
>
> Hi everyone
>
> I'm currently upgrading from Linux kernel 4.10 to to 5.15 and found
> that uart_render_controller [1] can no longer detect whether the host
> is driving the Aspeed's VGA output.
>
> I tracked it down to a difference on how the VGA scratch register used
> to be read by aspeed-bmc-misc.c vs. how it's now read by the
> aspeed_gfx_drv.c driver:
> - In aspeed-bmc-misc.c we ended up with the full contents of SCU50 in sysfs.
> - With aspeed_gfx_drv.c we now only get bit 0 [2]. Unfortunately, at
> least in my BIOS, the VGA scratch register never has bit 0 set.
>
> In uart_render_controller, however, we're checking whether the bottom
> 8 bit equal to 0xa8 (why are we not checking for != 0 here?)

I think you found a mistake in the new sysfs file. I can't recall why
I masked the value the way I did.

> To restore the previous functionality, the "easiest" option might be
> to just return SCU50[31..0] as is, without trying to interpret it.

I think we will go with this option. This remains compatible with the
uart_render_controller code, which is our only known user of the file.

>
> Another option would be to check whether it's != 0  (instead of & ) -
> I think this would work in my example, too. If that's an option, I'll
> test it.
>
> For the check in [2], what BIOS was this tested with? Would a != 0
> check work there?

I would have tested it with a Power9 host, which doesn't run the BIOS
and relies on the "ast" DRM driver to perform the setup. Looking at
that driver it calls ast_open_key which writes 0xa8:

https://elixir.bootlin.com/linux/v5.15/source/drivers/gpu/drm/ast/ast_drv.h#L265

I suspect my testing was bad.

Thanks for investigating this. I'll send a patch to the kernel and if
you could test it that would be appreciated.

Cheers,

Joel
