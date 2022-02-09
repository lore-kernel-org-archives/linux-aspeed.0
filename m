From: POTIN LAI <potin.lai@quantatw.com>
Date: Thu, 10 Feb 2022 00:46:27 +0800
Subject: [PATCH v3 1/1] arch: arm: dts: update bletchley dts
In-Reply-To: <CAL_JsqLM552FjvjdECq56kYsx9+mPuyvpUNibtuH--pgyF4pDQ@mail.gmail.com>
References: <20220209100413.23714-1-potin.lai@quantatw.com>
 <CAL_JsqLM552FjvjdECq56kYsx9+mPuyvpUNibtuH--pgyF4pDQ@mail.gmail.com>
Message-ID: <8016293e-5100-1cda-89ea-8a9b5491132a@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Rob Herring ? 9/02/2022 11:33 pm ??:
> On Wed, Feb 9, 2022 at 4:04 AM Potin Lai <potin.lai@quantatw.com> wrote:
>> updates:
>> * seperate leds into multiple groups
>> * switch sled numbering to 1-based
>> * disable inchip rtc
>> * add flash1 in fmc
>> * switch spi2 pnor using spi-gpio
>> * update gpio-line-names
>> * add interrupt pin for each sledx_ioexp
>> * enable mdio3
>> * update ADM1278 shunt resistor (300 micro Ohm)
>> * add INA230 for each sled
> Please read documentation on writing commit messages. Answer why you
> are making the change, not what you are changing.
>
> Each bullet should probably be a separate commit. The question to
> answer is are there compatibility issues (what happens with old DT and
> new kernel and vice-versa)?
>
> Rob
Thank you very much for advising, will update this patch in new patch series.

Potin
