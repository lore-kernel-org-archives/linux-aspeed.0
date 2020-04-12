From: Oskar Senft <osk@google.com>
Date: Sun, 12 Apr 2020 19:22:45 -0400
Subject: AST2600 clock gates
Message-ID: <CABoTLcTN4PnifNTeLp71cnT5Ej_+zVB7yfAPDnPXkGHA0OiUKA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey Joel and Andrew

I'm working on the AST2600 EVB trying to get some eSPI functionality to
work using
https://github.com/AspeedTech-BMC/linux/blob/aspeed-dev-v5.1/drivers/soc/aspeed/aspeed-espi.c.
The driver is missing support for clock enablement so I dug into how this
could be added.

I noticed that you guys worked on include/dt-bindings/clock/ast2600-clock.h
but from what I can tell the ASPEED_CLK_GATE_* definitions have not yet
been updated from AST2500 to AST2600.

Am I looking at the latest version of the file? I'm happy to update the
clock gate bits, but I don't want to duplicate work that you have in the
pipeline.

Thanks
Oskar.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200412/75661489/attachment.htm>
