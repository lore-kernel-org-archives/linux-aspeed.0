From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 29 Jul 2019 08:51:23 +0800
Subject: [PATCH] drivers/tty/serial/8250: Make Aspeed VUART SIRQ
 polarity configurable
In-Reply-To: <CABoTLcTSFvQruPRnoRPgiWjOXNDOCSnAXVesG7f1WAuLLLVSSg@mail.gmail.com>
References: <20190727134242.49847-1-osk@google.com>
 <9fb8c99449cebd68fb5975890dedaa06ce7808ae.camel@kernel.crashing.org>
 <CABoTLcRPXffZuKy-DTFUVKJQRydSzMDynYRgBbZ_470iVN1KnA@mail.gmail.com>
 <CABoTLcTSFvQruPRnoRPgiWjOXNDOCSnAXVesG7f1WAuLLLVSSg@mail.gmail.com>
Message-ID: <6b31627a8c5a2616c83783550517961b7ed8f3cb.camel@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Oskar,

> For LPC, the polarity should be set to 1, for eSPI the default of 0 is
> correct.

Would there ever be a case where different SIRQs need different
polarities? If not, we may want this to be global, rather than for each
device (the VUART being one...)

Cheers,


Jeremy

