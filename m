From: Joel Stanley <joel@jms.id.au>
Date: Mon, 23 Jul 2018 21:46:01 +0930
Subject: [PATCH 4/4] mtd: spi-nor: aspeed: introduce optimized settings
 for fast reads
In-Reply-To: <20180622121417.6762-5-clg@kaod.org>
References: <20180622121417.6762-1-clg@kaod.org>
 <20180622121417.6762-5-clg@kaod.org>
Message-ID: <CACPK8Xd0KeTpP+hbHXUDnu5-XzywX_ngCx_N-1Qcokavk5cw7w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22 June 2018 at 21:44, C?dric Le Goater <clg@kaod.org> wrote:
> Better settings for fast reads are looked for by implementing a SPI
> timing calibration sequence described in the Aspeed SoC specification
> document. The code is based on the OpenPOWER pflash tool and a similar
> sequence using DMAs can be found in the SDK U-Boot.
>
> The SPI calibration performs a loop on different SPI clock rates
> (dividers of the AHB clock rates) and on different input delay cycles
> for each SPI clock rates. The successive read results are compared to
> a golden buffer, read at low speed, to select the safest and fastest
> read settings for the chip.
>
> The "spi-max-frequency" property is used to cap the optimize read
> algorithm on some devices or controllers for which we want a "really"
> safe setting, on the FMC controller chips for instance.
>
> It can also be deactivated at boot time with a kernel parameter
> 'optimize_read', but that was never used on the field.
>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I have also been running these applied to a 4.17 base on ast2400 and
ast2500 systems for the past few months. This week I gave them a spin
on top of linux-next too.

They have looked good so far, so I would encourage the series to me
merged for 4.19 so we can reduce the number of out of tree we use in
OpenBMC systems.

For the series:

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
