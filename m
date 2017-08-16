From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 16 Aug 2017 09:15:39 +0200
Subject: [PATCH] i2c: aspeed: Retain delay/setup/hold values when
 configuring bus frequency
In-Reply-To: <1502866778.4493.84.camel@kernel.crashing.org>
References: <20170815072102.23067-1-andrew@aj.id.au>
 <CACPK8XeNDxo14KRsAqo3a0Rs26h-1vRsLyqSX+bt2jfZHq=5yA@mail.gmail.com>
 <247768a3-074f-70ad-6132-39d1443ce210@kaod.org>
 <1502866778.4493.84.camel@kernel.crashing.org>
Message-ID: <7d2aa1d5-f3c7-4581-f7e8-36b1f9d4d80d@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 08:59 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2017-08-16 at 08:53 +0200, C=C3=A9dric Le Goater wrote:
>>>>          divisor =3D DIV_ROUND_UP(bus->parent_clk_frequency, bus->bus_=
frequency);
>>>> -       clk_reg_val =3D bus->get_clk_reg_val(divisor);
>>>> +       clk_reg_val =3D readl(bus->base + ASPEED_I2C_AC_TIMING_REG1);
>>>> +       clk_reg_val &=3D (ASPEED_I2CD_TIME_TBUF_MASK |
>>>> +                       ASPEED_I2CD_TIME_THDSTA_MASK |
>>>> +                       ASPEED_I2CD_TIME_TACST_MASK);
>>>
>>> Instead of keeping the u-boot values (which appear to be hard-coded),
>>> should we instead put the known working values in the register?
>>
>> Yes. I was wondering where the initial setting was from on the AST400.
>=20
> Well, the AST2500 hard codes them in HW, so it makes some amount of
> sense to use whatever aspeed platform.S hard codes in u-boot for the
> 2400. The values look reasonably sane.
>=20
> If we ever see a need to change them, we can add DT props etc... but
> for now I'd just not bother.
>=20
> The way it is now, at least, if I have problems, I can tweak the values
> with devmem and try again without the driver overwriting them :-)

ah yes. that is useful I agree.=20

C.
