From: Alexander A. Filippov <a.filippov@yadro.com>
Date: Thu, 30 May 2019 17:31:10 +0300
Subject: [PATCH] ARM: dts: aspeed: Add YADRO VESNIN BMC
In-Reply-To: <CACPK8XfG7j4Z2bqX9CFxUeUrpx708Uqbh-5ts9W5SnDfDw-xYA@mail.gmail.com>
References: <20190530093948.12479-1-a.filippov@yadro.com>
 <CACPK8XfG7j4Z2bqX9CFxUeUrpx708Uqbh-5ts9W5SnDfDw-xYA@mail.gmail.com>
Message-ID: <20190530143110.GA24059@bbwork.lan>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 30, 2019 at 02:16:59PM +0000, Joel Stanley wrote:
> On Thu, 30 May 2019 at 09:40, Alexander Filippov <a.filippov@yadro.com> wrote:
> > @@ -0,0 +1,262 @@
> 
> Can we get a SDPX license string at the top of the file? Something like this:
> 
> // SPDX-License-Identifier: GPL-2.0+
> // Copyright 2019 <copyright holder>

Sure, on my way.

> 
> > +/dts-v1/;
> > +
> > +#include "aspeed-g4.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +
> 
> > +&i2c3 {
> > +       status = "okay";
> > +       cpr2021 at 59 {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               compatible = "general,cpr2021", "general,pmbus";
> 
> Do you have a driver for this one you plan on submitting?

Yes, we plan but not right now. I remove it now and it will be added when the
driver will be ready.
