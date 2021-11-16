From: Oskar Senft <osk@google.com>
Date: Tue, 16 Nov 2021 09:40:22 -0500
Subject: vga_pw sysfs file
Message-ID: <CABoTLcR2bHQCgV+ooVGE5GJ5NOeK1irDgg0P-rfErA=xbit0vg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi everyone

I'm currently upgrading from Linux kernel 4.10 to to 5.15 and found
that uart_render_controller [1] can no longer detect whether the host
is driving the Aspeed's VGA output.

I tracked it down to a difference on how the VGA scratch register used
to be read by aspeed-bmc-misc.c vs. how it's now read by the
aspeed_gfx_drv.c driver:
- In aspeed-bmc-misc.c we ended up with the full contents of SCU50 in sysfs.
- With aspeed_gfx_drv.c we now only get bit 0 [2]. Unfortunately, at
least in my BIOS, the VGA scratch register never has bit 0 set.

In uart_render_controller, however, we're checking whether the bottom
8 bit equal to 0xa8 (why are we not checking for != 0 here?)

For a test, I read both the SCU50 register via devmem as well as the
vga_pw sysfs file with this script: while true; do sleep 0.1; echo
$(cat /proc/uptime) - $(devmem 0x1e6e2050 32) - $(cat
/sys/devices/platform/ahb/ahb:apb/1e6e6000.display/vga_pw); done

# Host is powered on or is rebooted
1128.58 847.22 - 0x00000000
...
1159.38 853.16 - 0x00000000 - 0
1159.73 853.16 - 0x00000000 - 0
1159.98 853.16 - 0x00000000 - 0
1160.20 853.16 - 0x00000000 - 0

# BIOS starts VGA driver
1160.42 853.16 - 0x3F0A00A8 - 0
1160.68 853.16 - 0x3F0A00A8 - 0
1160.97 853.16 - 0x3F0A00A8 - 0
1161.20 853.16 - 0x3F0A00A8 - 0
1161.46 853.16 - 0x3F0A00A8 - 0
1161.68 853.16 - 0x3F0A00A8 - 0
1161.91 853.16 - 0x3F0A00A8 - 0

# VGA driver initialized
1162.26 853.16 - 0x3F0A0000 - 0
1162.56 853.16 - 0x3F0A0000 - 0
1162.77 853.25 - 0x3F0A0000 - 0
1162.96 853.31 - 0x3F0A0000 - 0
1163.17 853.38 - 0x3F0A0000 - 0
1163.41 853.43 - 0x3F0A0000 - 0
1163.72 853.50 - 0x3F0A0000 - 0
...

# Host powered off or is rebooted
1193.26 861.68 - 0x00000000 - 0
1193.58 861.76 - 0x00000000 - 0
1193.76 861.84 - 0x00000000 - 0
1193.94 861.94 - 0x00000000 - 0
1194.12 861.96 - 0x00000000 - 0
1194.33 862.00 - 0x00000000 - 0

As I understand, we want to detect the moment where the BIOS
initialized the VGA driver

To restore the previous functionality, the "easiest" option might be
to just return SCU50[31..0] as is, without trying to interpret it.

Another option would be to check whether it's != 0  (instead of & ) -
I think this would work in my example, too. If that's an option, I'll
test it.

For the check in [2], what BIOS was this tested with? Would a != 0
check work there?

Thanks
Oskar.

[1]: https://github.com/jk-ozlabs/uart-render-controller/tree/master
[2]: https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c#L294
