From: Hongwei Zhang <hongweiz@ami.com>
Date: Tue, 30 Jul 2019 15:25:37 -0400
Subject: [v5 1/2] dt-bindings: gpio: aspeed: Add SGPIO support
In-Reply-To: <1563564291-9692-2-git-send-email-hongweiz@ami.com>
References: <1563564291-9692-2-git-send-email-hongweiz@ami.com>
Message-ID: <1564514737-4638-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Linus and Andrew,

Thanks for your detailed comments, I just submitted v6 of our update:
_http://patchwork.ozlabs.org/cover/1139035/
_http://patchwork.ozlabs.org/patch/1139038/
_http://patchwork.ozlabs.org/patch/1139040/

please ignore my previous patches sent on 07/28, they does not have proper serial
title and one of the patch is missing.

--Hongwei

> From:	Linus Walleij <linus.walleij@linaro.org>
> Sent:	Monday, July 29, 2019 5:57 PM
> To:	Andrew Jeffery
> Cc:	Hongwei Zhang; open list:GPIO SUBSYSTEM; Joel Stanley; open list:OPEN FIRMWARE AND 
> FLATTENED DEVICE TREE BINDINGS; linux-aspeed; Bartosz Golaszewski; Rob Herring; Mark Rutland; 
> linux-kernel at vger.kernel.org; Linux ARM
> Subject:	Re: [v5 1/2] dt-bindings: gpio: aspeed: Add SGPIO support
> 
> On Mon, Jul 29, 2019 at 2:19 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > The behaviour is to periodically emit the state of all enabled GPIOs 
> > (i.e. the ngpios value), one per bus clock cycle. There's no explicit 
> > addressing scheme, the protocol encodes the value for a given GPIO by 
> > its position in the data stream relative to a pulse on the "load data"
> > (LD) line, whose envelope covers the clock cycle for the last GPIO in 
> > the sequence. Similar to SPI the bus has both out and in lines, which 
> > cater to output/input GPIOs.
> >
> > A rough timing diagram for a 16-GPIO configuration looks like what 
> > I've pasted here:
> >
> > https://gist.github.com/amboar/c9543af1957854474b8c05ab357f0675
> 
> OK that is complex. I agree we need to keep this driver together.
> 
> Yours,
> Linus Walleij
