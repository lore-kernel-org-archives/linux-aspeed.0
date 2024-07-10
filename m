From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Jul 2024 14:06:34 -0000
Subject: [PATCH 5/9] ARM: defconfig: convert to MTD_EEPROM_AT24
In-Reply-To: <CAMRc=McvRLeCTTXgC_OD5z5OAxQ0pZ46dTKP8XO+T-LkXKgRfQ@mail.gmail.com>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
 <20240701-b4-v6-10-topic-usbc-tcpci-v1-5-3fd5f4a193cc@pengutronix.de>
 <27cf3056-5c7b-4759-b03a-1fa9b785611e@app.fastmail.com>
 <CAMRc=McvRLeCTTXgC_OD5z5OAxQ0pZ46dTKP8XO+T-LkXKgRfQ@mail.gmail.com>
Message-ID: <64662665-929e-4d95-a9ac-c8f66bd83168@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 10, 2024, at 14:59, Bartosz Golaszewski wrote:
> On Wed, Jul 10, 2024 at 2:49?PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Mon, Jul 1, 2024, at 15:53, Marco Felsch wrote:
>> > The EEPROM_AT24 Kconfig symbol is marked as deprecated. Make use of the
>> > new Kconfig symbol to select the I2C EEPROM driver support.
>> >
>> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>> > ---
>> >  arch/arm/configs/aspeed_g4_defconfig   | 2 +-
>> >  arch/arm/configs/aspeed_g5_defconfig   | 2 +-
>> >  arch/arm/configs/at91_dt_defconfig     | 2 +-
>> >  arch/arm/configs/axm55xx_defconfig     | 2 +-
>> >  arch/arm/configs/davinci_all_defconfig | 2 +-
>> >  arch/arm/configs/imx_v4_v5_defconfig   | 2 +-
>> >  arch/arm/configs/imx_v6_v7_defconfig   | 2 +-
>> >  arch/arm/configs/ixp4xx_defconfig      | 2 +-
>> >  arch/arm/configs/keystone_defconfig    | 2 +-
>> >  arch/arm/configs/lpc18xx_defconfig     | 2 +-
>>
>> Applied to soc/defconfig, thanks
>
> No! Why? This is still being discussed and it's not clear it will even
> make it upstream.

Ok, dropped again, thanks for catching this.

     Arnd
