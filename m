From: Alexander A. Filippov <a.filippov@yadro.com>
Date: Fri, 10 Apr 2020 17:59:04 +0300
Subject: [PATCH] ARM: DTS: Aspeed: Add YADRO Nicole BMC
In-Reply-To: <ad46ff33-8ce2-4ffa-b12e-204053e4f705@www.fastmail.com>
References: <20200406101553.28958-1-a.filippov@yadro.com>
 <ad46ff33-8ce2-4ffa-b12e-204053e4f705@www.fastmail.com>
Message-ID: <20200410145904.GA15615@bbwork.lan>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 10, 2020 at 02:29:47PM +0930, Andrew Jeffery wrote:
> 
> 
> > +&i2c11 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c12 {
> > +	status = "okay";
> > +};
> 
> Are you accessing devices on the busses from userspace? It would
> be helpful to comment here why you're enabling all of these busses
> but not describing any devices on them, if it's necessary to enable
> them at all.
> 

Yes, some of them are unused and may be removed.
For others I'll add comments in the next version.

> > +
> > +&adc {
> > +	status = "okay";
> 
> You should specify the pinmux configuration for the channels you're using
> to ensure exclusive access to those pins (otherwise they could be exported
> e.g. as GPIOs).

It was just copied from Romulus and looks like I missed iio-hwmon-battery.
Is it what you meant?

All other pins are wired to the ground.`


Alexander
